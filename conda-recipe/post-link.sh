"$PREFIX/bin/pychimera" -c "import chimera; chimera.extension.manager.addDirectory(\"${PREFIX}/lib/python2.7/site-packages\", True)" >> "$PREFIX/.messages.txt"
if [ "$?" -gt 0 ] ; then
    echo "  !!! WARNING !!!" >> "$PREFIX/.messages.txt"
    echo "  Could not register extensions in UCSF Chimera automatically!" >> "$PREFIX/.messages.txt"
    echo "  You might need to add them manually via Preferences> Tools dialog." >> "$PREFIX/.messages.txt"
    echo "  Use this location: ${PREFIX}/lib/python2.7/site-packages" >> "$PREFIX/.messages.txt"
fi

NPVERSION=$(chimera --nogui --script <(echo "import numpy as np; print(np.__version__)") 2> /dev/null) || true
NPCHECK=$(${PREFIX}/bin/python -c "from distutils.version import LooseVersion as V; print(str(V('$NPVERSION') < V('1.11')).lower())" 2> /dev/null) || NPCHECK="true"
if [[ "$NPCHECK" == "true" ]]; then
    echo -n "
  !!! WARNING !!!
  Your UCSF Chimera installation is using an old Numpy version ($NPVERSION)
  or could not be tested. If the NumPy version is not recent (>1.11), it can
  cause problems with most of our extensions. You can update now, but
  please notice that:
    - Upgrading NumPy will cause MMTK to stop working (and maybe others), which means that
      the built-in extensions relying on it (Molecular Dynamics) will not work.
  We do offer replacements for those (e.g. MMSetup) that offer similar
  functionality. And, if you ever want to use MMTK in the future, you can download
  UCSF Chimera again and make a separate, unmodified, installation.
  If you wish to update Chimera's numpy, run this command:
      pip install -U 'numpy==1.11.*' -t \`pychimera --path\`/lib/python2.7/site-packages
" >> "$PREFIX/.messages.txt"
fi