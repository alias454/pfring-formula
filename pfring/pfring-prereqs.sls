{% if grains['os_family'] == 'RedHat' %}

# Install epel if running RHEL based system
package-install-epel-pfring:
  pkg.installed:
    - pkgs:
      - epel-release             # Base install
    - refresh: True

{% endif %}
