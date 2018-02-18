{% from "pfring/map.jinja" import host_lookup as config with context %}

# Configure MANAGEMENT_INTERFACES settings for pfring
pfring_managment_interface:
  file.replace:
    - name: {{ config.pfring.base_dir }}/interfaces.conf
    - pattern: |
        .?MANAGEMENT_INTERFACES="[a-zA-z0-9]+"
    - repl: |
        MANAGEMENT_INTERFACES="{{ config.pfring.interfaces.management }}"

# Configure CAPTURE_INTERFACES settings for pfring
pfring_capture_interface:
  file.replace:
    - name: {{ config.pfring.base_dir }}/interfaces.conf
    - pattern: |
        .?CAPTURE_INTERFACES="[a-zA-z0-9 ]+"
    - repl: |
        CAPTURE_INTERFACES="{{ config.pfring.interfaces.capture.device_names }}"

# Configure modprobe options
/etc/modprobe.d/pf_ring.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - contents: |
        options pf_ring enable_tx_capture={{ config.pfring.interfaces.capture.enable_tx }} min_num_slots={{ config.pfring.interfaces.capture.min_num_slots }}

# Configure network options
network_configure_{{ config.pfring.interfaces.capture.device_names }}:
  network.managed:
    - name: {{ config.pfring.interfaces.capture.device_names }}
    - enabled: True
    - retain_settings: True
    - type: eth
    - proto: none
    - autoneg: on
    - duplex: full
    - rx: off
    - tx: off
    - sg: off
    - tso: off
    - ufo: off
    - gso: off
    - gro: off
    - lro: off

# Manage systemd unit file to control promiscuous mode
/usr/lib/systemd/system/netcfg@.service:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
    - contents: |
        [Unit]
        Description=Control promiscuous mode for interface %i
        After=network.target

        [Service]
        Type=oneshot
        ExecStart={{ config.pfring.interfaces.ip_binary_path }} link set %i promisc on
        ExecStop={{ config.pfring.interfaces.ip_binary_path }} link set %i promisc off
        RemainAfterExit=yes

        [Install]
        WantedBy=multi-user.target

