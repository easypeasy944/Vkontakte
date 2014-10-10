//
//  FTServerManager.m
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//


#import "FTServerManager.h"
#import "FTJSONParser.h"


@implementation FTServerManager

+(FTServerManager*) sharedManager
{
    static dispatch_once_t once;
    static FTServerManager* manager=nil;
    dispatch_once(&once, ^{
        manager = [[FTServerManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.vk.com/method/"]];
    }
    return self;
}


-(void) getNewsWithOffset:(NSInteger) offset
                 andCount:(NSInteger) count
                 andStart:(NSNumber*) from
                  andFrom:(NSString*) new_from
                   andEnd:(NSNumber*) end
                onSuccess: (void (^) (NSMutableArray* news, NSString* new_offset, NSString* new_from,  NSInteger newsCount)) success
                onFailure: (void (^) (NSError* error, int statusCode)) failure
{
    NSMutableDictionary* parameters=nil;
    
    parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                  @"post,photo,photo_tag,wall_photo,friend,tag", @"filters",
                  @0     , @"return_banned",
                  @([from longLongValue])  ,  @"start_time",
                  @([end longLongValue]), @"end_time",
                  @(offset), @"offset",
                  @1     , @"max_photos",
                  @"friends, groups", @"source_ids",
                  @(count)  ,    @"count",
                  self.token.token, @"access_token", nil];
    if(new_from)
        [parameters setObject:new_from forKey:@"from"];
    
    
    if(self.token)
    {
        [self.operationManager GET:@"newsfeed.get"
                        parameters:parameters
                           success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject)
         {
             if(success)
             {
                 [[FTJSONParser sharedParser] newsFromServerResponse:responseObject
                                                     withResultBlock:success];
             }
         }
                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               NSLog(@"Error - %@", [error localizedDescription]);
                           }];
    }
}

@end

