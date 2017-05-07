[![Build Status](https://travis-ci.org/andrewrothstein/ansible-node.svg?branch=master)](https://travis-ci.org/andrewrothstein/ansible-node)
andrewrothstein.node
=========

Installs [nodejs](https://nodejs.org).

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.node
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
