=============
General usage
=============

Once installed (check :ref:`installsuite`), some of the extensions will run without additional dependencies, which means they will be ready to use in your normal UCSF Chimera installation. However, more complex ones require 3rd party libraries (already provided with this installer, though!). To run these tricky ones, you must activate the ``conda`` environment that was created during the installation proecss. The installer will provide the needed steps, but you can also find them here (`$PREFIX` is the install location, `~/plume` by default):

::

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

        plume  # available in Bash and Fish
        # use `pychimera --gui` in other shells

    (...)


Known issues
============

Some extensions rely on ``rdkit``, and ones on ``openbabel``. However, these two don't play well together when called with `pychimera --gui`. As a result, ``openbabel`` was left intentionally out of the ``conda`` environment. If you really needed, you can uninstall rdkit and then install ``openbabel`` with these convenience shell functions (Bash and Fish only):

::

    conda activate insilichem

    # Switch to openbabel
    plume_openbabel

    # Switch back to RDKit
    plume_rdkit
