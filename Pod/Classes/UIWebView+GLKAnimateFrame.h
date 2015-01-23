//
//  UIWebView+GLKAnimateFrame.h
//  GLKAnimateWebViewFrame
//
//  Created by Vladimir Lyukov on 23/01/15.
//  Copyright (c) 2015 Vladimir Lyukov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIWebView (GLKAnimateFrame)

- (void)glk_animateToHeight:(CGFloat)height duration:(CGFloat)duration;

@end
