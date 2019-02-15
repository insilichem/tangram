==================
Tangram DummyAtoms
==================

.. image:: https://img.shields.io/github/release/insilichem/tangram_dummyatoms.svg
    :target: https://github.com/insilichem/tangram_dummyatoms

.. image:: https://img.shields.io/github/issues/insilichem/tangram_dummyatoms.svg
    :target: https://github.com/insilichem/tangram_dummyatoms/issues

Apply the `Cationic Dummy Atom`_ approach to parametrize metal-containing systems using the Ambertoools suite

Features
========

- The extension will generate PRMTOP and INPRCD files for your system, compatible with Amber & OMMProtocol/OpenMM.
- Multiple atom sites allowed seamlessly.
- If this extension is installed, a reversible, subtle modification to UCSF Chimera’s MetalGeom extension will allow arbitrary elements to be placed at vacant positions, instead of just oxygens.

Usage
=====

[WIP]

Requirements
============


- ``libtangram``, ``pychimera``
- ``ambermini``

::

    conda install -c insilichem -c rdkit -c omnia tangram_dummyatoms

.. note::

    This package might need that you launch UCSF Chimera with ``pychimera --gui``

.. _Cationic Dummy Atom: https://pubs.acs.org/doi/abs/10.1021/jp501737x