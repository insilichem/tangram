# How to cut a new release

The Tangram suite is composed out of independent extensions for UCSF Chimera. I've been hesitant to setup CI in all of them because installing Chimera automatically tends to be error prone (already happening with gaudi and pychimera). Because of that, the `tangram_*` conda packages are generated locally at the moment.

- Linux box: Arch Linux
- MacOS: El Capitan VM

To make a new release for each tan, in each platform:

1. Make sure that there are no uncommited changes (ie, no "dirty" status with `git describe --tags --dirty`)
2. Tag the new version (`vX.Y.Z`) appropriately, using semver.
3. Build with the corresponding `conda build` command (written in `conda-recipe/meta.yml` for each repo).
4. `anaconda upload -u insilichem path/to/tangram_package.tar.bz2`.

Then for the `tangram` metapackage:

1. Update the version of the recently updated tan.
2. Manually modify `installer/construct.yml` to reflect the new version (`constructor` does not support `GIT_DESCRIBE_*` variables yet).
3. Commit the changes.
4. Tag the repository with a new version.
5. Push so Travis CI can proceed.