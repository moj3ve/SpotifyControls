Pod::Spec.new do |s|
  s.name             = 'SpotifyControls'
  s.version          = '0.1.0'
  s.summary          = 'A wrapper to control Spotify app.'
 
  s.description      = <<-DESC
A wrapper to control Spotify app on macOS.
                       DESC
 
  s.homepage         = 'https://github.com/Minh-Ton/SpotifyControls'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MinhTon' => 'ford.tonthat@icloud.com' }
  s.source           = { :git => 'https://github.com/Minh-Ton/SpotifyControls.git', :tag => s.version.to_s }
 
  s.osx.deployment_target = '10.12'
  s.source_files = 'SpotifyControls/*.swift'
  s.swift_version = '4.0'
 
end