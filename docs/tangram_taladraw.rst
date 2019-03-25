================
Tangram TalaDraw
================

.. image:: https://img.shields.io/github/release/insilichem/tangram_taladraw.svg
    :target: https://github.com/insilichem/tangram_taladraw

.. image:: https://img.shields.io/github/issues/insilichem/tangram_taladraw.svg
    :target: https://github.com/insilichem/tangram_taladraw/issues

UCSF Chimera extension to build 3D structures out of two-dimensional sketches.

It uses BKChem to handle the 2D drawing, and then transfers the data into UCSF Chimera for further processing.

.. note::

    This is only a pre-release. It barely works! That said, please test it and `tell us <https://github.com/insilichem/tangram/issues>`_ how we can improve it.

Features
========

- Draw any 2D molecule in an interactive canvas and build a 3D molecule out of it
- Run any command when the 3D molecule is loaded

.. note::

    This extension uses Chimera's ``open smiles`` feature, which needs Internet connection.

Usage
=====

Click on Open to launch a BKChem instance and draw on the canvas. When you are ready, use the selection tool to highlight the molecule to be loaded and click on ``Smiles to Chimera``. If you have specified a command on the launcher window, this will be executed after loading the molecule. You can refer to the newly loaded molecule as ``$#``.

Some useful examples:

**Align molecule against an already loaded compound** (e.g. #0.1)

::

    subalign #0.1 #$ methods best,com

Requirements
============

- ``libtangram`` (*pip*-installable)
- ``pmw``
- ``bkchem``, ``oasa`` (*conda*-installable)

.. note::

    conda install -c insilichem/label/dev -c insilichem -c conda-forge tangram_taladraw