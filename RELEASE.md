# How to cut a new release

The Tangram suite is composed out of independent extensions for UCSF Chimera. I've been hesitant to setup CI in all of them because installing Chimera automatically tends to be error prone (already happening with gaudi and pychimera). Because of that, the `tangram_*` conda packages are generated locally at the moment.

- Linux box: Arch Linux
- MacOS: El Capitan VM

To make a new release for each tan, in each platform:

1. Make sure that there are no uncommited changes (ie, no "dirty" status with `git describe --tags --dirty`)
2. Tag the new version (`vX.Y.Z`) appropriately, using semver.
3. Build with the corresponding `conda build` command (written in `conda-recipe/meta.yml` for each repo).
4. `anaconda upload -u insilichem path/to/tangram_package.tar.bz2`.

Assuming that all `tangram_*` repos are cloned in the current working directory, for step 1, a script like this could help (for `fish`):

```
for d in tangram_*
    cd $d
    echo $d
    set ncommits (git log (git describe --tags --abbrev=0)..HEAD --oneline | wc -l)
    if test $ncommits -gt 0
        echo "Creating new tag..."
        git tag vX.Y.Z # replace with proper value!
    end
    cd ..
end
```

Then for the `tangram` metapackage:

1. Update the pinned version of the recently updated tan.
2. Manually modify `installer/construct.yml`, `conda-recipe/meta.yaml` and `docs/conf.py` to reflect the new version.
3. Commit the changes.
4. Tag the repository with a new version.
5. Push so Travis CI can proceed.