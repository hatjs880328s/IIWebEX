#
# Be sure to run `pod lib lint IIWebEX.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IIWebEX'
  s.version          = '0.2.0'
  s.summary          = 'IIWebEX'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
IIWebEX
分层处理iiwebex
BLL, DAL, USL, Utility
cisco - webex
                       DESC

  s.homepage         = 'https://github.com/hatjs880328s/IIWebEX'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hatjs880328s' => 'shanwzh@inspur.com' }
  s.source           = { :git => 'https://github.com/hatjs880328s/IIWebEX.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'IIWebEX/Classes/**/*'

  s.swift_version = '5.0'


  s.pod_target_xcconfig = { "DEFINES_MODULE" => "YES" }




  s.dependency 'IISwiftBaseUti'
  s.dependency 'IIUIAndBizConfig'
  s.dependency 'IIBLL'
  s.dependency 'IIComponents'
  s.dependency 'IIAOPNBP'
  s.dependency 'IIHTTPRequest'
  s.dependency 'IIOCUtis'
  s.dependency 'IIBaseComponents'
  
  s.dependency 'HandyJSON', '5.0.0'
  s.dependency 'RxSwift', '5.0.0'
  s.dependency 'RxCocoa', '5.0.0'
  s.dependency 'RxDataSources', '4.0.1'

end
