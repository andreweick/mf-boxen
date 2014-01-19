class people::andreweick {
	include iterm2::stable
#	include iterm2::colors::solarized_light

	include zsh
	include dropbox
	include chrome
  include pathfinder
	include sublime_text_3
	include kaleidoscope 
	include gitx
	include dropbox
	include alfred
	include imagemagick

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