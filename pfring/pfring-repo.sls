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
    - baseurl: {{ config.package.repo_baseurl }}$releasever/$basearch/
    - gpgcheck: 1
    - gpgkey: {{ config.package.repo_gpgkey }}
    - enabled: 1

pf_ring_repo_noarch:
  pkgrepo.managed:
    - name: pfring_noarch
    - comments: |
        # Managed by Salt Do not edit
        # pf-ring repository
    - baseurl: {{ config.package.repo_baseurl }}$releasever/noarch/
    - gpgcheck: 1
    - gpgkey: {{ config.package.repo_gpgkey }}
    - enabled: 1

# Configure repo file for Debian based systems
{% elif salt.grains.get('os_family') == 'Debian' %}
# Import keys for pfring
command-apt-key-pfring:
  cmd.run:
    - name: apt-key adv --fetch-keys {{ config.package.repo_gpgkey }}
    - unless: apt-key list |grep ntop.org

pf_ring_repo:
  pkgrepo.managed:
    - name: {{ config.package.repo_baseurl }} x64/
    - file: /etc/apt/sources.list.d/pfring-stable.list
    - comments: |
        # Managed by Salt Do not edit
        # pf-ring repository
    - enabled: 1

pf_ring_repo_noarch:
  pkgrepo.managed:
    - name: {{ config.package.repo_baseurl }} all/
    - file: /etc/apt/sources.list.d/pfring-extra-stable.list
    - comments: |
        # Managed by Salt Do not edit
        # pf-ring repository
    - enabled: 1

{% endif %}
{% endif %}
