Pod::Spec.new do |s|
  s.name        = "SaguaroLogger"
  s.version     = "0.90.10"
  s.summary     = "A swift multi-level, multi-target logger for iOS/OSX applications"
  s.homepage    = "https://github.com/darrylwest/saguaro-logger"
  s.license     = { :type => "MIT" }
  s.authors     = { "darryl.west" => "darryl.west@raincitysoftware.com" }
  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "8.0"
  s.source      = { :git => "https://github.com/darrylwest/saguaro-logger.git", :tag => "0.90.0"}
  s.source_files = "SaguraroLogger/*.swift"
end
