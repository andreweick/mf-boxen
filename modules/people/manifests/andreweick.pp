class people::andreweick {
  include hub
  include gitx
  include dropbox
  include chrome
  include alfred
  include zsh
  include font::source-code-pro
  include vmware_fusion

  include iterm2::stable
# include iterm2::colors::solarized_light

  include sublime_text_3
  include sublime_text_3::package_control
  sublime_text_3::package { 'GitGutter':
    source => 'jisaacks/GitGutter'
  }

  $hombrew_packages = [
    'ack',
    'wget',
    'curl',
    'zsh'
    'nmap',
    'imagemagick'    
  ]

  package { $hombrew_packages: }

  package { 'Pandoc':
    source    => 'https://pandoc.googlecode.com/files/pandoc-1.12.1-1.dmg'
    provider  => pkgdmg,
  }

  git::config::global { 
    'user.email':
      value => 'maeick@missionfocus.com';
    'user.name':
      value => 'Andrew Eick';
    'push.default':
      value => 'matching';
  }


  # Install my dotfiles
  $my_home  = "/Users/${::luser}"
  $projects = "${my_home}/code"

  file { $projects:
    ensure => directory,
  }

  $dotfiles = "${projects}/dotfiles"

  repository { $dotfiles:
    source  => 'andreweick/dotfiles',
    require => File[$projects],
    notify  => Exec['andreweick-make-dotfiles'],
  }

  exec { 'andreweick-make-dotfiles':
    command     => "cd ${dotfiles} && make",
    refreshonly => true,
  }
}
