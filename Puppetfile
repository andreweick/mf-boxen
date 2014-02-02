# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod name, :path => "#{ENV['HOME']}/src/boxen/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.3.4"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "dnsmasq",    "1.0.1"
github "foreman",    "1.0.0"
github "gcc",        "2.0.1"
github "git",        "1.3.7"
github "go",         "1.0.0"
github "homebrew",   "1.6.0"
github "inifile",    "1.0.0", :repo => "puppetlabs/puppetlabs-inifile"
github "nginx",      "1.4.2"
github "nodejs",     "3.3.0"
github "openssl",    "1.0.0"
github "phantomjs",  "2.0.2"
github "pkgconfig",  "1.0.0"
github "repository", "2.2.0"
github "ruby",       "7.1.1"
github "stdlib",     "4.1.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",       "1.0.0"
github "xquartz",    "1.1.0"
github "module-data","0.0.1", :repo => "ripienaar/puppet-module-data"

# Optional/custom modules. There are tons available at
# https://github.com/boxen.

github "java",            "1.2.0"
github "iterm2",          "1.0.6"
github "wget",            "1.0.0"
github "clojure",         "1.2.0"

github "intellij",        "1.4.0"
github "gitx",            "1.2.0"
github "chrome",          "1.1.2"
github "dropbox",         "1.2.0"
github "firefox",         "1.1.7"
github "alfred",          "1.1.7"
github "vmware_fusion",   "1.1.0"
github "textexpander",    "1.0.1"

github "sublime_text_3",  "1.0.2",  :repo => "jozefizso/puppet-sublime_text_3"
github "pathfinder",      "0.0.1",  :repo => "bradhouse/puppet-pathfinder"
github "mactex",          "0.1.0",  :repo => "omegaice/puppet-mactex"

github "hub",             "1.3.0",  :repo => "andreweick/puppet-hub"
github "font",            "0.0.1",  :repo => "andreweick/puppet-font"
github "osx" ,            "2.2.2",  :repo => "andreweick/puppet-osx"
