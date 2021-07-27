#
# Be sure to run `pod lib lint SheetViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SheetViewController'
  s.version          = '2.0.1'
  s.summary          = 'SheetViewController - is a customizable native-like sheet alert controller'

  s.description      = <<-DESC
  Customizable native-like sheet alert controller with three presentation types: separately, inner, none.
                       DESC

  s.homepage         = 'https://github.com/bananaRanger/SheetViewController.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anton Yereshchenko' => 'antonyereshchenko@gmail.com' }
  s.source           = { :git => 'https://github.com/bananaRanger/SheetViewController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version  = '5.0'
  
  s.source_files = 'SheetViewController/Classes/**/*'  
end
