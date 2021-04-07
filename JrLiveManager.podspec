#
# Be sure to run `pod lib lint JrLiveManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JrLiveManager'
  s.version          = '0.1.0'
  s.summary          = 'JrLiveManager'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
JrLiveManager配置文件
                       DESC

  s.homepage         = 'https://github.com/rayraychow/JrLiveManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rayraychow' => '352807106@qq.com' }
  s.source           = { :git => 'https://github.com/rayraychow/JrLiveManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'JrLiveManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JrLiveManager' => ['JrLiveManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

s.user_target_xcconfig = {'OTHER_LDFLAGS' => ['-lObjC','-all_load']}#build setting的配置
s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' } #设置不支持bitcode
s.user_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' } #设置不支持bitcode

end
