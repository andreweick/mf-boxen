require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

define ruby::all::gem (
    $version = undef,
    $ensure = present
  ){
  ruby::gem {"${name}-1.8.7":
    ensure => $ensure,
    gem     => $name,
    ruby    => '1.8.7',
    require => Ruby::Version['1.8.7'],
    version => $version,
  }
  ruby::gem {"${name}-1.9.2":
    ensure => $ensure,
    gem     => $name,
    ruby    => '1.9.2',
    require => Ruby::Version['1.9.2'],
    version => $version,
  }
  ruby::gem {"${name}-1.9.3":
    ensure => $ensure,
    gem     => $name,
    ruby    => '1.9.3',
    require => Ruby::Version['1.9.3'],
    version => $version,
  }
  ruby::gem {"${name}-2.0.0-p353":
    ensure => $ensure,
    gem     => $name,
    ruby    => '2.0.0-p353',
    require => Ruby::Version['2.0.0-p353'],
    version => $version,
  }
}

node default {
  # core modules, needed for most things
  # include dnsmasq
  # include nginx
  include git

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  include nodejs::v0_6
  include nodejs::v0_8
  include nodejs::v0_10

  # default ruby versions
  include ruby
  ruby::version { '1.8.7': }
  ruby::version { '1.9.2': }
  ruby::version { '1.9.3': }
  ruby::version { '2.0.0-p353': }
}
