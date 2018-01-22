#
# Be sure to run `pod lib lint pdespres2018.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'pdespres2018'
  s.version          = '0.1.0'
  s.summary          = 'Project for school 42 @Paris'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Pod aiming at creating a CoreData pod managing Articles as a school project for 42 @Paris
                       DESC

  s.homepage         = 'https://github.com/pdespres/pdespres2018'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pdespres@student.42.fr' => 'pdespres@student.42.fr' }
  s.source           = { :git => 'https://github.com/pdespres/pdespres2018.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'pdespres2018/Classes/**/*'
  s.resource = 'pdespres2018/Assets/*.xcdatamodeld'
#s.resource_bundles = {
#       'pdespres2018' => ['pdespres2018/Assets/*.xcdatamodeld']
#   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreData'
  # s.dependency 
end
