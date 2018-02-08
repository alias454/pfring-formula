================
pfring-formula
================

A saltstack formula to install pf_ring on RHEL based systems.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``pfring-repo``
------------
Manage repo files on RHEL/CentOS 7 systems.

``pfring-prereqs``
------------
Install prerequisite packages

``pfring-package``
------------
Install pfring packages

``pfring-config``
------------
Manage configuration file placement

``pfring-service``
------------
Manage pfring service and a service to manage promiscuous mode of defined network interfaces on RHEL/CentOS 7 systems.
