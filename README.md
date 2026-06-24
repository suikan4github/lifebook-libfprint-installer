# lifebook-libfprint-installer
Tentative libfprint installer for Lifebook U9311/U9312

**C A U T I O N**: The script in this project installs a software which is not officially managed by fprintd project. Run the script at your own risk.

## Details
A Patch for fprintd to suport the fingerprint reader of Fujitsu Lifebook U9311/U9312 has been
developpend by Mr. Sebastian van de Meer. 

[This patch has been sent to the frpintd project](https://gitlab.freedesktop.org/libfprint/libfprint/-/merge_requests/574), but this project is releasing update 
once or twice a year. 

For the people who want to use the finger print on the Fujitsu Lifebook before the official support by fprintd, I have wrote this
script to build and install a libfprintd with the patch. 

Note that the major part of this script has been written and published by Mr. Sebastian van de Meer 
on [his blog](https://www.kernel-error.de/2026/03/17/next-biometrics-nb-2033-u-reverse-engineering-fingerabdruckleser-linux/). 

## Supported OS and hardware
Following distributions and their variants are supported. 

- Ubuntu
- Fedora Workstation

The PC with the NB-2033-U finger print reader is supported(298d:2033). 

To check whether your system has the NB-2033-U, run the following command. 

```sh
lsusb | grep "298d:2033"
```

## Tested environment
Distributions:
- Kubuntu 2026.04 LTS
- Fedora KDE 44

Hardwares:
- Lifebook U9311
- Lifebook U9312

## Install
To install, run the following script:
```sh
./lifebook-fprintd-installer.sh
```

This script install the required package to build, clone the git repository, build and install.

## Enroll the fingerprint and verify
To test the enrolling and verification of finger print, run the following codes:

```sh
sudo systemctl restart fprintd
fprintd-enroll
fprintd-verify
```

After invoking command, text message ask you to puth your finger on the reader. 
Place the specified finger on the reader 5 times. 

Then, another test message ask you to place same finger. And they verify. 

## Uninstall
To uninstall, run the following commands:
```sh
./uninstall.sh
```

## License
This project is published under the [MIT LICENSE](LICENSE).
