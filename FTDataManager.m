//
//  FTDataManager.m
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//


#import "FTDataManager.h"

@implementation FTDataManager

+(FTDataManager*) sharedManager
{
    static FTDataManager* manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[FTDataManager alloc] init];
    });
    return manager;
}

-(void) save
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

-(FTNew*) getNewWithRow:(NSInteger) row
{
    NSArray* newsForRow = [FTNew MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"row == %@", [NSNumber numberWithLong:row]]];
    if([newsForRow count]!=0)
        return [newsForRow objectAtIndex:0];
    else
        return nil;
}

- (BOOL)saveImage:(UIImage*)image withPath:(NSString*) imagePath
{
    if (image != nil && imagePath != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:[imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"&"]];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
        return YES;
    }
    else
        return NO;
}

-(void) clearCookie
{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
}


- (UIImage*)loadImage:(NSString*)imagePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* str= [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"&"];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:str];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}

-(void) clearCachedImages
{
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                        NSUserDomainMask, YES) objectAtIndex:0];
    
    NSError *error = nil;
    NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (!error) {
        for (NSString *path in directoryContents) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
            BOOL removeSuccess = [[NSFileManager defaultManager] removeItemAtPath:fullPath error:&error];
            if (!removeSuccess) {
                NSLog(@"%@", [error localizedDescription]);
            }
        }
    } else {
        NSLog(@"%@", [error localizedDescription]);
    }
}

-(void) clear
{
    NSArray* entites = [FTNew MR_findAll];
    for(FTNew* feed in entites)
    {
        [feed MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

-(void) clearSession
{
    [self clearCookie];
    [self clearCachedImages];
    [self clear];
}

@end
