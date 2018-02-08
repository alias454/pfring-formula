{% from "pfring/map.jinja" import host_lookup as config with context %}
{% if config.pfring.install_type == 'package' %}
# Installing from package

# Configure repo file for RHEL based systems
{% if salt.grains.get('os_family') == 'RedHat' %}
pf_ring_repo:
  pkgrepo.managed:
    - name: pfring
    - comments: |
        # Managed by Salt Do not edit
        # pf-ring repository 
    - baseurl: {{ config.pfring.repo_baseurl }}$releasever/$basearch/
    - gpgcheck: 1
    - gpgkey: {{ config.pfring.repo_gpgkey }}
    - enabled: 1

pf_ring_repo_noarch:
  pkgrepo.managed:
    - name: pfring_noarch
    - comments: |
        # Managed by Salt Do not edit
        # pf-ring repository 
    - baseurl: {{ config.pfring.repo_baseurl }}$releasever/noarch/
    - gpgcheck: 1
    - gpgkey: {{ config.pfring.repo_gpgkey }}
    - enabled: 1

{% endif %}
{% endif %}
