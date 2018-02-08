{% from "pfring/map.jinja" import host_lookup as config with context %}
{% if config.pfring.install_type == 'package' %}

# Install pf-ring from a package
package-install-pfring:
  pkg.installed:
    - pkgs:
      - pfring
      - pfring-dkms
    - refresh: True

{% endif %}
