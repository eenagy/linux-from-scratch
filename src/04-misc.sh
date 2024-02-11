#! /bin/bash

check_hostname() {
    expected_hostnames=("lfs-host")
    current_hostname=$(hostname)

    for expected_hostname in "${expected_hostnames[@]}"; do
        if [ "$current_hostname" = "$expected_hostname" ]; then
            echo "Error: This script must not run from host $expected_hostname."
            exit 1
        fi
    done

    echo "Script is allowed to run on host $current_hostname."
}

check_hostname
