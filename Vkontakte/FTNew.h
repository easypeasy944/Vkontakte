//
//  FTNew.h
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FTPhoto;

@interface FTNew : NSManagedObject

@property (nonatomic, retain) NSString * isOnline;
@property (nonatomic, retain) NSNumber * likes;
@property (nonatomic, retain) NSString * ownerImage;
@property (nonatomic, retain) NSString * ownerName;
@property (nonatomic, retain) NSString * postText;
@property (nonatomic, retain) NSNumber * row;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSSet *postImages;
@property (nonatomic, retain) FTPhoto *mainPostImage;
@end

@interface FTNew (CoreDataGeneratedAccessors)

- (void)addPostImagesObject:(FTPhoto *)value;
- (void)removePostImagesObject:(FTPhoto *)value;
- (void)addPostImages:(NSSet *)values;
- (void)removePostImages:(NSSet *)values;

@end
