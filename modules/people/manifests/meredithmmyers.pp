class people::meredithmmyers {
	include iterm2::stable
#	include iterm2::colors::solarized_light

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