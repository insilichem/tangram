================
Tangram SubAlign
================

.. image:: https://img.shields.io/github/release/insilichem/tangram_subalign.svg
    :target: https://github.com/insilichem/tangram_subalign

.. image:: https://img.shields.io/github/issues/insilichem/tangram_subalign.svg
    :target: https://github.com/insilichem/tangram_subalign/issues

Align two, potentially different, molecules based on partial matches of substructures

Features
========

[WIP]

Usage
=====

In general:

::

    subalign <reference> <probe> [methods <method>]

- ``reference``, ``probe``: must be Chimera selections (e.g. ``#0`` or ``sel``).
- ``methods`` (optional): the alignment method(s) to use. If you specify several ones (separate by commas), ``subalign`` will try all of them until one succeeds. Choose between:
    - ``fast``: identify the best submatch of the naive one-to-one corresponding atom pairs.
    - ``best`` (default): iterate over all possible atom pair correspondences, trying ``fast`` over each one, and returns the one with best RMSD.
    - ``o3a``: identifies atom pair correspondences by MM-like atom typing.
    - ``com``: simply overlap centers of mass (great as a fallback method; e.g. ``methods best,com``)


.. note::

    The passed Chimera selections must corresponde to a single molecule. If you only specify a subset of atoms, it will be expanded to the containing molecule. With protein-ligand systems, this can be costly. The current recommendation is to split the molecule in submodels beforehand with ``split`` (see `Chimera docs <https://www.cgl.ucsf.edu/chimera/docs/UsersGuide/midas/split.html>`_) and then specify the desired submodel.


Requirements
============

- ``libtangram``, ``pychimera``
- ``rdkit``

.. note::

    conda install -c insilichem/label/dev -c insilichem -c rdkit tangram_subalign

.. note::

    This package might need that you launch UCSF Chimera with ``pychimera --gui``
