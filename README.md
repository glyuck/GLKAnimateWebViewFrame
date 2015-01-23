# GLKAnimateWebViewFrame

[![CI Status](http://img.shields.io/travis/Vladimir Lyukov/GLKAnimateWebViewFrame.svg?style=flat)](https://travis-ci.org/Vladimir Lyukov/GLKAnimateWebViewFrame)
[![Version](https://img.shields.io/cocoapods/v/GLKAnimateWebViewFrame.svg?style=flat)](http://cocoadocs.org/docsets/GLKAnimateWebViewFrame)
[![License](https://img.shields.io/cocoapods/l/GLKAnimateWebViewFrame.svg?style=flat)](http://cocoadocs.org/docsets/GLKAnimateWebViewFrame)
[![Platform](https://img.shields.io/cocoapods/p/GLKAnimateWebViewFrame.svg?style=flat)](http://cocoadocs.org/docsets/GLKAnimateWebViewFrame)

Workaround to enable animating UIWebView height. If you try to animate UIWebView.frame via standart `[UIView animateWithDuration:animations]`, no animation will occur, webView's content will immediately jump to it's final frame.
This library tries to fix this issue by animating webView content size via JavaScript, then changing webView.frame after JS animation finished.

## Usage

    #import "UIWebView+GLKAnimateFrame.h"
    ...
    - (void)myAction {
        [self.webView glk_animateToHeight:200 duration:0.4];
    }

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

GLKAnimateWebViewFrame is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "GLKAnimateWebViewFrame"

## Author

Vladimir Lyukov, v.lyukov@gmail.com

## License

GLKAnimateWebViewFrame is available under the MIT license. See the LICENSE file for more info.

