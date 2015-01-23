//
//  UIWebView+GLKAnimateFrame.m
//  GLKAnimateWebViewFrame
//
//  Created by Vladimir Lyukov on 23/01/15.
//  Copyright (c) 2015 Vladimir Lyukov. All rights reserved.
//

#import "UIWebView+GLKAnimateFrame.h"


@implementation UIWebView (GLKAnimateFrame)

- (void)glk_animateToHeight:(CGFloat)height duration:(CGFloat)duration {
    // We will animate webView's document.body height via javascript first
    // and then, when javascript animation finished we will update webView frame
    NSString *javascriptString = [NSString stringWithFormat:@""
            "function animate(elem, style, unit, from, to, time) {\n"
            "    var start = new Date().getTime(),\n"
            "        timer = setInterval(function() {\n"
            "            var step = Math.min(1,(new Date().getTime()-start)/time);\n"
            "            elem.style[style] = (from+step*(to-from))+unit;\n"
            "            if( step == 1) clearInterval(timer);\n"
            "        }, 25);\n"
            "    elem.style[style] = from+unit;\n"
            "}\n"
            "document.body.style.position = 'relative';\n"
            "animate(document.body, 'height', 'px', document.body.offsetHeight, %f, %f)",
        height, duration*1000];
    [self stringByEvaluatingJavaScriptFromString:javascriptString];

    BOOL isGrowing = height > self.frame.size.height;

    // If webView is growing, change it's frame imediately, so it's content not clipped during animation
    if (isGrowing) {
        CGRect frame = self.frame;
        frame.size.height = height;
        self.frame = frame;
    }

    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) self = weakSelf;
        // If webview was shrinking, change it's frame after animation is complete
        if (!isGrowing) {
            CGRect frame = self.frame;
            frame.size.height = height;
            self.frame = frame;
        }
        // Remove remove body position constraints
        [self stringByEvaluatingJavaScriptFromString:@""
                "document.body.style.position = document.body.style.height = null;"
        ];
    });
}

@end
