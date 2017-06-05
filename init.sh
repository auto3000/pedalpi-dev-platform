# Note that this script is supposed to be sourced,
# and only works with bash or zsh, not a vanilla bourne shell

if [ -z "$BASH_VERSION" -a -z "$ZSH_VERSION" ] ; then
    echo This sript only works with bash or zsh as the interactive shell.
    echo Please retry with bash or zsh.
    return 1
fi

function setupGitSubmodules() {
    local choice=$1
    if [[ $2 == "accept-eula" ]] ; then
        local eula=true
    fi
    echo "You selected target $choice"

    local targets=(
        "raspberrypi2"
        "raspberrypi3"
    local supported=(
        "qemux86-64"
        "raspberrypi2"
        "raspberrypi3")
    local modules=()
    local target=""

    for i in ${targets[@]}
    do
        if [[ $i == $choice ]]
        then
            target=$choice
            echo "$target is a valid target"
            break
        fi
    done

    if test -z "$target" ; then
        echo "An invalid or empty target name was given: $choice  Available targets are:"
        printf '%s\n' "${targets[@]}"
        echo -e "\nUsage: source init.sh <target> [-f]"
        return 1
    else
        if [[ ! ${supported[@]} =~ "$target" ]] && [[ ${!#} != "-f" ]]; then
            echo "However currently, only the following targets are officially supported:"
            printf '%s\n' "${supported[@]}"
            echo "You can either "
            echo "re-run with a supported target (or override this check with -f)"
            return 1
        fi
    fi


    echo "Generating bitbake configuration files for $target"

    cp pedalpi-src-build/conf/templates/${target}.local.conf pedalpi-src-build/conf/local.conf
    cp pedalpi-src-build/conf/templates/${target}.bblayers.conf pedalpi-src-build/conf/bblayers.conf


    echo "Local & bblayers conf set for $target"

    # Define hardware-dependent layers.
    # Multiple layers can be specified for a target if space-separated.
    declare -A bsparr
    bsparr["raspberrypi2"]="meta-raspberrypi"
    bsparr["raspberrypi3"]="meta-raspberrypi"

    # This looks somewhat complex but the intention is to clone only needed
    # submodules.  The module list is calculated as : all the submodules we
    # have (as reported by git) *minus* BSP-related layers that are NOT
    # relevant for the chosen $target.  In other words - loop through all BSP
    # layers and delete them from array unless they are the layer (or layers)
    # defined for this $target.
    modules=($(git submodule | awk '{ print $2 }'))

    for i in ${bsparr[@]}; do
        local found=false

        # Multiple BSP layers per target are supported so loop over them just in case
        for bsp in ${bsparr[${target}]} ; do
            if [[ $i == $bsp ]] ; then
                found=true
            fi
        done

        if ! $found ; then
            # This BSP is not for the $target, so delete it from the list
            modules=(${modules[@]//*$i*})
        fi
    done

    git submodule init "${modules[@]}"

    git submodule sync "${modules[@]}"

    git submodule update "${modules[@]}"

    return 0
}


if setupGitSubmodules $1 $2 $3 ; then
    source poky/oe-init-build-env pedalpi-src-build
    echo
    echo "Now run:  bitbake pedalpi-dev-platform"
fi

