#!/bin/bash
set -e

# InsiliChem Plume Installer
# Based on the original Miniconda installer
# https://conda.io/miniconda.html

unset LD_LIBRARY_PATH

PREFIX="$HOME/.local/insilichem/plume"
ENV_NAME="insilichem"
THIS_DIR=$(cd $(dirname $0); pwd)
THIS_FILE=$(basename $0)
THIS_PATH="$THIS_DIR/$THIS_FILE"
BATCH=0
FORCE=0
PLATFORM=$(uname)
REQUIREMENTSTXT="requirements-$PLATFORM.txt"
ENVIRONMENTYML="environment-$PLATFORM.yml"

while getopts "bfhpe:" x; do
    case "$x" in
        h)
            echo "usage: $0 [options]

Installs Plume Suite

    -b           run installer in batch mode (without manual intervention)
    -f           no error if install prefix already exists (force)
    -h           print this help message and exit
    -p PREFIX    install prefix, defaults to $PREFIX
    -e ENV_NAME  conda environment, defaults to $ENV_NAME
"
            exit 2
            ;;
        b)
            BATCH=1
            ;;
        f)
            FORCE=1
            ;;
        p)
            PREFIX="$OPTARG"
            ;;
        e)
            ENV_NAME="$OPTARG"
            ;;
        ?)
            echo "Error: did not recognize option, please try -h" >&2
            exit 1
            ;;
    esac
done

# Check all requirements are in place

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v conda)" ]; then
  echo 'Error: conda is not installed. Visit https://conda.io/miniconda.html.' >&2
  exit 1
fi

if ! [ -x "$(command -v chimera)" ]; then
  echo 'Error: UCSF Chimera is not installed or in PATH. Visit https://www.cgl.ucsf.edu/chimera.' >&2
  exit 1
fi

if ! [ -x "$(command -v pip)" ]; then
  echo 'Error: pip is not installed. Visit https://pip.pypa.io/en/stable/installing/' >&2
  exit 1
fi

# Actual installation begins

echo "Plume installation started on $(date)" > install.log

if [[ $BATCH == 0 ]] # interactive mode
then
echo -n "
Welcome to the InsiliChem Plume Suite Installer!

Plume Suite will now be installed into this location:
  $PREFIX
Using this conda environment: 
  $ENV_NAME

  - Press ENTER to confirm
  - Press CTRL-C to abort
  - Or specify different values below

Location: [$PREFIX] >>> " | tee -a install.log
    read user_prefix
    if [[ $user_prefix != "" ]]; then
        case "$user_prefix" in
            *\ * )
                echo "ERROR: Cannot install into directories with spaces" >&2
                exit 1
                ;;
            *)
                eval PREFIX="$user_prefix"
                ;;
        esac
    fi
echo -e -n "Environment: [$ENV_NAME] >>> " | tee -a install.log
    read user_env
    if [[ $user_env != "" ]]; then
        case "$user_env" in
            *\ * )
                echo "ERROR: Environment names cannot include spaces" >&2
                exit 1
                ;;
            *)
                eval ENV_NAME="$user_env"
                ;;
        esac
    fi
fi # !BATCH

case "$PREFIX" in
    *\ * )
        echo "ERROR: Cannot install into directories with spaces" >&2
        exit 1
        ;;
esac
case "$ENV_NAME" in
    *\ * )
        echo "ERROR: Environment names cannot contain spaces" >&2
        exit 1
        ;;
esac
if [[ ($FORCE == 0) && (-e $PREFIX) ]]; then
    echo "ERROR: File or directory already exists: $PREFIX" >&2
    exit 1
fi


echo "
------------------------------------------------------------
  From now on, if you don't see a success message when the
  installer finishes, then an error ocurred. Check the
  contents of install.log in that case!
------------------------------------------------------------
"

mkdir -p "$PREFIX"

PREFIX=$(cd $PREFIX; pwd)
export PREFIX

# Create dedicated conda environment
echo -e "\nCreating a new Python 2.7 conda environment: $ENV_NAME..." | tee -a install.log
conda create -y -n $ENV_NAME python=2.7 >> install.log
source activate "$ENV_NAME"

ENV_PATH="$(conda info --root)/envs/$ENV_NAME"
echo -e "Activated environment $ENV_NAME" | tee -a install.log

# Install all packages with pip
if [ $(python -c "import sys; print(sys.version_info.major)") -gt '2' ]; then
    echo 'Plume Suite can only be installed within a Python 2.7 environment.' >&2
    exit 1
fi

echo "Installing Plume Suite extensions with pip..." | tee -a install.log
pip install -U git+https://github.com/insilichem/pychimera.git >> install.log 2>&1
pip install --process-dependency-links -U -t $PREFIX -r $REQUIREMENTSTXT >> install.log 2>&1

if (( $PLATFORM == 'Linux' )); then
pip install --no-deps -U https://github.com/ssalentin/plip/archive/v1.3.3.zip -t $PREFIX >> install.log 2>&1
fi

echo "Installing dependencies with conda..." | tee -a install.log
conda env update -n $ENV_NAME -f $ENVIRONMENTYML >> install.log 2>&1

mkdir -p "$ENV_PATH/etc/activate.d/"
mkdir -p "$ENV_PATH/etc/deactivate.d/"
echo "export AMBERHOME=$ENV_PATH" >> "$ENV_PATH/etc/activate.d/plume.sh"
echo "export NCIPLOT_HOME=$ENV_PATH/etc/nciplot" >> "$ENV_PATH/etc/activate.d/plume.sh"
echo "unset AMBERHOME" >> "$ENV_PATH/etc/deactivate.d/plume.sh"
echo "unset NCIPLOT_HOME" >> "$ENV_PATH/etc/deactivate.d/plume.sh"

echo "Registering extensions in UCSF Chimera..." | tee -a install.log
pychimera -c "import chimera; chimera.extension.manager.addDirectory(\"$PREFIX\", True)" >> install.log 2>&1 || exit_code=$?
    if (( exit_code > 0 )) ; then
    echo "  Could not register extensions automatically!"
    echo "  You might need to add them manually via Preferences> Tools dialog."
    echo "  Use this location: $PREFIX"
    fi

# SUCCESS GREETING
echo "
---------------------------------------------------------
  Done! Most of the interfaces will be available now!
  However, some of them will require you to activate a 
  conda environment with:

      source activate $ENV_NAME

  and then launch a patched UCSF Chimera instance with:

      pychimera --gui

  If you ever need to update an extension, use this 
  command with $ENV_NAME env activated:

      pip install -t $PREFIX -U <package name or URL>

  Thanks for installing Plume Suite!
---------------------------------------------------------
"
