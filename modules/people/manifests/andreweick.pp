class people::andreweick {
	include iterm2::stable
	include iterm2::colors::solarized_light

#	include pathfinder

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