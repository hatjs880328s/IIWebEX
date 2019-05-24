#
# Be sure to run `pod lib lint IIWebEX.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IIWebEX'
  s.version          = '0.1.0'
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

  # s.source_files = 'IIWebEX/Classes/**/*'


  s.pod_target_xcconfig = { "DEFINES_MODULE" => "YES" }

  s.subspec 'DAL' do |ss|
      ss.source_files = 'IIWebEX/Classes/DAL/*.*'
  end

  s.subspec 'MODEL' do |ss|
      ss.source_files = 'IIWebEX/Classes/MODEL/*.*'
  end

  s.subspec 'Utility' do |ss|
      ss.source_files = 'IIWebEX/Classes/Utility/*.*'
  end

  s.subspec 'BLL' do |ss|
      ss.source_files = 'IIWebEX/Classes/BLL/*.*'
  end

  s.subspec 'USL' do |ss|
      ss.subspec 'VM' do |sss|
          sss.source_files = 'IIWebEX/Classes/USL/VM/*.*'
      end
      ss.subspec 'V' do |sss|
          sss.source_files = 'IIWebEX/Classes/USL/V/*.*'
      end
      ss.subspec 'C' do |sss|
          sss.source_files = 'IIWebEX/Classes/USL/C/*.*'
      end
  end

  s.swift_version = '5.0'

  s.dependency 'IISwiftBaseUti'
  s.dependency 'IIUIAndBizConfig'
  s.dependency 'IIBLL'
  s.dependency 'IIComponents'
  s.dependency 'IIAOPNBP'
  s.dependency 'IIHTTPRequest'
  s.dependency 'IIOCUtis'
  s.dependency 'IIBaseComponents'
  
  s.dependency 'HandyJSON'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'RxDataSources'


end