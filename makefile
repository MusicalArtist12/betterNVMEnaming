install:
	mkdir -p /opt/better-nvme-naming
	install --owner=root --group=root opt/better-nvme-naming/startup.sh /opt/better-nvme-naming
	install --owner=root --group=root usr/lib/systemd/system/better-nvme-naming.service /usr/lib/systemd/system

enable:
	systemctl enable better-nvme-naming.service
	