#!/bin/bash

install_podman() {
	export podmanVersion="$(echo $( sudo podman version --format '{{.Version}}'))"
	echo $podmanVersion
	if [ ! -z "$podmanVersion" ]; then
		echo "found existing installation of podman so skipping the installation"
	else
	    echo "installing podman"
		echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_'"$(lsb_release -sr)"'/ /' | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
		curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_"$(lsb_release -sr)"/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/devel_kubic_libcontainers_stable.gpg > /dev/null
		sudo apt-get update -y
	    sudo apt-get upgrade -y
	    sudo apt-get install podman -y
		export podmanVersion="$(echo $( podman version --format '{{.Version}}'))"
		if [ ! -z "$podmanVersion" ]; then
	    	echo "installing podman completed"
		else
			echo "installing podman failed"
		fi
	fi
}

install_podman