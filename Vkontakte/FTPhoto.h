//
//  FTPhoto.h
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FTNew;
@interface FTPhoto : NSManagedObject

@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) FTNew *currentNew;
@property (nonatomic, retain) FTNew *currentNewForMainPost;

@end
