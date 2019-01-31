local Build(target, py_version, target_branch = 'develop') = {

  kind: 'pipeline',
  name: target + '-py' + py_version,
  steps: [
    {
      name: 'test-' + target + '-py' + py_version,
      image: 'saltstack/au-' + target + ':ci-' + target_branch + '-py' + py_version,
      commands: [
        'sudo tox -e py' + py_version + '-pytest'
      ]
    }
  ]
};

local distros = [
#  { name: 'centos', version: '6' },
  { name: 'centos', version: '7' },
#  { name: 'debian', version: '8' },
#  { name: 'debian', version: '9' },
#  { name: 'fedora', version: '28' },
#  { name: 'fedora', version: '29' },
#  { name: 'opensuse', version: '15.0' },
#  { name: 'opensuse', version: '42.3' },
#  { name: 'ubuntu', version: '14.04' },
  { name: 'ubuntu', version: '16.04' },
#  { name: 'ubuntu', version: '18.04' },
];


[
  Build(distro.name + '-' + distro.version, py_version)
  for distro in distros
  for py_version in ['2', '3']
]
