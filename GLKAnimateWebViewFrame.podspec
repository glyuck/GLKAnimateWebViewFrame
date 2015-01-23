Pod::Spec.new do |s|
  s.name             = "GLKAnimateWebViewFrame"
  s.version          = "0.1.0"
  s.summary          = "Smoothly animate UIWebView frame."
  s.description      = <<-DESC
                       Workaround to enable animating UIWebView height. If you try to animate UIWebView.frame via standart `[UIView animateWithDuration:animations]`, no animation will occur, webView's content will immediately jump to it's final frame.
                       This library tries to fix this issue by animating webView content size via JavaScript, then changing webView.frame after JS animation finished.
                       DESC
  s.homepage         = "https://github.com/glyuck/GLKAnimateWebViewFrame"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Vladimir Lyukov" => "v.lyukov@gmail.com" }
  s.source           = { :git => "https://github.com/glyuck/GLKAnimateWebViewFrame.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/glyuck'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
