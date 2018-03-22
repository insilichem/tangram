=========
GAUDIView
=========

.. image:: https://img.shields.io/github/release/insilichem/gaudiview.svg
    :target: https://github.com/insilichem/gaudiview

.. image:: https://img.shields.io/github/issues/insilichem/gaudiview.svg
    :target: https://github.com/insilichem/gaudiview/issues

Lighweight visualization of results coming from docking, conformational search or multiobjective optimization

Features
========

- Explore GaudiMM_ and GOLD_ results in the same GUI
- Lightweight and fast, it will lazy-load the molecules upon request
- Builtin commandline will perform any Chimera command upon row change (use the mouse or the keyboard arrows to move)
- Basic clustering functionality
- Use ``Ctrl`` and ``Shift`` to create multiple selections
- Double-click to apply special modifications, depending on the job type
    - If the GOLD job used rotamers, these will be applied on double-click
- Quit the dialog with ``OK`` to preserve the currently selected solutions on the Chimera canvas.

Usage
=====

[WIP]

Requirements
============

- ``libtangram``, ``tkintertable``, ``pyyaml`` (*pip*-installable)

.. _GaudiMM: http://github.com/insilichem/gaudi
.. _GOLD: https://www.ccdc.cam.ac.uk/solutions/csd-discovery/components/gold/