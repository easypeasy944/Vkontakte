//
//  FTJSONParser.h
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FTNew.h"
#import "FTPhoto.h"
#import "FTDataManager.h"
#import "CoreData+MagicalRecord.h"
@interface FTJSONParser : NSObject
+(FTJSONParser*) sharedParser;
-(void) newsFromServerResponse:(NSDictionary*) response withResultBlock: (void (^) (NSMutableArray* news, NSString* new_offset, NSString* new_from, NSInteger newsCount)) resultBlock;
@end
