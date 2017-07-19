Pod::Spec.new do |s|

  s.name         = "HampKit"
  s.version      = "0.0.1"
  s.summary      = "HampKit encapsulates all requests (server/firebase) in on framework."
  s.description  = <<-DESC
                    Swift Kit to manage all connections to firebase and web server
                   DESC

  s.homepage     = "https://github.com/Hamp-tech/Hamp-iOS-Kit"
  s.license      = 'MIT'
  s.author             = { "Hamp" => "joanmramon@gmail.com" }

  s.source       = { :git => "https://github.com/Hamp-tech/Hamp-iOS-Kit.git", :tag => s.version }
  s.source_files  = "Sources/**/*.{swift}"

  s.frameworks = 'Firebase'
  s.dependency 'Firebase/Auth'
  s.dependency 'Firebase/Database'
  s.dependency 'Firebase/Core'
  s.dependency 'Firebase/Messaging'
  s.dependency 'Alamofire', '~> 4.4'

end
