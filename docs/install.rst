==========================
How to install Tangram Suite
==========================

.. _installsuite:

Install the full Tangram Suite (recommended)
==========================================

1 - If you don't have UCSF Chimera installed, download the `latest stable copy <http://www.cgl.ucsf.edu/chimera/download.html>`_ and install it with:

::

    chmod +x chimera-*.bin && ./chimera-*.bin

2 - Download the latest installer from the `releases page <https://github.com/insilichem/tangram/releases>`_ (Linux and MacOS only) and run it with:

::

    bash tangram-*.sh


.. _update:

Updating extensions
===================

Each extension will check if there's a new release available every time you launch it. To update it, the installer provides you with a command that you can run with the ``conda`` environment already activated:

::

    tangram_update <extension_name>

For example, if you want to update *gaudiview*, you would write:

::

    conda activate insilichem
    tangram_update gaudiview

.. _installone:

Install only one specific extension
===================================

(Advanced users only)

Installing separate extension is not recommended but can be done. Each extension is a separate Python package, which additionally can require ``pip`` and/or ``conda`` dependencies. Since ``pip`` dependencies are programmatically specified in ``setup.py``, they will be handled when you run

::

    pip install <repository URL>


By default, ``pip`` will install the packages to the default location (available with ``pip --version``), but you can point to a different one with ``pip install -t my/custom/location/ <repository URL>``.

Write down the chosen location and, once completed, tell UCSF Chimera to look for new extensions in the chosen environment. To do that, open UCSF Chimera and go to ``Favorites> Add to Favorites/Toolbar``. In the newly opened dialog, specify the chosen location in the bottom box.


If ``conda`` requirements are needed (Miniconda installers are available `here <https://conda.io/miniconda.html>`_, you will have to provide those by running

::

    conda install <package> [<package2> ...]

In this case, the extensions location will be something like ``$CONDA_PREFIX/lib/python2.7/site-packages``. The conda environment will always require ``pychimera`` to inject the conda dependencies.