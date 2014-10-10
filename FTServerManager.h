//
//  FTServerManager.h
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "FTAccessToken.h"


@interface FTServerManager : NSObject
@property (strong, nonatomic) FTAccessToken* token;
@property (strong, nonatomic) AFHTTPRequestOperationManager* operationManager;

-(void) getNewsWithOffset:(NSInteger) offset
                 andCount:(NSInteger) count
                 andStart: (NSNumber*)  from
                  andFrom:(NSString*) new_from
                   andEnd: (NSNumber*) end
                onSuccess: (void (^) (NSMutableArray* news, NSString* new_offset, NSString* new_from, NSInteger newsCount)) success
                onFailure: (void (^) (NSError* error, int statusCode)) failure;
+(FTServerManager*) sharedManager;
@end
