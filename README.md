Julia Abdel-Monem 2025
Juliaviolet.dev

Licensed by the MIT license

this is completely useless, but a friend wanted it as an option. Use at your own risk

hard links /dev/nvme files to /dev/nd
ignores physical drives, treats namespaces as different drives

/dev/nvme0 -> does not exist
/dev/nvme0n1 -> /dev/nda
/dev/nvme0n2 -> /dev/ndb
/dev/nvme1n1 -> /dev/ndc
/dev/nvme1n2 -> /dev/ndd

partition number goes onto the end