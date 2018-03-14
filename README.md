# Plume Suite

Python Layer for Unified Modular Molecular Modeling: PLUMMM -> PLUM3 -> Plume.

It's composed of several independent graphical interfaces and commands for UCSF Chimera. Each extension has its own separate repository, as detailed in the list below. As installing extensions in UCSF Chimera can be tricky, specially if external dependencies are required, We provide [Linux and MacOS installers](https://github.com/insilichem/plume/releases) to handle that for you. More details are provided below.

## Plume extensions

After the installation, a new menu will be available under _Tools_, called _InsiliChem_.

- **Calculation setup**

    - **[OpenMM GUI](https://github.com/insilichem/plume_openmmgui)**: Setup MD calculations with OpenMM and ommprotocol [WIP]

    - **[Cauchian](https://github.com/insilichem/plume_cauchian)**: QM and QM/MM calculations setup

- **Visualization**

    - **[3D-SNFG](https://github.com/insilichem/plume_snfg)**: Enable easy visualization of saccharydic residues

    - **[BondOrder](https://github.com/insilichem/plume_bondorder)**: Automatic bond order perception for UCSF Chimera [WIP]

    - **[GAUDIView](https://github.com/insilichem/gaudiview)**: Lighweight visualization of results coming from docking, conformational search or multiobjective optimization

- **Analysis**

    - **[NCIPlot GUI](https://github.com/insilichem/plume_nciplot)**: Straightforward interface to setup calculations for NCIPlot and visualize them

    - **[NormalModes](https://github.com/insilichem/plume_normalmodes)**: Perform Normal Modes Analysis and view them directly on-screen

    - **[PLIPGui](https://github.com/insilichem/plume_plipgui)**: Depict protein-ligand interactions, as calculated with PLIP

    - **[PoPMuSiCGUI](https://github.com/insilichem/plume_popmusicgui)**: Depict and apply the predictions made by PoPMuSiC calculations

    - **[PropKaGUI](https://github.com/insilichem/plume_propkagui)**: Analyze and depict the expected pKa values of protein residues with PropKa 3.1

    - **[SubAlign](https://github.com/insilichem/plume_subalign)**: Align two, potentially different, molecules based on partial matches of substructures

- **Utilities & Patches**

    - **[MetalGeomDummy](https://github.com/insilichem/plume_metalgeom)**: A subtle modification to UCSF Chimera's MetalGeom extension to allow arbitrary elements to be placed at vacant positions, instead of just oxygens

    - **[OrbiTraj](https://github.com/insilichem/plume_orbitraj)**: A subtle modification to UCSF Chimera's MD Movie extension to allow the visualization of volumetric data along a molecular trajectory

    -  **[VinaRelaunch](https://github.com/insilichem/plume_vinarelaunch)**: Resubmit failed AutoDock Vina jobs without reconfiguring the GUI


# Installation

1 - If you don't have Chimera installed, download the [latest stable copy](http://www.cgl.ucsf.edu/chimera/download.html) and install it with:

    chmod +x chimera-*.bin && ./chimera-*.bin

2 - Download the installer from the [releases page](https://github.com/insilichem/plume/releases) (Linux only) and run it with:

    bash plume-*.sh


# Usage

Some of the extensions can run without additional dependencies, which means they will be ready to use in your normal UCSF Chimera installation. However, most complex ones require 3rd party libraries (already provided with this installer, though!). To run these tricky ones, you must activate the `conda` environment that as created during the CLI wizard. The installer will provide the needed steps, but you can also find them here (`$PREFIX` is the install location, `~/plume` by default):

```
(...)
Done! InsiliChem Plume is now installed in your system.

Some of the extensions will work out the box, but some others will
require two (or three) additional steps:

0) ONLY ONCE! If you haven't used conda before, you will have to run
   this command to enable Plume's one:

    echo ". $PREFIX/etc/profile.d/conda.sh" >> ~/.bashrc

1) Activate Plume environment:

    conda activate $PREFIX

2) Launch a patched UCSF Chimera instance with:

    plume

(...)
```

# Updating

Each extension will check if there's a new release available every time you launch it. To update it, the installer provides you with a command that you can run with the `conda` environment already activated:

    plume_update <extension_name>

For example, if you want to update gaudiview, you would write:

    conda activate insilichem
    plume_update gaudiview


# Known issues

Some extensions rely on `rdkit`, and ones on `openbabel`. However, these two don't play well together when called with `pychimera --gui`. As a result, `openbabel` was left intentionally out of the `conda` environment. If you really needed, you can uninstall rdkit and then install `openbabel`.

    conda activate insilichem

    # Switch to openbabel
    plume_openbabel

    # Switch back to RDKit
    plume_rdkit
