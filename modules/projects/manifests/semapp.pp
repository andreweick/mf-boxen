class projects::semapp {
  include ghostscript
  include redis
  include leiningen
  include nodejs
  include ffmpeg

#  boxen::project { 'semapp':
#    dotenv        => false,
#    elasticsearch => false,
#    mysql         => false,
#    nginx         => false,
#    redis         => false,
#    ruby          => '1.9.3',
#    source        => 'boxen/trollin'
#  }
}