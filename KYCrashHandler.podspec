
Pod::Spec.new do |s|
  s.name         = "KYCrashHandler"
  s.version      = "0.0.3"
  s.summary      = "a tool to protect from crash and catch crashes."
  s.homepage     = "https://github.com/Deeer/KYCrashHandler"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author    	 = "Koul Dela"
  s.platform     = :ios,"11.0"
  s.source       = { :git => "https://github.com/Deeer/KYCrashHandler.git", :tag => "v#{s.version}" }
  s.source_files  = "CrashDemo/KYCrashHandler/*","CrashDemo/Headers/*","CrashDemo/*"
  s.public_header_files = 'CrashDemo/Headers/*.h'
  s.exclude_files = "CrashDemo/*.plist"
  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true #是否要求ARC
end
