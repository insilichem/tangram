=============
General usage
=============

Once installed (check :ref:`installsuite`), some of the extensions will run without additional dependencies, which means they will be ready to use in your normal UCSF Chimera installation. However, more complex ones require 3rd party libraries (already provided with this installer, though!). To run these tricky ones, you must activate the ``conda`` environment that was created during the installation proecss. The installer will provide the needed steps, but you can also find them here (`$PREFIX` is the install location, `~/tangram` by default):

::

    (...)
    Done! InsiliChem Tangram is now installed in your system.

    Some of the extensions will work out the box, but some others will
    require two (or three) additional steps:

    0) ONLY ONCE! If you haven't used conda before, you will have to run
    this command to enable Tangram's one:

        echo ". $PREFIX/etc/profile.d/conda.sh" >> ~/.bashrc

    1) Activate Tangram environment:

        conda activate $PREFIX

    2) Launch a patched UCSF Chimera instance with:

        tangram  # available in Bash and Fish
        # use `pychimera --gui` in other shells

    (...)
