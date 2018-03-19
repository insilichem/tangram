.. image:: docs/img/logo_plumE.png

===========
Plume Suite
===========

.. image:: https://readthedocs.org/projects/plume-suite/badge/?version=latest
    :target: http://plume-suite.readthedocs.io/en/latest/?badge=latest

.. image:: https://img.shields.io/github/release/insilichem/plume.svg
    :target: https://github.com/insilichem/plume/releases


**Python Layer for Unified Molecular modEling, Plume**

It's composed of several independent graphical interfaces and commands for UCSF Chimera. Each extension has its own separate repository, as detailed in the list below. As installing extensions in UCSF Chimera can be tricky, specially if external dependencies are required, in this repository we provide `Linux and MacOS installers <https://github.com/insilichem/plume/releases>`_ to handle that for you. More details are provided below. The documentation will be collected here, as well.

Plume extensions
----------------

After the installation, a new menu will be available under *Tools*, called *InsiliChem*.

- **Calculation setup**

    - `MMSetup <https://github.com/insilichem/plume_openmmgui>`_: Setup MD calculations with OpenMM and ommprotocol [WIP]

    - `Cauchian <https://github.com/insilichem/plume_cauchian>`_: QM and QM/MM calculations setup

- **Visualization**

    - `3D-SNFG <https://github.com/insilichem/plume_snfg>`_: Enable easy visualization of saccharydic residues

    - `BondOrder <https://github.com/insilichem/plume_bondorder>`_: Automatic bond order perception for UCSF Chimera [WIP]

    - `GAUDIView <https://github.com/insilichem/gaudiview>`_: Lighweight visualization of results coming from docking, conformational search or multiobjective optimization

- **Analysis**

    - `NCIPlotGUI <https://github.com/insilichem/plume_nciplot>`_: Straightforward interface to setup calculations for NCIPlot and visualize them

    - `NormalModes <https://github.com/insilichem/plume_normalmodes>`_: Perform Normal Modes Analysis and view them directly on-screen

    - `PLIPGUI <https://github.com/insilichem/plume_plipgui>`_: Depict protein-ligand interactions, as calculated with PLIP

    - `PoPMuSiCGUI <https://github.com/insilichem/plume_popmusicgui>`_: Depict and apply the predictions made by PoPMuSiC calculations

    - `PropKaGUI <https://github.com/insilichem/plume_propkagui>`_: Analyze and depict the expected pKa values of protein residues with PropKa 3.1

    - `SubAlign <https://github.com/insilichem/plume_subalign>`_: Align two, potentially different, molecules based on partial matches of substructures

- **Utilities & Patches**

    - `DummyMetal <https://github.com/insilichem/plume_metalgeom>`_: A subtle modification to UCSF Chimera's MetalGeom extension to allow arbitrary elements to be placed at vacant positions, instead of just oxygens

    - `OrbiTraj <https://github.com/insilichem/plume_orbitraj>`_: A subtle modification to UCSF Chimera's MD Movie extension to allow the visualization of volumetric data along a molecular trajectory

    - `ReVina <https://github.com/insilichem/plume_vinarelaunch>`_: Resubmit failed AutoDock Vina jobs without reconfiguring the GUI


Installation and usage
----------------------

Check the `docs <http://plume-suite.readthedocs.io/en/latest/>`_!

Help and support
----------------

Feel free to `submit an issue in this repository <https://github.com/insilichem/plume/issues>`_ if you have any problems with the installation process. However, if the issue is extension-specific, please use the Issues section of the corresponding repository (links are provided in the list above)
