# Be sure to run 'pod lib lint' to ensure this is a valid spec before submitting.

Pod::Spec.new do |s|

  s.name             = 'WYZSound'
  s.version          = '0.1.1'
  s.license          = 'MIT'
  s.summary          = 'Sounds effects library.'
  s.homepage         = 'https://github.com/wyzzarz/WYZSound'
  s.author           = 'Warner Zee'
  s.source           = { :git => 'https://github.com/wyzzarz/WYZSound.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'WYZSound/Classes/**/*'
  s.frameworks = 'AVFoundation'

  s.description      = <<-DESC
A library of sound effects.  Includes text to speech.
                       DESC

end
