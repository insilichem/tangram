![image](docs/img/tangram.jpg)

Tangram Suite
=============

[![image](https://readthedocs.org/projects/tangram-suite/badge/?version=latest)](http://tangram-suite.readthedocs.io/en/latest/?badge=latest) [![image](https://img.shields.io/github/release/insilichem/tangram.svg)](https://github.com/insilichem/tangram/releases)

It\'s composed of several independent graphical interfaces and commands
for UCSF Chimera. Each extension or *tan* has its own separate
repository, as detailed in the list below. The project name is (almost)
always prefixed with *tangram\_* for easy identification.

As installing extensions in UCSF Chimera can be tricky, specially if
external dependencies are required, in this repository we provide [Linux
and MacOS installers](https://github.com/insilichem/tangram/releases) to
handle that for you. More details are provided below. The documentation
will be collected here, as well.

Tangram extensions
------------------

After the installation, a new menu will be available under *Tools*,
called *InsiliChem*.

-   **Calculation setup**

    > -   [MMSetup](https://github.com/insilichem/tangram_openmmgui):
    >     Setup MD calculations with OpenMM and ommprotocol \[WIP\]
    > -   [QMSetup](https://github.com/insilichem/tangram_qmsetup): QM
    >     and QM/MM calculations setup

-   **Visualization**

    > -   [3D-SNFG](https://github.com/insilichem/tangram_snfg): Enable
    >     easy visualization of saccharydic residues
    > -   [BondOrder](https://github.com/insilichem/tangram_bondorder):
    >     Automatic bond order perception for UCSF Chimera \[WIP\]
    > -   [GAUDIView](https://github.com/insilichem/gaudiview):
    >     Lighweight visualization of results coming from docking,
    >     conformational search or multiobjective optimization

-   **Analysis**

    > -   [NCIPlotGUI](https://github.com/insilichem/tangram_nciplot):
    >     Straightforward interface to setup calculations for NCIPlot
    >     and visualize them
    > -   [NormalModes](https://github.com/insilichem/tangram_normalmodes):
    >     Perform Normal Modes Analysis and view them directly on-screen
    > -   [PLIPGUI](https://github.com/insilichem/tangram_plipgui):
    >     Depict protein-ligand interactions, as calculated with PLIP
    > -   [PoPMuSiCGUI](https://github.com/insilichem/tangram_popmusicgui):
    >     Depict and apply the predictions made by PoPMuSiC calculations
    > -   [PropKaGUI](https://github.com/insilichem/tangram_propkagui):
    >     Analyze and depict the expected pKa values of protein residues
    >     with PropKa 3.1
    > -   [SubAlign](https://github.com/insilichem/tangram_subalign):
    >     Align two, potentially different, molecules based on partial
    >     matches of substructures

-   **Utilities & Patches**

    > -   [DummyMetal](https://github.com/insilichem/tangram_metalgeom):
    >     A subtle modification to UCSF Chimera\'s MetalGeom extension
    >     to allow arbitrary elements to be placed at vacant positions,
    >     instead of just oxygens
    > -   [OrbiTraj](https://github.com/insilichem/tangram_orbitraj): A
    >     subtle modification to UCSF Chimera\'s MD Movie extension to
    >     allow the visualization of volumetric data along a molecular
    >     trajectory
    > -   [ReVina](https://github.com/insilichem/tangram_vinarelaunch):
    >     Resubmit failed AutoDock Vina jobs without reconfiguring the
    >     GUI

Installation and usage
----------------------

Check the [docs](http://tangram-suite.readthedocs.io/en/latest/)!

Help and support
----------------

Feel free to [submit an issue in this
repository](https://github.com/insilichem/tangram/issues) if you have
any problems with the installation process. However, if the issue is
extension-specific, please use the Issues section of the corresponding
repository (links are provided in the list above).
