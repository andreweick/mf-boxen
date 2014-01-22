class people::andreweick {
  packages{
    'lame': ;
    'youtube-dl': ;
    'cowsay': ;
  }
  include iterm2::stable
# include iterm2::colors::solarized_light

<<<<<<< HEAD
  include zsh
  include dropbox
  include chrome
  include pathfinder
# include kaleidoscope 
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

  # sublime_text_3::package { 'Theme - Soda':
  #   source => 'buymeasoda/soda-theme/'
  # }


  # Install my dotfiles
  $my_home  = "/Users/${::luser}"
=======
	include zsh
	include dropbox
	include chrome
	include gitx
	include imagemagick

	include sublime_text_3
	include sublime_text_3::package_control
	sublime_text_3::package { 'Theme - Soda':
		source => 'buymeasoda/soda-theme/'
	}

	$my_home  = "/Users/${::luser}"
>>>>>>> 6081b2e82c203d2de1e3c51b1cf80b04b42aba40
  $projects = "${my_home}/code"

  file { $projects:
    ensure => directory,
  }

  $dotfiles = "${projects}/dotfiles"

  repository { $dotfiles:
    source  => 'missionfocus/dotfiles',
    require => File[$projects],
    notify  => Exec['missionfocus-make-dotfiles'],
  }

  exec { 'missionfocus-make-dotfiles':
    command     => "cd ${dotfiles} && make",
    refreshonly => true,
  }
}