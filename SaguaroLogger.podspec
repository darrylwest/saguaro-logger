Pod::Spec.new do |s|
  s.name        = "SaguaroLogger"
  s.version     = "0.91.17"
  s.summary     = "A swift 2.0 multi-level, multi-target logger for iOS/OSX applications"
  s.homepage    = "https://github.com/darrylwest/saguaro-logger"
  s.license     = { :type => "MIT" }
  s.authors     = { "darryl.west" => "darryl.west@raincitysoftware.com" }
  s.osx.deployment_target = "10.10"
  s.ios.deployment_target = "8.0"
  s.source      = { :git => "https://github.com/darrylwest/saguaro-logger.git", :tag => s.version }
  s.source_files = "SaguaroLogger/*.swift"
end
