#!/bin/bash
set -e

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

EOF
"EOF" > /dev/null 2>&1 || true  # fix vscode syntax recognition...

cat << EOF > "$PREFIX/etc/conda/deactivate.d/tangram.sh"
#!/bin/bash
unset AMBERHOME
unset NCIPLOT_HOME
unset -f tangram
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

EOF
"EOF" > /dev/null 2>&1 || true  # fix vscode syntax recognition...

cat << EOF > "$PREFIX/etc/conda/deactivate.d/tangram.fish"
#!/usr/bin/fish
set -e AMBERHOME
set -e NCIPLOT_HOME
functions -e tangram
EOF