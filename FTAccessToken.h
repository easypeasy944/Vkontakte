//
//  FTAccessToken.h
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTAccessToken : NSObject
@property (strong, nonatomic) NSString* token;
@property (strong, nonatomic) NSDate* expirationDate;
@property (strong, nonatomic) NSString* userID;
@end

