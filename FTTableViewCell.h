//
//  FTTableViewCell.h
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface FTTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ownerImage;
@property (weak, nonatomic) IBOutlet UILabel *ownerName;
@property (weak, nonatomic) IBOutlet UILabel *postDate;
@property (weak, nonatomic) IBOutlet UILabel *isOnline;
@property (weak, nonatomic) IBOutlet UILabel *postText;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *likes;
@property (weak, nonatomic) IBOutlet UIImageView *likesImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end
