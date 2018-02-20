{% if grains['os_family'] == 'RedHat' %}

# Install epel if running RHEL based system
package-install-epel-pfring:
  pkg.installed:
    - pkgs:
      - epel-release                 # Base install
    - refresh: True

{% elif grains['os_family'] == 'Debian' %}

# Install kernel header if running Debian based system
{% set kernel = salt['grains.get']('kernelrelease') %}
package-install-kernel-headers-pfring:
  pkg.installed:
    - pkgs:
      - linux-headers-{{ kernel }}   # Base install
    - refresh: True

{% endif %}
