#!/bin/bash
set -e
PLATFORM=$(uname)
SITEPACKAGES="${PREFIX}/lib/python2.7/site-packages"

if (( $PLATFORM == 'Linux' )); then
echo "
git+https://github.com/insilichem/gaudiview.git
git+https://github.com/insilichem/plume_bondorder.git
git+https://github.com/insilichem/plume_dummyatoms.git
git+https://github.com/insilichem/plume_cauchian.git
git+https://github.com/insilichem/plume_nciplot.git
git+https://github.com/insilichem/plume_normalmodes.git
git+https://github.com/insilichem/plume_openmmgui.git
git+https://github.com/insilichem/plume_orbitraj.git
git+https://github.com/insilichem/plume_plipgui.git
git+https://github.com/insilichem/plume_popmusicgui.git
git+https://github.com/insilichem/plume_propkagui.git
git+https://github.com/insilichem/libplume.git
git+https://github.com/insilichem/plume_selection.git
git+https://github.com/insilichem/plume_subalign.git
git+https://github.com/insilichem/plume_snfg.git
git+https://github.com/insilichem/plume_vinarelaunch.git
" > requirements.txt;
else
echo "
git+https://github.com/insilichem/gaudiview.git
git+https://github.com/insilichem/plume_bondorder.git
git+https://github.com/insilichem/plume_dummyatoms.git
git+https://github.com/insilichem/plume_cauchian.git
git+https://github.com/insilichem/plume_nciplot.git
git+https://github.com/insilichem/plume_openmmgui.git
git+https://github.com/insilichem/plume_orbitraj.git
git+https://github.com/insilichem/plume_popmusicgui.git
git+https://github.com/insilichem/plume_propkagui.git
git+https://github.com/insilichem/libplume.git
git+https://github.com/insilichem/plume_selection.git
git+https://github.com/insilichem/plume_subalign.git
git+https://github.com/insilichem/plume_snfg.git
git+https://github.com/insilichem/plume_vinarelaunch.git
" > requirements.txt;
fi

echo "installing: Plume Suite extensions with pip ..."
${PREFIX}/bin/pip install -q --process-dependency-links -U -t $SITEPACKAGES --trusted-host download.sourceforge.net -r requirements.txt

if (( $PLATFORM == 'Linux' )); then
${PREFIX}/bin/pip install -q --no-deps -U https://github.com/ssalentin/plip/archive/v1.3.3.zip -t $SITEPACKAGES
fi

mkdir -p "$PREFIX/etc/activate.d/"
mkdir -p "$PREFIX/etc/deactivate.d/"

# Bash
echo "#!/bin/bash" >> "$PREFIX/etc/activate.d/plume.sh"
echo "export AMBERHOME=$PREFIX" >> "$PREFIX/etc/activate.d/plume.sh"
echo "export NCIPLOT_HOME=$PREFIX/etc/nciplot" >> "$PREFIX/etc/activate.d/plume.sh"
echo "#!/bin/bash" >> "$PREFIX/etc/deactivate.d/plume.sh"
echo "unset AMBERHOME" >> "$PREFIX/etc/deactivate.d/plume.sh"
echo "unset NCIPLOT_HOME" >> "$PREFIX/etc/deactivate.d/plume.sh"
# Fish
echo "#!/usr/bin/fish" >> "$PREFIX/etc/activate.d/plume.fish"
echo "set -gx AMBERHOME $PREFIX" >> "$PREFIX/etc/activate.d/plume.fish"
echo "set -gx NCIPLOT_HOME $PREFIX/etc/nciplot" >> "$PREFIX/etc/activate.d/plume.fish"
echo "#!/usr/bin/fish" >> "$PREFIX/etc/deactivate.d/plume.fish"
echo "set -e AMBERHOME" >> "$PREFIX/etc/deactivate.d/plume.fish"
echo "set -e NCIPLOT_HOME" >> "$PREFIX/etc/deactivate.d/plume.fish"

echo "Registering extensions in UCSF Chimera..."
$PREFIX/bin/pychimera -c "import chimera; chimera.extension.manager.addDirectory(\"$SITEPACKAGES\", True)" || exit_code=$?
if (( exit_code > 0 )) ; then
    echo "  Could not register extensions automatically!"
    echo "  You might need to add them manually via Preferences> Tools dialog."
    echo "  Use this location: $SITEPACKAGES"
fi

# Chimera's Numpy is old. Offer and update exposing the cons.
NPVERSION=$(chimera --nogui --script <(echo "import numpy as np; print(np.__version__)") 2> /dev/null)
if $(${PREFIX}/bin/python -c "from distutils.version import LooseVersion as V; print(str(V('$NPVERSION') < V('1.12')).lower())"); then
    echo -n "
Your UCSF Chimera installation is using and old Numpy version ($NPVERSION).
This can cause problems with most of our extensions. You can update now, but
please notice that:
    - Upgrading NumPy will cause MMTK to stop working, which means that
      the built-in extensions relying on it (Molecular Dynamics) will not work.
We do offer replacements for those (Plume OpenMM GUI) that offer similar
functionality. And, if you ever want to use MMTK in the future, you can download
UCSF Chimera again and make a separate, unmodified, installation.
Do you want to upgrade UCSF Chimera's Numpy now? Answer ([y]/n): "
    read choice
    case "$choice" in
        ""|y|Y )
            echo "Upgrading Numpy..."
            $PREFIX/bin/pip -q install -U 'numpy==1.11.*' -t `$PREFIX/bin/pychimera --path`/lib/python2.7/site-packages
            ;;
        * )
            echo "Ok! If you ever want to update it yourself, run this:"
            echo "  pip install -U 'numpy==1.11.*' -t \`pychimera --path\`/lib/python2.7/site-packages"
            ;;
    esac
fi

# SUCCESS GREETING
echo "
---------------------------------------------------------
  Done! Most of the interfaces will be available now!
  However, some of them will require you to activate a
  conda environment with:

      conda activate $PREFIX

  and then launch a patched UCSF Chimera instance with:

      pychimera --gui

  If you ever need to update an extension, use this
  command with the plume env activated:

      pip install -t $SITEPACKAGES -U <package name or URL>

  Thanks for installing Plume Suite!
---------------------------------------------------------
"