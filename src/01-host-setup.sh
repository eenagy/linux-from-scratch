#! /bin/bash

# Install qemu
qemu_system="qemu-system-x86_64"

if command -v "$qemu_system" &> /dev/null; then
    echo "$qemu_system is installed already."
else
    echo "$qemu_system is not installing, installing it now"
    sudo dnf install "$qemu_system"
fi


debian_image="debian-12.4.0-amd64-netinst.iso"


if [[ -e "$debian_image" ]]; then 
     echo "Image is already downloaded, not downloading it again"
else
    wget "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/$debian_image"
fi 

signature_file=SHA512SUMS.asc
signature_url="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA512SUMS.sign"

if [[ -e "$signature_file" ]]; then 
     echo "Signature exists, not downloading it again"
else
    wget -O "$signature_file" "$signature_url"
fi


sha512sums_file="SHA512SUMS"
sha512sums_url="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/$sha512sums_file"

if [[ -e "$sha512sums_file" ]]; then 
     echo "$sha512sums_file already exists, not dowloading it again"
else
    wget "$sha512sums_url"
fi

key_id="DF9B9C49EAA9298432589D76DA87E80D6294BE9B"

# Check if the key already exists in the keyring
if gpg --list-keys "$key_id" &> /dev/null; then
    echo "Key already exists in the keyring."
else
    # If the key does not exist, import it
    gpg --keyserver hkp://keys.gnupg.net --recv-keys "$key_id"
fi

gpg --verify "$signature_file" "$sha512sums_file"

calculated_checksum=$(sha512sum "$debian_image" | awk '{print $1}')
expected_checksum=$(grep "$debian_image" "$sha512sums_file" | awk '{print $1}')

if [ "$calculated_checksum" == "$expected_checksum" ]; then
    echo "Checksums match. The Debian image is valid."
else
    echo "Checksums do not match. The Debian image may be corrupted."
fi

qemu_img_name="debian12.img"

qemu-img create -f qcow2 "$qemu_img_name" 20G
qemu-system-x86_64 -boot d -cdrom "$debian_image" -hda "$qemu_img_name" -m 2G

