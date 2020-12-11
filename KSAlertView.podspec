Pod::Spec.new do |spec|
  spec.name         = "KSAlertView"
  spec.version      = "1.0.0"
  spec.summary      = "仿系统样式AlertView、支持单选、多选、图片弹框等"
  spec.description  = <<-DESC
                      多种样式的AlertView
                   DESC
  spec.homepage     = "https://github.com/Turboks/KSAlertView"
  spec.license      = "MIT"
  spec.author             = { "Turboks" => "turboks@163.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/Turboks/KSAlertView.git", :tag => "#{spec.version}" }
  spec.source_files  = "KSAlertView/*.{h}"
end
