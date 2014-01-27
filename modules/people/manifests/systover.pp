class people::systover {
	include iterm2::stable

	include zsh
	include gitx

	include osx::disable_app_quarantine

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