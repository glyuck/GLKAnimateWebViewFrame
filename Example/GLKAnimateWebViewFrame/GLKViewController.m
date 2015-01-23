//
//  GLKViewController.m
//  GLKAnimateWebViewFrame
//
//  Created by Vladimir Lyukov on 01/23/2015.
//  Copyright (c) 2014 Vladimir Lyukov. All rights reserved.
//

#import "GLKViewController.h"
#import "UIWebView+GLKAnimateFrame.h"

@interface GLKViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation GLKViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)animateWebViewHeightTo:(CGFloat)height duration:(CGFloat)duration {
    BOOL useUIViewAnimate = NO; // Change to YES if you want to try [UIView animateWithDuration:animations:]
    if (useUIViewAnimate) {
        [UIView animateWithDuration:duration animations:^{
            CGRect frame = self.webView.frame;
            frame.size.height = height;
            self.webView.frame = frame;
        }];
    } else {
        [self.webView glk_animateToHeight:height duration:duration];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *htmlString = @""
            "<!doctype html>"
            "<html>"
            "<head>"
            "<style type='text/css'>"
            "html, body { width:100%; height:100%; padding:0; margin:0; }"
            ".table { width:100%; height:100%; display:table; }"
            ".row { display:table-row; }"
            ".cell { display:table-cell; vertical-align:middle; text-align:center; }"
            ".absolute { width:200px; position:absolute; top:50%; left:50%; margin:20px 0 0 -100px; text-align:center; background:#eee; }"
            "</style>"
            "</head>"
            "<body>"
            "<div class='table'><div class='row'><div class='cell'>Example <input type='text' /></div></div></div>"
            "<div class='absolute'>I'm absolutely positioned</div>"
            "</body>"
            "</html>";

    [self.webView loadHTMLString:htmlString baseURL:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)toggleHeightButtonTapped:(id)sender {
    CGFloat maxHeight = self.view.frame.size.height - self.webView.frame.origin.y;
    CGFloat height;
    if (CGRectGetMaxY(self.webView.frame) == CGRectGetMaxY(self.view.frame)) {
        height = maxHeight - 200;
    } else {
        height = maxHeight;
    }
    [self animateWebViewHeightTo:height duration:0.4];
}

#pragma mark - Keyboard Notification

-(void)keyBoardShow:(NSNotification*)notification {
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];

    CGFloat height = self.view.frame.size.height - self.webView.frame.origin.y - keyboardBounds.size.height;
    [self animateWebViewHeightTo:height duration:duration.floatValue];
}

-(void)keyBoardHide:(NSNotification*)notification {
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];

    CGFloat height = self.view.frame.size.height - self.webView.frame.origin.y;

    [self animateWebViewHeightTo:height duration:duration.floatValue];
}

@end
