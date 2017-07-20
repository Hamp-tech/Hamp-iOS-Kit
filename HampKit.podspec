Pod::Spec.new do |s|

  s.name         = "HampKit"
  s.version      = "0.1"
  s.summary      = "HampKit encapsulates all requests in on framework."
  s.description  = <<-DESC
                    Swift kit to manage all HAMP connections to firebase and web server
                   DESC

  s.homepage     = "https://github.com/Hamp-tech/Hamp-iOS-Kit"
  s.license      = 'MIT'
  s.author       = { "Hamp" => "joanmramon@gmail.com" }

  s.source       = { :git => "https://github.com/Hamp-tech/Hamp-iOS-Kit.git", :tag => s.version }
  s.source_files = "Sources/**/*.{swift}"

  s.dependency 'FirebaseCommunity'
  s.dependency 'FirebaseCommunity/Auth'
  s.dependency 'FirebaseCommunity/Database'
  s.dependency 'Alamofire', '~> 4.4'

end
