{% from "pfring/map.jinja" import host_lookup as config with context %}

# Make sure pfring service is running and restart the service unless
service-pfring:
  service.running:
    - name: pf_ring
    - enable: True
    - require:
      - pkg: package-install-pfring
    - watch:
      - file: pfring_managment_interface
      - file: pfring_capture_interface

# Make sure netcfg@ service is running and enabled
service-netcfg@{{ config.pfring.interfaces.capture.device_names }}:
  service.running:
    - name: netcfg@{{ config.pfring.interfaces.capture.device_names }}
    - enable: True
    - require:
      - pkg: package-install-pfring
      - file: /usr/lib/systemd/system/netcfg@.service
      - network: network_configure_{{ config.pfring.interfaces.capture.device_names }}

