# Plume Suite

Python Layer for Unified Modular Molecular Modeling.

It's composed of several independent graphical interfaces and commands for UCSF Chimera.


- **Calculation setup**

    - **[OpenMM GUI](https://github.com/insilichem/plume_openmmgui)**: Setup MD calculations with OpenMM and ommprotocol [WIP]

    - **[Cauchian](https://github.com/insilichem/plume_cauchian)**: QM and QM/MM calculations setup

- **Visualization**

    - **[3D-SNFG](https://github.com/insilichem/plume_snfg)**: Enable easy visualization of saccharydic residues

    - **[BondOrder](https://github.com/insilichem/plume_bondorder)**: Automatic bond order perception for UCSF Chimera [WIP]

    - **[PlumeView](https://github.com/insilichem/gaudiview)** (formerly GAUDIView): Lighweight visualization of results coming from docking, conformational search or multiobjective optimization

    - **[OrbiTraj](https://github.com/insilichem/plume_orbitraj)**: A subtle modification to UCSF Chimera's MD Movie extension to allow the visualization of volumetric data along a molecular trajectory

- **Analysis**

    - **[NCIPlot GUI](https://github.com/insilichem/plume_nciplot)**: Straightforward interface to setup calculations for NCIPlot and visualize them

    - **[NormalModes](https://github.com/insilichem/plume_normalmodes)**: Perform Normal Modes Analysis and view them directly on-screen

    - **[PLIPGui](https://github.com/insilichem/plume_plipgui)**: Depict protein-ligand interactions, as calculated with PLIP

    - **[PoPMuSiCGUI](https://github.com/insilichem/plume_popmusicgui)**: Depict and apply the predictions made by PoPMuSiC calculations

    - **[PropKaGUI](https://github.com/insilichem/plume_propkagui)**: Analyze and depict the expected pKa values of protein residues with PropKa 3.1

    - **[SubAlign](https://github.com/insilichem/plume_subalign)**: Align two, potentially different, molecules based on partial matches of substructures

- **Utilities**
    -  **[VinaRelaunch](https://github.com/insilichem/plume_vinarelaunch)**: Resubmit failed AutoDock Vina jobs without reconfiguring the GUI.


# Installation

1 - If you don't have Chimera installed, download the [latest stable copy](http://www.cgl.ucsf.edu/chimera/download.html) and install it with:

    chmod +x chimera-*.bin && ./chimera-*.bin

2 - Download the installer from the [releases page](https://github.com/insilichem/plume/releases) (Linux only) and run it with:

    bash plume-*.sh


# Usage

Some of the extensions can run without additional dependencies, which means they will be ready to use in your normal UCSF Chimera installation. However, most complex ones require 3rd party libraries (already provided with this installer, though!). To run these tricky ones, you must activate the `conda` environment that as created during the CLI wizard. By default, it is called `insilichem`, but you might have chosen a different one. Simply, run this command in the terminal:

    source activate insilichem  # or whichever name you chose

Then you can load a modified UCSF Chimera instance with

    pychimera --gui


# Updating

Each extension will check if there's a new release available every time you launch it. To update it, the installer provides you with a command that you can run with the `conda` environment already activated:

    pip install -t $PREFIX -U <package name or URL>

, where `$PREFIX` is the path to your UCSF Chimera extensions directory. By default, it is set to `~/.local/insilichem/plume`, but you can check it in UCSF Chimera via `Preferences> Tools` dialog.


# Known issues

Some extensions rely on `rdkit`, and ones on `openbabel`. However, these two don't play well together when called with `pychimera --gui`. As a result, `openbabel` was left intentionally out of the `conda` environment. If you really needed, you can uninstall rdkit and then install `openbabel`. Like this:

    conda remove -n insilichem rdkit
    conda install -n insilichem -c openbabel

To restore the default env configuration, undo those actions:

    conda remove -n insilichem openbabel
    conda install -n insilichem -c rdkit rdkit numpy=1.11