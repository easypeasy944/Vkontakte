//
//  FTActivityCell.h
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTActivityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;
@end
