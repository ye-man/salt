local Build(target, py_version, target_branch = 'develop', tests_dir='tests/', excludes=[]) = {

  kind: 'pipeline',
  name: target + ' ' + tests_dir + ' py' + py_version,
  steps: [
    {
      name: 'test ' + target + ' ' + tests_dir + ' py' + py_version,
      image: 'saltstack/au-' + target + ':ci-' + target_branch + '-py' + py_version,
      commands: [
        'tox -e py' + py_version + '-pytest -- --ssh-tests --run-destructive -vv -ra --sysinfo --sys-stats ' + tests_dir
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

local test_dirs = [
  'tests/unit',
  'tests/integration/cli',
  'tests/integration/client',
  'tests/integration/cloud',
  'tests/integration/daemons',
  'tests/integration/doc',
  'tests/integration/externalapi',
  'tests/integration/grains',
  'tests/integration/loader',
  'tests/integration/logging',
  'tests/integration/minion',
  'tests/integration/modules',
  'tests/integration/netapi',
  'tests/integration/output',
  'tests/integration/pillar',
  'tests/integration/proxy',
  'tests/integration/reactor',
  'tests/integration/renderers',
  'tests/integration/returners',
  'tests/integration/runners',
  'tests/integration/scheduler',
  'tests/integration/sdb',
  'tests/integration/shell',
  'tests/integration/spm',
  'tests/integration/ssh',
  'tests/integration/states',
  'tests/integration/utils',
  'tests/integration/wheel'
];

[
  Build(distro.name + '-' + distro.version, py_version, tests_dir=tests_dir)
  for distro in distros
  for py_version in ['2', '3']
  for tests_dir in test_dirs
]
