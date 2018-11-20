
Pod::Spec.new do |s|
  s.name         = "KYCrashHandler"
  s.version      = "0.0.2"
  s.summary      = "a tool to protect from crash and catch crashes."
  s.homepage     = "https://github.com/Deeer/KYCrashHandler"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author    = "Koul Dela"
  s.platform     = "ios"
  s.source       = { :git => "https://github.com/Deeer/KYCrashHandler.git", :tag => "v#{s.version}" }
  s.source_files  = "CrashManager", "CrashManager/*.{h,m}"
  s.public_header_files = "CrashManager/KYCrashBusinessHandler.h"

end
