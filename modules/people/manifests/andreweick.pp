class people::andreweick {
  include gitx
  include dropbox
  include chrome
  include alfred
  include font::source-code-pro
  include vmware_fusion
  include textexpander
  include mactex::full

  include hub

  include iterm2::stable
# include iterm2::colors::solarized_light

  include sublime_text_3
  include sublime_text_3::package_control
  sublime_text_3::package { 'GitGutter':
    source => 'jisaacks/GitGutter'
  }

  sublime_text_3::package { 'PlainTasks':
    source => 'aziz/PlainTasks'
  }

  sublime_text_3::package { 'MarkdownEditing':
    source => 'SublimText-Markdown/MarkdownEditing'
  }

  sublime_text_3::package { 'open-url':
    source => 'noahcoad/open-url'
  }

  sublime_text_3::package { 'Sublime-TableEditor':
    source => 'vkocubinsky/Sublime-TableEditor'
  }

  $hombrew_packages = [
    'ack',
    'wget',
    'curl',
    'nmap',
    'zsh',
    'sitespeedio/sitespeedio/sitespeed.io',
    'imagemagick'    
  ]

  package { $hombrew_packages: }


  package { 'Pandoc':
    source    => 'https://pandoc.googlecode.com/files/pandoc-1.12.1-1.dmg',
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
  $my_username = "maeick"

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

  ###############
  # User Config #
  ###############

  # Changes the default shell to the zsh version we get from Homebrew
  # Uses the osx_chsh type out of boxen/puppet-osx
  osx_chsh { ${::luser}:
    shell   => '/opt/boxen/homebrew/bin/zsh',
    require => Package['zsh']
  }

  osx::recovery_message { 'If this laptop found, please contact business@missionfocus.com or call 703.291.6720': }
}
