============================
How to install Tangram Suite
============================

.. _installsuite:

Install the full Tangram Suite (recommended)
============================================

1 - If you don't have UCSF Chimera installed, download the `latest stable copy <http://www.cgl.ucsf.edu/chimera/download.html>`_ and install it with:

::

    chmod +x chimera-*.bin && ./chimera-*.bin

2 - Download the latest installer from the `releases page <https://github.com/insilichem/tangram/releases>`_ (Linux and MacOS only) and run it with:

::

    bash tangram-*.sh


.. _update:

Using the conda meta-package
============================

Instead of using the Bash installer, you can use conda (if you are already using it) to create a new environment with the ``tangram`` metapackage, which will handle all the dependencies:

::

    conda create -n tangram -c insilichem -c conda-forge -c omnia -c rdkit tangram

Updating extensions
===================

Each extension will check if there's a new release available every time you launch it. To update it, the installer provides you with a command that you can run with the ``conda`` environment already activated:

::

    conda update -c insilichem [-c additional channels] <extension_name>

.. note:

    More ``-c`` flags might be needed, depending on the requirements. Check each extension documentation page to see the needed conda channels.

For example, if you want to update *gaudiview*, you would write:

::

    conda activate insilichem
    conda update -c insilichem gaudiview

.. _installone:

Install only one specific extension
===================================

(Advanced users only)

Installing separate extension is not recommended but can be done.

::

    conda install -c insilichem <package name>

.. note:

    More ``-c`` flags might be needed, depending on the requirements. Check each extension documentation page to see the needed conda channels.


Once completed, tell UCSF Chimera to look for new extensions in the chosen environment. To do that, open UCSF Chimera and go to ``Favorites> Add to Favorites/Toolbar``. In the newly opened dialog, specify the env location in the bottom box. In this case, the extensions location will be something like ``$CONDA_PREFIX/lib/python2.7/site-packages``.

.. note::

    The conda environment will always require ``pychimera`` to inject the conda dependencies.