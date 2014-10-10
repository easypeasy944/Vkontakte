//
//  FTLoginViewController.h
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTAccessToken.h"
#import "FTServerManager.h"
#import "FTDataManager.h"

@interface FTLoginViewController : UIViewController<UIWebViewDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIActivityIndicatorView* activityView;
@property (strong, nonatomic) NSURLRequest* request;
@end
