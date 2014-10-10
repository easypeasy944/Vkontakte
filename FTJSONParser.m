//
//  FTJSONParser.m
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//

#import "FTJSONParser.h"

@implementation FTJSONParser

+(FTJSONParser*) sharedParser
{
    static dispatch_once_t once;
    static FTJSONParser* parser=nil;
    dispatch_once(&once, ^{
        parser = [[FTJSONParser alloc] init];
    });
    return parser;
}

-(void) newsFromServerResponse:(NSDictionary*) response
               withResultBlock:(void (^) (NSMutableArray* news, NSString* new_offset, NSString* new_from, NSInteger newsCount)) resultBlock
{
    NSMutableArray* news = [NSMutableArray array];
    NSDictionary* dicts = [response objectForKey:@"response"];
    NSString* new_offset = [dicts objectForKey:@"new_offset"];
    NSString* new_from =[dicts objectForKey:@"new_from"];
    NSArray* items = [dicts objectForKey:@"items"];
    NSArray* profiles = [dicts objectForKey:@"profiles"];
    NSArray* groups = [dicts objectForKey:@"groups"];
    for(int i=0; i<[items count]; i++)
    {
        
        NSArray* attachments =[[items objectAtIndex:i] objectForKey:@"attachments"];
        
        if(attachments)
        {
            BOOL haveCorrectContent = NO;
            if(attachments)
            {
                for(int k=0; k< [attachments count] && !haveCorrectContent; k++)
                    if( [[[attachments objectAtIndex:k] objectForKey:@"type"] isEqualToString:@"photo"] )
                    {
                        haveCorrectContent = YES;
                    }
                
            }
            if(haveCorrectContent)
            {
                
                FTNew* newFeed = [FTNew MR_createEntity];
                NSString* tempStr = nil;
                NSString* source_id = [[items objectAtIndex:i] objectForKey:@"source_id"];
                NSString* sourceImage = @"";
                
                for(int k=0; k< [attachments count]; k++)
                {
                    NSDictionary* item = [attachments objectAtIndex:k];
                    if([[item objectForKey:@"type"] isEqualToString:@"photo"] || [[item objectForKey:@"type"] isEqualToString:@"wall_photo"])
                    {
                        FTPhoto* photo = [FTPhoto MR_createEntity];
                        sourceImage = [[item objectForKey:@"photo"] objectForKey:@"src_big"];
                        photo.path = sourceImage;
                        photo.width = [[item objectForKey:@"photo"] objectForKey:@"width"];
                        photo.height = [[item objectForKey:@"photo"] objectForKey:@"height"];
                        if(k==0)
                        {
                            newFeed.mainPostImage = photo;
                        }
                        else
                            [newFeed addPostImagesObject:photo];
                    }
                }
                newFeed.ownerImage = sourceImage;
                tempStr = [[items objectAtIndex:i] objectForKey:@"text"];
                newFeed.postText = [tempStr stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
                newFeed.date = [self timeFromUnixtime:[[items objectAtIndex:i] objectForKey:@"date"]];
                newFeed.likes =  [NSNumber numberWithInt: [[[[items objectAtIndex:i] objectForKey:@"likes"] objectForKey:@"count"] intValue]];
                long long sID = [source_id intValue];
                if(sID>0)
                {
                    for(int j=0; j<[profiles count]; j++)
                    {
                        NSString* str = [[profiles objectAtIndex:j] objectForKey:@"uid"];
                        if( [str longLongValue]==sID )
                        {
                            newFeed.ownerImage = [[profiles objectAtIndex:j] objectForKey:@"photo_medium_rec"];
                            newFeed.isOnline = [NSString stringWithFormat:@"%@", [[profiles objectAtIndex:j] objectForKey:@"online"]];
                            newFeed.ownerName = [NSString stringWithFormat:@"%@ %@",
                                                 [[profiles objectAtIndex:j] objectForKey:@"first_name"],
                                                 [[profiles objectAtIndex:j] objectForKey:@"last_name"]];
                        }
                    }
                }
                else
                {
                    sID*=-1;
                    for(int j=0; j<[groups count];j++)
                    {
                        NSString* str = [[groups objectAtIndex:j] objectForKey:@"gid"];
                        if([str longLongValue] == sID)
                        {
                            
                            newFeed.ownerImage = [[groups objectAtIndex:j] objectForKey:@"photo_medium"];
                            newFeed.ownerName = [NSString stringWithFormat:@"%@",
                                                 [[groups objectAtIndex:j] objectForKey:@"name"]];
                        }
                    }
                }
                [news addObject:newFeed];
            }
        }
        
    }
    
    if(resultBlock)
        resultBlock(news, new_offset, new_from, [items count]);
}

-(NSString*) timeFromUnixtime:(NSString*) unixtime
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[unixtime longLongValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"dd MMM, HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *normalDate=[dateFormatter stringFromDate:date];
    return normalDate;
}

@end
