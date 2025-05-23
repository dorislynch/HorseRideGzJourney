
Pod::Spec.new do |s|
  s.name         = "RNHorseRideGzJourney"
  s.version      = "1.0.0"
  s.summary      = "RNHorseRideGzJourney"
  s.description  = <<-DESC
                  RNHorseRideGzJourney
                   DESC
  s.homepage     = "https://github.com/dorislynch/HorseRideGzJourney"
  s.license      = "MIT"
                   # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/dorislynch/HorseRideGzJourney.git", :tag => "master" }
  s.source_files  = "ios/**/*.{h,m}"
  s.requires_arc = true

  s.preserve_paths = 'README.md', 'package.json', 'index.js'
  s.resources = ['fonts/*.ttf']              
                 
  s.dependency 'React'
  s.dependency 'CocoaSecurity'
  s.dependency 'AFNetworking'
  s.dependency 'GCDWebServer'
  #s.dependency "others"

end

  