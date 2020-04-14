#
# Be sure to run `pod lib lint Wyler.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Wyler"
  s.version          = "0.1"
  s.summary          = "Screen Recording Made Easy."
  s.description      = <<-DESC
			A light library written in Swift that makes easy the process of Screen Recording for IOS. You can record your app video screen, access to the recorded video, and save it to the Photo Library.
                       DESC
  s.homepage         = "https://github.com/toupper/Wyler"
  s.license          = 'MIT'
  s.author           = { "César Vargas Casaseca" => "c.vargas.casaseca@gmail.com" }
  s.source           = { :git => "https://github.com/toupper/Wyler.git", :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.requires_arc = true

  s.ios.source_files = 'Wyler/Wyler/**/*.{h,m,swift}'

  s.swift_version = "5.2"
end
