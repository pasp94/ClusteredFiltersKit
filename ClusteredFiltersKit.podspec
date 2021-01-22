#
# Be sure to run `pod lib lint ClusteredFiltersKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ClusteredFiltersKit'
  s.version          = '1.0.0'
  s.summary          = 'ClusteredFiltersKit is a custom view made on two levels of filters.'

  s.description      = <<-DESC
  ClusteredFiltersKit is a custom view made on two levels of filters. Using protocols, it is possible to use your own custom data structure.
                       DESC

  s.homepage         = 'https://github.com/pasp94/ClusteredFiltersKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pasp94' => 'spisto.pasquale1994@gmail.com' }
  s.source           = { :git => 'https://github.com/pasp94/ClusteredFiltersKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.0'
  s.source_files = 'ClusteredFiltersKit/Classes/**/*'
  
end
