#!/usr/bin/env bash

echo "Exporting environment variables ..."
if [[ "${ML_USER}" ]]; then
    echo "Found ML_USER. Adding environment variables for ML_USER=${ML_USER}."
    # For bash
    printenv | grep -E '^RUNPOD_|^PATH=|^_=' | awk -F = '{ print "export " $1 "=\"" $2 "\"" }' >> /tmp/rp_environment_bash
    echo 'source /tmp/rp_environment_bash' >> /home/"${ML_USER}"/.bashrc
    cat /tmp/rp_environment_bash

    # For fish
    printenv | grep -E '^RUNPOD_|^PATH=' | awk -F = '{ print "set -x -g " $1 " \"" $2 "\"" }' >> /tmp/rp_environment_fish
    echo 'source /tmp/rp_environment_fish' >> /home/"${ML_USER}"/.config/fish/config.fish
    cat /tmp/rp_environment_fish
else
    echo "ML_USER not found. No environment variables added."
fi


echo "Adding public key ..."
if [[ "${PUBLIC_KEY}" ]]; then
    echo "Found PUBLIC_KEY; adding to /home/${ML_USER}/.ssh/authorized_keys."
    echo "${PUBLIC_KEY}" >> "/home/${ML_USER}/.ssh/authorized_keys"
    chmod 600 "/home/${ML_USER}/.ssh/authorized_keys"
    chown "${ML_USER}":"${ML_USER}" "/home/${ML_USER}/.ssh/authorized_keys"
else
    echo "No PUBLIC_KEY found. Nothing to add."
fi

service nginx start
service ssh start
sleep infinity
