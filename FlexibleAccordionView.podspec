#
# Be sure to run `pod lib lint FlexibleAccordionView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FlexibleAccordionView'
  s.version          = '0.1.0'
  s.summary          = 'A simple and fully flexible Accordion view component that allows you to insert views into the headers and content of the accordions.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
# FlexibleAccordionView

A simple and fully flexible Accordion view component that allows you to insert views into the headers and content of the accordions.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
                       DESC

  s.homepage         = 'https://github.com/cucabr/FlexibleAccordionView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'andreaugusto_sjc' => 'andreaugustosjc@gmail.com' }
  s.source           = { :git => 'https://github.com/andreaugusto_sjc/FlexibleAccordionView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'FlexibleAccordionView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FlexibleAccordionView' => ['FlexibleAccordionView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
