//
//  FTDetailViewController.h
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTNew.h"
#import "FTPhoto.h"
#import "UIImageView+AFNetworking.h"

@interface FTDetailViewController : UIViewController
@property (strong, nonatomic) FTNew* feed;
- (IBAction)barItem:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContent;
@end
