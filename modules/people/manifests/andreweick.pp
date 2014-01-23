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

  include sublime_text_3
  include sublime_text_3::package_control
  sublime_text_3::package { 'GitGutter':
    source => 'jisaacks/GitGutter'
  }

  git::config::global { 'user.email':
    value => 'maeick@missionfocus.com',
  }

  git::config::global { 'user.name':
    value => 'And Eick',
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
