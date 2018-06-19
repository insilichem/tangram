#!/bin/bash
set -e
PLATFORM=$(uname)
SITEPACKAGES="${PREFIX}/lib/python2.7/site-packages"

echo "installing: Tangram Suite extensions with pip ..."
cat << EOF > requirements.txt;
pychimera
ommprotocol
git+https://github.com/insilichem/gaudiview.git
git+https://github.com/insilichem/tangram_bondorder.git
git+https://github.com/insilichem/tangram_dummyatoms.git
git+https://github.com/insilichem/tangram_cauchian.git
git+https://github.com/insilichem/tangram_nciplot.git
git+https://github.com/insilichem/tangram_openmmgui.git
git+https://github.com/insilichem/tangram_orbitraj.git
git+https://github.com/insilichem/tangram_popmusicgui.git
git+https://github.com/insilichem/tangram_propkagui.git
git+https://github.com/insilichem/libtangram.git
git+https://github.com/insilichem/tangram_selection.git
git+https://github.com/insilichem/tangram_subalign.git
git+https://github.com/insilichem/tangram_snfg.git
git+https://github.com/insilichem/tangram_vinarelaunch.git
EOF
# These are not available in Mac OS
if (( PLATFORM == 'Linux' )); then
cat << EOF >> requirements.txt
# Linux only
git+https://github.com/insilichem/tangram_normalmodes.git
git+https://github.com/insilichem/tangram_plipgui.git
EOF
"${PREFIX}/bin/pip" -q install -U --no-deps https://github.com/ssalentin/plip/archive/v1.3.3.zip
fi
"${PREFIX}/bin/pip" -q install -r requirements.txt \
                               --upgrade \
                               --process-dependency-links \
                               --trusted-host download.sourceforge.net \
                               --ignore-installed

# Env activation / deactivation scripts
mkdir -p "$PREFIX/etc/conda/activate.d/" "$PREFIX/etc/conda/deactivate.d/"

# Bash
cat << EOF > "$PREFIX/etc/conda/activate.d/tangram.sh"
#!/bin/bash
export AMBERHOME=$PREFIX
export NCIPLOT_HOME=$PREFIX/etc/nciplot
EOF
cat << "EOF" >> "$PREFIX/etc/conda/activate.d/tangram.sh"
tangram (){
    echo "
     _____  _    _   _  ____ ____      _    __  __
    |_   _|/ \  | \ | |/ ___|  _ \    / \  |  \/  |
      | | / _ \ |  \| | |  _| |_) |  / _ \ | |\/| |
      | |/ ___ \| |\  | |_| |  _ <  / ___ \| |  | |
      |_/_/   \_\_| \_|\____|_| \_\/_/   \_\_|  |_|

 Tangram suite -- https://github.com/insilichem/tangram

 Launching UCSF Chimera via pychimera...
"
    pychimera --gui $@
}
tangram_update () {
    if [[ $# -eq 0 ]] ; then
        echo 'Usage: tangram_update extension_name [extension_name2 ...]'
        return 1
    fi
    for repo in "$@"; do
        pip install git+https://github.com/insilichem/${repo}.git
    done
}
tangram_openbabel () {
    echo "Uninstalling RDKit and installing OpenBabel"
    echo "PLIP will work now, but subalign will not!"
    conda remove --force rdkit
    conda install -c openbabel openbabel
}

tangram_rdkit () {
    echo "Uninstalling OpenBabel and installing RDKit"
    echo "subalign will work now, but PLIP will not!"
    conda remove --force openbabel
    conda install rdkit
}

EOF
"EOF" > /dev/null 2>&1 || true  # fix vscode syntax recognition...

cat << EOF > "$PREFIX/etc/conda/deactivate.d/tangram.sh"
#!/bin/bash
unset AMBERHOME
unset NCIPLOT_HOME
unset -f tangram
unset -f tangram_update
unset -f tangram_openbabel
unset -f tangram_rdkit
EOF

# Fish
cat << EOF > "$PREFIX/etc/conda/activate.d/tangram.fish"
#!/usr/bin/fish
set -gx AMBERHOME $PREFIX
set -gx NCIPLOT_HOME $PREFIX/etc/nciplot
EOF
cat << "EOF" >> "$PREFIX/etc/conda/activate.d/tangram.fish"
function tangram --description "Launches patched UCSF Chimera"
    echo "
     _____  _    _   _  ____ ____      _    __  __
    |_   _|/ \  | \ | |/ ___|  _ \    / \  |  \/  |
      | | / _ \ |  \| | |  _| |_) |  / _ \ | |\/| |
      | |/ ___ \| |\  | |_| |  _ <  / ___ \| |  | |
      |_/_/   \_\_| \_|\____|_| \_\/_/   \_\_|  |_|

 Tangram suite -- https://github.com/insilichem/tangram

 Launching UCSF Chimera via pychimera...
"
    pychimera --gui $argv
end
function tangram_update --description "Updates Tangram Suite packages"
    if test (count $argv) -eq 0
        echo 'Usage: tangram_update extension_name [extension_name2 ...]'
        return 1
    end
    for repo in $argv
        pip install -U git+https://github.com/insilichem/"$repo".git
    end
end
function tangram_openbabel --description "Edit environment to use openbabel"
    echo "Uninstalling RDKit and installing OpenBabel"
    echo "PLIP will work now, but subalign will not!"
    conda remove --force rdkit
    conda install -c openbabel openbabel
end
function tangram_rdkit --description "Edit environment to use rdkit"
    echo "Uninstalling OpenBabel and installing RDKit"
    echo "subalign will work now, but PLIP will not!"
    conda remove --force openbabel
    conda install rdkit
end
EOF
"EOF" > /dev/null 2>&1 || true  # fix vscode syntax recognition...

cat << EOF > "$PREFIX/etc/conda/deactivate.d/tangram.fish"
#!/usr/bin/fish
set -e AMBERHOME
set -e NCIPLOT_HOME
functions -e tangram
functions -e tangram_update
functions -e tangram_openbabel
functions -e tangram_rdkit
EOF

echo "Registering extensions in UCSF Chimera..."
"$PREFIX/bin/pychimera" -c "import chimera; chimera.extension.manager.addDirectory(\"$SITEPACKAGES\", True)" || exit_code=$?
if (( exit_code > 0 )) ; then
    echo "  Could not register extensions automatically!"
    echo "  You might need to add them manually via Preferences> Tools dialog."
    echo "  Use this location: $SITEPACKAGES"
fi

# Chimera's Numpy is old. Offer and update exposing the cons.
NPVERSION=$(chimera --nogui --script <(echo "import numpy as np; print(np.__version__)") 2> /dev/null) || true
if $(${PREFIX}/bin/python -c "from distutils.version import LooseVersion as V; print(str(V('$NPVERSION') < V('1.11')).lower())"); then
    echo -n "
Your UCSF Chimera installation is using an old Numpy version ($NPVERSION).
This can cause problems with most of our extensions. You can update now, but
please notice that:
    - Upgrading NumPy will cause MMTK to stop working, which means that
      the built-in extensions relying on it (Molecular Dynamics) will not work.
We do offer replacements for those (Tangram OpenMM GUI) that offer similar
functionality. And, if you ever want to use MMTK in the future, you can download
UCSF Chimera again and make a separate, unmodified, installation.
Do you want to upgrade UCSF Chimera's Numpy now? Answer ([y]/n): "
    read -r choice
    case "$choice" in
        ""|y|Y )
            echo "Upgrading Numpy..."
            "$PREFIX/bin/pip" -q install -U 'numpy==1.11.*' -t "$("$PREFIX/bin/pychimera" --path)"/lib/python2.7/site-packages
            ;;
        * )
            echo "Ok! If you ever want to update it yourself, run this:"
            echo "  pip install -U 'numpy==1.11.*' -t \`pychimera --path\`/lib/python2.7/site-packages"
            ;;
    esac
fi

# SUCCESS GREETING
cat << EOF
-----------------------------------------------------------------------
             _____  _    _   _  ____ ____      _    __  __
            |_   _|/ \  | \ | |/ ___|  _ \    / \  |  \/  |
              | | / _ \ |  \| | |  _| |_) |  / _ \ | |\/| |
              | |/ ___ \| |\  | |_| |  _ <  / ___ \| |  | |
              |_/_/   \_\_| \_|\____|_| \_\/_/   \_\_|  |_|

  Done! InsiliChem Tangram is now installed in your system.

  Some of the extensions will work out the box, but some others will
  require two (or three) additional steps:

  0) ONLY ONCE! If you haven't used conda before, you will have to run
     this command to enable Tangram's one:

        echo ". $PREFIX/etc/profile.d/conda.sh" >> ~/.bashrc

  1) Activate Tangram environment:

        conda activate $PREFIX

  2) Launch a patched UCSF Chimera instance with:

        tangram

  If you ever need to update an extension, use this command with the
  tangram environment activated:

        tangram_update <extension>

  Thanks for installing Tangram <https://github.com/insilichem/tangram>,
  InsiliChem.

-----------------------------------------------------------------------
EOF