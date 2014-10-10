//
//  FTTableViewCell.m
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//


#import "FTTableViewCell.h"

@implementation FTTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"FTTableViewCell" owner:self options:nil] firstObject];
    }
    return self;
}

@end

