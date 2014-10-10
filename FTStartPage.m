//
//  FTStartPage.m
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//

#import "FTStartPage.h"

@interface FTStartPage ()

@end

@implementation FTStartPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
}


- (IBAction)login:(id)sender
{
    [self performSegueWithIdentifier:@"LOGIN" sender:self];
}
@end
