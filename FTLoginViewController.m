//
//  FTLoginViewController.m
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//


#import "FTLoginViewController.h"
typedef void (^CompletionBlock)();
@interface FTLoginViewController ()
@property (copy, nonatomic) CompletionBlock block;
@end

@implementation FTLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = self.view.center;
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:((float)((0x067AB5 & 0xFF0000) >> 16))/255.0 green:((float)((0x067AB5 & 0xFF00) >> 8))/255.0 blue:((float)(0x067AB5 & 0xFF))/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], NSForegroundColorAttributeName, nil]];
    self.request = [NSURLRequest requestWithURL:[NSURL URLWithString:
                                                 @"http://oauth.vk.com/authorize?"
                                                 "client_id=4480707&"
                                                 "scope=8198&"
                                                 "redirect_uri=https://oauth.vk.com/blank.html&"
                                                 "display=mobile&"
                                                 "v=5.25&"
                                                 "response_type=token"]];
    
}


-(void) viewDidAppear:(BOOL)animated
{
    self.webView.delegate=self;
    [self.webView loadRequest:self.request];
    [super viewDidAppear:animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    self.webView.hidden = YES;
    [super viewDidDisappear:animated];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    if(webView.hidden)
        webView.hidden = NO;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if(self.activityView && [[[request URL] host] isEqualToString:@"oauth.vk.com"])
    {
        [self.activityView stopAnimating];
        [self.activityView removeFromSuperview];
    }
    if([[[request URL] description] containsString:@"http://oauth.vk.com/blank.html"])
    {
        FTAccessToken* token = [[FTAccessToken alloc] init];
        NSString* t = [[request URL] description];
        NSString* secondPartOfToken = [[t componentsSeparatedByString:@"#"] lastObject];
        NSArray* pairs = [secondPartOfToken componentsSeparatedByString:@"&"];
        for(NSString* pair in pairs)
        {
            NSString* key = [[pair componentsSeparatedByString:@"="] firstObject];
            NSString* value = [[pair componentsSeparatedByString:@"="] lastObject];
            if([key isEqualToString:@"access_token"])
            {
                [token setToken:value];
            }
            if([key isEqualToString:@"expires_in"])
            {
                NSTimeInterval interval = [value doubleValue];
                
                token.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
            }
            if([key isEqualToString:@"user_id"])
            {
                [token setUserID:value];
            }
            
        }
        [[FTServerManager sharedManager] setToken:token];
        self.webView.delegate = nil;
        [self performSegueWithIdentifier:@"GET_NEWS" sender:nil];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
