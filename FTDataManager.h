//  FTDataManager.h
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FTNew.h"
#import "FTPhoto.h"

@interface FTDataManager : NSObject

+(FTDataManager*) sharedManager;
-(UIImage*)loadImage:(NSString*)imagePath;
-(BOOL)saveImage: (UIImage*)image withPath:(NSString*) imagePath;
-(FTNew*) getNewWithRow:(NSInteger) row;
-(void) clearSession;
-(void) save;

@end
