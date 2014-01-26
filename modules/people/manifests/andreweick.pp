class people::andreweick {
  include iterm2::stable
# include iterm2::colors::solarized_light

  include zsh
  include dropbox
  include chrome
  include pathfinder
#  include kaleidoscope 
  include gitx
  include dropbox
  include alfred
  include imagemagick
  include font::source-code-pro
#  include mactex::full

  #OSX
  # osx::recovery_message { 'If this Mac is found, please call 703.291.6720': }
  # include osx::keyboard::capslock_to_control
  # include osx::global::expand_save_dialog  


  include sublime_text_3
  include sublime_text_3::package_control
  sublime_text_3::package { 'GitGutter':
    source => 'jisaacks/GitGutter'
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
