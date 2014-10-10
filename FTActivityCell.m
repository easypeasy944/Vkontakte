//
//  FTActivityCell.m
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//
#import "FTActivityCell.h"

@implementation FTActivityCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"FTActivityCell" owner:self options:nil] firstObject];
    }
    return self;
}
@end
