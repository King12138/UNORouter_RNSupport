
Pod::Spec.new do |s|

  s.name         = "UNORouter_RNSupport"
  s.version      = "0.0.1"
  s.summary      = "UNORouter_RNSupport is a AOP tool for UNORoute"

  s.homepage     = "http://sass.lianyuplus.com.cn"
  s.license      = "MIT"
  s.authors      = { "unovo" => "dev.lianyu@unovo.com.cn" }

  s.platform     = :ios, "6.0"
  s.source       = { :path  => 'UNORouter_RNSupport' }
  s.source_files  = "**/*.{h,m}"

  s.public_header_files = "*.h"
  s.requires_arc = true
  
  s.dependency "UNORouter"
  s.dependency "React"

end
