#
# Be sure to run `pod lib lint FireBasePod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FireBasePod'
  s.version          = '0.1.4'
  s.summary          = 'A short description of FireBasePod.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Simple FireBase plugin for personal use
                       DESC

  s.homepage         = 'https://github.com/tthufo/FireBasePod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tthufo' => 'tthufo@gmail.com' }
  s.source           = { :git => 'https://github.com/tthufo/FireBasePod.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

s.source_files = 'FireBasePod/Classes'

s.public_header_files = 'FireBasePod/Classes/*.h'

s.static_framework = true

s.dependency 'Firebase/Core', '~> 10.29'
s.dependency 'Firebase/Messaging', '~> 10.29'

s.pod_target_xcconfig = {
    "OTHER_LDFLAGS" => '$(inherited) -framework "FirebaseCore" -framework "FirebaseMessaging"',
    "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => 'YES',
    "FRAMEWORK_SEARCH_PATHS" => '$(inherited) "${PODS_ROOT}/FirebaseCore/Frameworks" "${PODS_ROOT}/FirebaseMessaging/Frameworks"'
}

end
