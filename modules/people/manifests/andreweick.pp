class people::andreweick {
  include gitx
  include dropbox
  include chrome
  include alfred
  include java
  include vmware_fusion
  include textexpander
  include mactex::basic
  include kaleidoscope

  include python

  include osx::keyboard::capslock_to_control
  include osx::finder::empty_trash_securely

  include hub

  include iterm2::stable
  include iterm2::colors::solarized_light

  include font::source-code-pro
  include font::sketchnote
  include font::hoefler
  include font::comicbookfonts
  include font::myfonts

  include sublime_text_3
  include sublime_text_3::package_control
  sublime_text_3::package { 'GitGutter':
    source => 'jisaacks/GitGutter'
  }

  sublime_text_3::package { 'PlainTasks':
    source => 'aziz/PlainTasks'
  }

  sublime_text_3::package { 'MarkdownEditing':
    source => 'SublimeText-Markdown/MarkdownEditing'
  }

  sublime_text_3::package { 'open-url':
    source => 'noahcoad/open-url'
  }

  sublime_text_3::package { 'SublimeTableEditor':
    source => 'vkocubinsky/SublimeTableEditor'
  }

  # install package named "Theme - Soda" from GitHub repository
  # will be stored in "Packages/Theme - Soda"
  sublime_text_3::package { 'Theme - Soda':
    source => 'buymeasoda/soda-theme'
  }

  $hombrew_packages = [
    'ack',
    'wget',
    'curl',
    'nmap',
    'zsh',
    'tig',
    'ffmpeg',
    'imagemagick'    
  ]

  package { $hombrew_packages: }

  # Install sitespeed.io
  homebrew::tap { 'sitespeedio/sitespeedio': }
  homebrew::tap { 'tobli/browsertime': }
  package { "sitespeed.io":
    ensure => present,
    require => Homebrew::Tap['sitespeedio/sitespeedio','tobli/browsertime'],
  } 

  # Install linode cli
  homebrew::tap { 'linode/cli': }
  package { "linode-cli":
    ensure => present,
    require => Homebrew::Tap['linode/cli'],
  } 

  exec { 'install speedtest-cli':
    command => 'easy_install speedtest-cli',
  }
  # for pdflatex
  package { 'Pandoc':
    source    => 'https://pandoc.googlecode.com/files/pandoc-1.12.1-1.dmg',
    provider  => pkgdmg,
  }

  package { 'GPGTools':
    source    => 'https://github.com/downloads/GPGTools/GPGTools/GPGTools-20120318.dmg',
    provider  => 'appdmg'
  }

  # # [Quicklook markdown for preview](https://github.com/toland/qlmarkdown)
  # package { 'QLMarkdown':
  #   source    => 'https://github.com/downloads/toland/qlmarkdown/QLMarkdown-1.3.zip',
  #   provider  =>
  # }

  # [Galileo](http://jacksongariety.github.io/Galileo)
  # Search your starred GitHub repos from the shell 
  ruby::gem{ 'Galileo':
    gem       => galileo,
    ruby      => '2.0.0-p353'
  }

  git::config::global { 
    'user.email':
      value => 'maeick@missionfocus.com';
    'user.name':
      value => 'Andrew Eick';
    'push.default':
      value => 'matching';
    # 'difftool "Kaleidoscope".cmd':
    #   value => 'ksdiff --partial-changeset --relative-path \"$MERGED\" -- \"$LOCAL\" \"$REMOTE\"';
    # 'diff.tool': 
    #   value => 'Kaleidoscope';
    # 'difftool.prompt':
    #   value => 'false';
    # 'mergetool "Kaleidoscope".cmd':
    #   value => 'ksdiff --merge --output \"$MERGED\" --base \"$BASE\" -- \"$LOCAL\" --snapshot \"$REMOTE\" --snapshot';
    # 'mergetool.trustExitCode':
    #   value => 'true';
    # 'mergetool.prompt':
    #   value => 'false';
    # 'merge.tool':
    #   value => 'Kaleidoscope';
    # 'alias.ksreview':
    #   value => '"!f() { local SHA=${1:-HEAD}; local BRANCH=${2:-master}; if [ $SHA == $BRANCH ]; then SHA=HEAD; fi; git difftool -y -t Kaleidoscope $BRANCH...$SHA; }; f"';
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
  osx_chsh { $my_username:
    shell   => '/opt/boxen/homebrew/bin/zsh',
    require => Package['zsh']
  }

  osx::recovery_message { 'If this laptop found, please contact business@missionfocus.com or call 703.291.6720': }

  repository { "${projects}/aedc2":
    source  => "andreweick/aedc2"
  }

  repository { "${projects}/mf-boxen":
    source  => "andreweick/mf-boxen"
  }

  repository { "${projects}/aedc":
    source  => "andreweick/aedc"
  }

  repository { "${projects}/imageprep":
    source  => "andreweick/imageprep"
  }

  repository { "${projects}/puppet-font":
    source  => "andreweick/puppet-font"
  }

  repository { "${projects}/missionfocus":
    source  => "imintel/missionfocus"
  }

  repository { "${projects}/imi":
    source  => "andreweick/imi"
  }

  package { 'Transmit':
    source    => 'http://www.panic.com/transmit/d/Transmit%204.4.5.zip',
    provider  => 'compressed_app',
  }

  package { 'MailMate':
    source    => 'http://dl.mailmate-app.com/MailMate.tbz',
    provider  => 'compressed_app',
  }

  package { 'SuperDuper':
    source    => 'http://www.shirt-pocket.com/mint/pepper/orderedlist/downloads/download.php?file=http%3A//www.shirt-pocket.com/downloads/SuperDuper%21.dmg',
    provider  => 'appdmg_eula',
  }

  package { 'Keyboard Maestro':
    source    => 'http://files.stairways.com/keyboardmaestro-632.zip',
    provider  => 'compressed_app',
  }

  package { 'Bartender':
    source    => 'http://www.macbartender.com/Demo/Bartender.zip',
    provider  => 'compressed_app'
  }

  package { 'Fluid app':
    source    => 'http://fluidapp.com/dist/Fluid_1.7.2.zip',
    provider  => 'compressed_app'
  }

  package { 'BetterZip':
    source    => 'http://macitbetter.com/BetterZip.zip',
    provider  => 'compressed_app'
  }

  package { 'OmniGraffle':
    source    => 'http://downloads2.omnigroup.com/software/MacOSX/10.8/OmniGraffle-6.0.4.dmg',
    provider  => 'appdmg_eula',
  }

  package { 'OmniPlan':
    source    => 'http://downloads2.omnigroup.com/software/MacOSX/10.8/OmniPlan-2.3.3.dmg',
    provider  => 'appdmg_eula',
  }

  package { 'OmniOutliner':
    source    => 'http://downloads2.omnigroup.com/software/MacOSX/10.9/OmniOutliner-4.0.2.dmg',
    provider  => 'appdmg_eula',
  }
}
