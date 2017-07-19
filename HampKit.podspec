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

  #All this to link Firebase on the pod

  s.libraries = [
  'c++', # FirebaseAnalytics.
  'icucore', # FirebaseDatabase.
  'sqlite3', # FirebaseAnalytics.
  'z', # FirebaseAnalytics.
  ]

  # Specify what frameworks this depends on.
  s.frameworks = [
    'AddressBook', # FirebaseAnalytics.
    'AdSupport', # FirebaseAnalytics.
    'CFNetwork', # FirebaseDatabase.
    'CoreGraphics',
    'SafariServices', # FirebaseAnalytics.
    'Security', # FirebaseAnalytics, FirebaseAuth, FirebaseDatabase.
    'StoreKit', # FirebaseAnalytics.
    'SystemConfiguration', # FirebaseAnalytics, FirebaseDatabase.
    'UIKit',
  ]

  s.vendored_frameworks = [
      # Firebase Analytics.
      'HampKit/Frameworks/Firebase/Analytics/FirebaseAnalytics.framework',
      'HampKit/Frameworks/Firebase/Analytics/FirebaseInstanceID.framework',
      'HampKit/Frameworks/Firebase/Analytics/GoogleInterchangeUtilities.framework',
      'HampKit/Frameworks/Firebase/Analytics/GoogleSymbolUtilities.framework',
      'HampKit/Frameworks/Firebase/Analytics/GoogleUtilities.framework',

      # FirebaseAuth.
      'HampKit/Frameworks/Firebase/Auth/FirebaseAuth.framework',
      'HampKit/Frameworks/Firebase/Auth/GoogleNetworkingUtilities.framework',
      'HampKit/Frameworks/Firebase/Auth/GoogleParsingUtilities.framework',

      # FirebaseDatabase.
      'HampKit/Frameworks/Firebase/Database/FirebaseDatabase.framework',

      # FirebaseMessaging.
      'HampKit/Frameworks/Firebase/Messaging/FirebaseMessaging.framework',
      'HampKit/Frameworks/Firebase/Messaging/GoogleIPhoneUtilities.framework',
  ]

  # LDFLAGS required by Firebase dependencies.
  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '$(inherited) -ObjC',
  }

  s.dependency 'Firebase/Auth'
  s.dependency 'Firebase/Database'
  s.dependency 'Firebase/Core'
  s.dependency 'Firebase/Messaging'
  s.dependency 'Alamofire', '~> 4.4'

end
