//
//  FTDetailViewController.m
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//


#import "FTDetailViewController.h"

@interface FTDetailViewController ()
@property (strong, nonatomic) UIImage* placeholder;
@property (strong, nonatomic) UIImage* likeImage;
@end

@implementation FTDetailViewController


-(BOOL) prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.likeImage = [UIImage imageNamed:@"like.png"];
    self.placeholder = [UIImage imageNamed:@"placeholder.png"];
    UINavigationBar* navBar = self.navigationController.navigationBar;
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]
                                                                                            forState:UIControlStateNormal];
    navBar.barTintColor = [UIColor colorWithRed:((float)((0x067AB5 & 0xFF0000) >> 16))/255.0 green:((float)((0x067AB5 & 0xFF00) >> 8))/255.0 blue:((float)(0x067AB5 & 0xFF))/255.0 alpha:1.0];
    [navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], NSForegroundColorAttributeName, nil]];
    self.scrollContent.scrollEnabled  = YES;
    [self setupViews];
}

-(void) setupViews
{
    [self.scrollContent setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollContent setContentOffset:CGPointMake(0, -50)];
    //ownerImage's constraints setting
    UIImageView* ownerImage = [[UIImageView alloc] init];
    [ownerImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint* ownerImageLeftConstraint = [NSLayoutConstraint constraintWithItem:ownerImage
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.scrollContent
                                                                                attribute:NSLayoutAttributeLeft
                                                                               multiplier:1.0
                                                                                 constant:10.f];
    
    NSLayoutConstraint* ownerImageTopConstraint = [NSLayoutConstraint constraintWithItem:ownerImage
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.scrollContent
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1.0
                                                                                constant:10.f];
    
    NSLayoutConstraint* ownerImageWidthConstraint = [NSLayoutConstraint constraintWithItem:ownerImage
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1.0
                                                                                  constant:50.f];
    
    NSLayoutConstraint* ownerImageHeightConstraint = [NSLayoutConstraint constraintWithItem:ownerImage
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1.0
                                                                                   constant:50.f];
    [self.scrollContent addSubview:ownerImage];
    [self.scrollContent addConstraints:@[ownerImageLeftConstraint,ownerImageTopConstraint]];
    [ownerImage addConstraints:@[ownerImageWidthConstraint,ownerImageHeightConstraint]];
    [self.scrollContent layoutIfNeeded];
    
    
    //ownerName's constraints setting
    UILabel* ownerName = [[UILabel alloc] init];
    ownerName.textColor = [UIColor blueColor];
    ownerName.font = [UIFont fontWithName:@"Verdana-Bold" size:14.f];
    [ownerName setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint* ownerNameLeftConstraint = [NSLayoutConstraint constraintWithItem:ownerName
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:ownerImage
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:10.f];
    
    NSLayoutConstraint* ownerNameTopConstraint = [NSLayoutConstraint constraintWithItem:ownerName
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.scrollContent
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1.0
                                                                               constant:10.f];
    
    NSLayoutConstraint* ownerNameRightConstraint = [NSLayoutConstraint constraintWithItem:ownerName
                                                                                attribute:NSLayoutAttributeRight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.scrollContent
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1.0
                                                                                 constant:10.f];
    
    NSLayoutConstraint* ownerNameHeightConstraint = [NSLayoutConstraint constraintWithItem:ownerName
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1.0
                                                                                  constant:20.f];
    
    NSLayoutConstraint* ownerNameWidthConstraint = [NSLayoutConstraint constraintWithItem:ownerName
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1.0
                                                                                  constant:20.f];
    
    
    [self.scrollContent addSubview:ownerName];
    [self.scrollContent addConstraints:@[ownerNameTopConstraint,ownerNameRightConstraint,ownerNameLeftConstraint]];
    [ownerName addConstraints:@[ownerNameHeightConstraint,ownerNameWidthConstraint]];
    [self.scrollContent layoutIfNeeded];
    
    
    
    //postDate's constraints setting
    UILabel* postDate = [[UILabel alloc] init];
    [postDate setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint* postDateLeftConstraint = [NSLayoutConstraint constraintWithItem:postDate
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:ownerImage
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1.0
                                                                               constant:10.f];
    
    NSLayoutConstraint* postDateTopConstraint = [NSLayoutConstraint constraintWithItem:postDate
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:ownerName
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:10.f];
    
    NSLayoutConstraint* postDateRightConstraint = [NSLayoutConstraint constraintWithItem:postDate
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.scrollContent
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:10.f];
    
    NSLayoutConstraint* postDateHeightConstraint = [NSLayoutConstraint constraintWithItem:postDate
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:20.f];
    [self.scrollContent addSubview:postDate];
    [self.scrollContent addConstraints:@[postDateRightConstraint,postDateLeftConstraint,postDateTopConstraint]];
    [postDate addConstraints:@[postDateHeightConstraint]];
    [self.scrollContent layoutIfNeeded];
    
    
    //isOnline's constraints setting
    UILabel* isOnline = [[UILabel alloc] init];
    isOnline.textAlignment = NSTextAlignmentCenter;
    isOnline.font = [UIFont fontWithName:@"Verdana" size:12.f];
    [isOnline setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint* isOnlineLeftConstraint = [NSLayoutConstraint constraintWithItem:isOnline
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.scrollContent
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:10.f];
    
    NSLayoutConstraint* isOnlineTopConstraint = [NSLayoutConstraint constraintWithItem:isOnline
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:ownerImage
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:5.f];
    
    NSLayoutConstraint* isOnlineWidthConstraint = [NSLayoutConstraint constraintWithItem:isOnline
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1.0
                                                                                constant:50.f];
    
    NSLayoutConstraint* isOnlineHeightConstraint = [NSLayoutConstraint constraintWithItem:isOnline
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationLessThanOrEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:10.f];
    [self.scrollContent addSubview:isOnline];
    [self.scrollContent addConstraints:@[isOnlineLeftConstraint,isOnlineTopConstraint]];
    [isOnline addConstraints:@[isOnlineWidthConstraint,isOnlineHeightConstraint]];
    [self.scrollContent layoutIfNeeded];
    
    
    //postText's constraints setting
    UILabel* postText = [[UILabel alloc] init];
    [postText setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [postText setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [postText setTranslatesAutoresizingMaskIntoConstraints:NO];
    postText.numberOfLines=0;
    postText.lineBreakMode=NSLineBreakByWordWrapping;
    postText.font=[UIFont fontWithName:@"Helvetica" size:13.0];
    
    
    NSLayoutConstraint* postTextLeftConstraint = [NSLayoutConstraint constraintWithItem:postText
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.scrollContent
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:10.f];
    
    NSLayoutConstraint* postTextTopConstraint = [NSLayoutConstraint constraintWithItem:postText
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:isOnline
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:5.f];
    
    NSLayoutConstraint* postTextRightConstraint = [NSLayoutConstraint constraintWithItem:postText
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.scrollContent
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:10.f];
    
    NSLayoutConstraint* postTextHeightConstraint = [NSLayoutConstraint constraintWithItem:postText
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:1.0];
    [self.scrollContent addSubview:postText];
    [self.scrollContent addConstraints:@[postTextLeftConstraint,postTextRightConstraint,postTextTopConstraint]];
    [postText addConstraints:@[postTextHeightConstraint]];
    [self.scrollContent layoutIfNeeded];
    
    
    
    
    __weak UIImageView* weakImage = ownerImage;
    [ownerImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.feed.ownerImage]]
                      placeholderImage:nil
                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                   weakImage.image = image;
                               }
                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                   weakImage.image = self.placeholder;
                               }];
    
    NSEnumerator* enumerator = [self.feed.postImages objectEnumerator];
    UIImageView* imageView = nil;
    UIImageView* currentImage = nil;
    FTPhoto* photo1 = nil;
    for(int i=0; i<[self.feed.postImages count]+1; i++)
    {
        if(i==0)
            photo1 = self.feed.mainPostImage;
        else
            photo1 = [enumerator nextObject];
        CGFloat ratio1 = [photo1.width floatValue]/ [photo1.height floatValue];
        
        //constraints for imageView1
        imageView = [[UIImageView alloc] init];
        [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.scrollContent addSubview:imageView];
        NSLayoutConstraint* topConstraint = nil;
        if(currentImage)
        {
            topConstraint =[ NSLayoutConstraint constraintWithItem:imageView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:currentImage
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:5.f];
        }
        else
        {
            topConstraint =[ NSLayoutConstraint constraintWithItem:imageView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:postText
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:5.f];
        }
        
        NSLayoutConstraint* leftConstraint =[ NSLayoutConstraint constraintWithItem:imageView
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.scrollContent
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:10.f];
        
        NSLayoutConstraint* rightConstraint =[ NSLayoutConstraint constraintWithItem:imageView
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.scrollContent
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0
                                                                            constant:10.f];
        
        
        NSLayoutConstraint* widthConstraint =[ NSLayoutConstraint constraintWithItem:imageView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0
                                                                            constant:300.f];
        
        NSLayoutConstraint*  heightConstraint =[ NSLayoutConstraint constraintWithItem:imageView
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1.0
                                                                              constant:300.f / ratio1];
        
        
        [imageView addConstraints:@[heightConstraint, widthConstraint]];
        [self.scrollContent addConstraints:@[topConstraint, rightConstraint, leftConstraint]];
        [self.scrollContent layoutIfNeeded];
        
        
        __weak UIImageView* iImage1 = imageView;
        [imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:photo1.path]]
                         placeholderImage:nil
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                      iImage1.image = image;
                                  }
                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                      iImage1.image = self.placeholder;
                                  }];
        currentImage = imageView;
        
        
        
    }
    
    //likes' constraints setting
    UILabel* likes = [[UILabel alloc] init];
    [likes setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint* likesRightConstraint = [NSLayoutConstraint constraintWithItem:likes
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.scrollContent
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1.0
                                                                             constant:10.f];
    
    NSLayoutConstraint* likesTopConstraint = [NSLayoutConstraint constraintWithItem:likes
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:currentImage
                                                                          attribute:NSLayoutAttributeBottom
                                                                         multiplier:1.0
                                                                           constant:5.f];
    
    NSLayoutConstraint* likesWidthConstraint = [NSLayoutConstraint constraintWithItem:likes
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1.0
                                                                             constant:10.f];
    likesWidthConstraint.priority = 1000;
    
    NSLayoutConstraint* likesHeightConstraint = [NSLayoutConstraint constraintWithItem:likes
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1.0
                                                                              constant:20.f];
    NSLayoutConstraint* likesBottomConstraint = [NSLayoutConstraint constraintWithItem:likes
                                                                             attribute:NSLayoutAttributeBottom
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.scrollContent
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:-10.f];
    likes.textAlignment = NSTextAlignmentRight;
    
    [self.scrollContent addSubview:likes];
    [self.scrollContent addConstraints:@[likesRightConstraint,likesBottomConstraint,likesTopConstraint]];
    [likes addConstraints:@[likesWidthConstraint,likesHeightConstraint]];
    likes.text =[NSString stringWithFormat:@"%@", self.feed.likes];
    [self.scrollContent layoutIfNeeded];
    
    
    
    
    //likesImage's constraints setting
    UIImageView* likesImage = [[UIImageView alloc] init];
    [likesImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint* likesImageRightConstraint = [NSLayoutConstraint constraintWithItem:likesImage
                                                                                 attribute:NSLayoutAttributeRight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:likes
                                                                                 attribute:NSLayoutAttributeLeft
                                                                                multiplier:1.0
                                                                                  constant:-5.f];
    
    NSLayoutConstraint* likesImageTopConstraint = [NSLayoutConstraint constraintWithItem:likesImage
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:currentImage
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1.0
                                                                                constant:5.f];
    
    NSLayoutConstraint* likesImageWidthConstraint = [NSLayoutConstraint constraintWithItem:likesImage
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1.0
                                                                                  constant:30.f];
    
    NSLayoutConstraint* likesImageHeightConstraint = [NSLayoutConstraint constraintWithItem:likesImage
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                                 multiplier:1.0
                                                                                   constant:20.f];
    
    
    [self.scrollContent addSubview:likesImage];
    [self.scrollContent addConstraints:@[likesImageRightConstraint,likesImageTopConstraint]];
    [likesImage addConstraints:@[likesImageWidthConstraint,likesImageHeightConstraint]];
    [self.scrollContent layoutIfNeeded];
    
    
    ownerName.text = self.feed.ownerName;
    postDate.text = self.feed.date;
    isOnline.text = [self.feed.isOnline isEqualToString:@"1"]?@"Online":@"";
    postText.text = self.feed.postText;
    likesImage.image = self.likeImage;
    [self.scrollContent layoutIfNeeded];
}


- (IBAction)barItem:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
