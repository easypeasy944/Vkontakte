//
//  FTAccessToken.m
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//


#import "FTAccessToken.h"

@implementation FTAccessToken

- (id)initWithToken:(NSString*) token andUserID:(NSString*) userID andDate:(NSDate*) expirationDate
{
    self = [super init];
    if (self) {
        self.token = token;
        self.userID = userID;
        self.expirationDate = expirationDate;
    }
    return self;
}

@end
