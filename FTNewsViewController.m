//
//  FTNewsViewController.m
//  Vkontakte
//
//  Created by Galiev Aynur on 10.10.14.
//  Copyright (c) 2014 FT. All rights reserved.
//

#import "FTNewsViewController.h"
#define ONE_WEEK 7*24*60*60
@interface FTNewsViewController ()
@property (strong, nonatomic) UIImage* placeholder;
@property (strong, nonatomic) UIImage* likeImage;
@end

typedef enum
{
    GANewNewsIdentifier = 0 ,
    GAOldNewsIdentifier = 1
} DownloadID;

@interface FTNewsViewController ()
{
    NSInteger oldNewsOffset;
    NSInteger newNewsOffset;
    NSIndexPath* selectedPath;
    NSInteger newsCount;
    NSString* from;
    long lastUpdateTimeInUnixtimeFormat;
    long startTime;
    NSString* start_from;
    NSString* start_from1;
    long breakTime;
}
@end


@implementation FTNewsViewController

-(NSString*) currentTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"dd MMM, HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *normalDate=[dateFormatter stringFromDate:date];
    return normalDate;
}

-(long) getCurrentTimeInUnixtimeFormat
{
    return (long)[[NSDate date] timeIntervalSince1970];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.likeImage = [UIImage imageNamed:@"like.png"];
    self.placeholder = [UIImage imageNamed:@"placeholder.png"];
    breakTime = ONE_WEEK;
    start_from = nil;
    start_from1 = nil;
    lastUpdateTimeInUnixtimeFormat=0;
    newsCount =0;
    startTime = [self getCurrentTimeInUnixtimeFormat];
    self.navigationController.title = @"Новости";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor blackColor];
    oldNewsOffset = 0;
    newNewsOffset = 0;
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}

-(void) refresh
{
    [self getNewsWithIdentifier:GANewNewsIdentifier];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

-(void) getNewsWithIdentifier:(DownloadID) identifier
{
    NSNumber* start_time = nil;
    NSNumber* end_time   = nil;
    if(identifier == GANewNewsIdentifier)
    {
        start_time =[ NSNumber numberWithLong: lastUpdateTimeInUnixtimeFormat];
        end_time   = [NSNumber numberWithLong: [self getCurrentTimeInUnixtimeFormat] ];
    }
    else
    {
        start_time = [NSNumber numberWithLong:(startTime  - ONE_WEEK)];
        end_time   = [NSNumber numberWithLong:startTime];
    }
    lastUpdateTimeInUnixtimeFormat = [self getCurrentTimeInUnixtimeFormat];
    
    NSInteger offset;
    NSString* new_start_from;
    if(identifier == GAOldNewsIdentifier)
    {
        offset = oldNewsOffset;
        new_start_from = start_from;
    }
    else
    {
        offset = newNewsOffset;
        new_start_from = start_from1;
    }
    
    [[FTServerManager sharedManager] getNewsWithOffset:offset
                                              andCount:20
                                              andStart:start_time
                                               andFrom:new_start_from
                                                andEnd:end_time
                                             onSuccess:^(NSMutableArray* newsFromServer, NSString* new_offset, NSString* new_from, NSInteger responseNewsCount)
     {
         newsCount+=[newsFromServer count];
         NSMutableArray* indexPaths = [NSMutableArray array];
         if(new_offset)
         {
             if(identifier == GAOldNewsIdentifier)
             {
                 oldNewsOffset = [new_offset intValue];
                 start_from = new_from;
             }
             else
             {
                 if(responseNewsCount)
                     newNewsOffset += responseNewsCount;
                 start_from1 = new_from;
             }
         }
         if(identifier == GAOldNewsIdentifier)
         {
             for(unsigned long i=newsCount-[newsFromServer count]; i<newsCount; i++)
                 [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
             
             
             FTNew* newFeed = nil;
             for (int i=0; i< [indexPaths count]; i++) {
                 newFeed = [newsFromServer objectAtIndex:i];
                 NSIndexPath* path = [indexPaths objectAtIndex:i];
                 NSNumber* number  = [NSNumber numberWithLong:path.row];
                 newFeed.row = number;
             }
             [[FTDataManager sharedManager] save];
             
         }
         else
         {
             if([newsFromServer count]>0)
             {
                 NSArray* newsArray = [FTNew MR_findAll];
                 for(FTNew* feed in newsArray)
                 {
                     feed.row = [NSNumber numberWithLong: [feed.row longValue] + [newsFromServer count]];
                 }
                 [[FTDataManager sharedManager] save];
                 
                 for(unsigned long i=0; i<[newsFromServer count]; i++)
                     [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                 
                 FTNew* newFeed = nil;
                 for(int j=0; j<[indexPaths count];j++)
                 {
                     newFeed = [newsFromServer objectAtIndex:j];
                     NSIndexPath* path = [indexPaths objectAtIndex:j];
                     NSNumber* number  = [NSNumber numberWithLong:path.row];
                     newFeed.row = number;
                 }
                 [[FTDataManager sharedManager] save];
             }
             
         }
         
         [self.tableView beginUpdates];
         [self.refreshControl endRefreshing];
         [self.tableView insertRowsAtIndexPaths:indexPaths  withRowAnimation:UITableViewRowAnimationRight];
         [self.tableView endUpdates];
         
     }
                                             onFailure:^(NSError *error, int statusCode)
     {
         NSLog(@"%@", [error localizedDescription]);
     }];
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"Cell";
    FTNew* newFeed = [[FTDataManager sharedManager] getNewWithRow:indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    FTActivityCell* activityCell = nil;
    if(!cell)
    {
        if(indexPath.row == newsCount)
        {
            activityCell = [[FTActivityCell alloc] init];
            activityCell.updateLabel.text = [NSString stringWithFormat:@"Last update %@", [self currentTime] ];
            [activityCell.activityIndicator startAnimating];
            return activityCell;
        }
        else
            cell = [[FTTableViewCell alloc] init];
    }
    
    if(cell && [cell isKindOfClass:[FTActivityCell class]])
        ((FTActivityCell*)cell).updateLabel.text = [self currentTime];
    else
    {
        FTPhoto* photo = newFeed.mainPostImage;
        CGFloat ratio = [[photo width] floatValue]/[[photo height] floatValue];
        ((FTTableViewCell*)cell).widthConstraint.constant = 310.f;
        ((FTTableViewCell*)cell).heightConstraint.constant = 310.f/ratio;
        
        __weak FTTableViewCell* weakCell = ((FTTableViewCell*)cell);
        
        if(![[FTDataManager sharedManager] loadImage:newFeed.ownerImage] )
        {
            NSURLRequest* request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:newFeed.ownerImage]];
            [((FTTableViewCell*)cell).ownerImage setImageWithURLRequest:request1
                                                       placeholderImage:nil
                                                                success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                                    weakCell.ownerImage.image = image;
                                                                    [[FTDataManager sharedManager] saveImage:((FTTableViewCell*)cell).ownerImage.image withPath:newFeed.ownerImage];
                                                                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
             {
                 weakCell.ownerImage.image = self.placeholder;
             }];
        }
        else
        {
            ((FTTableViewCell*)cell).ownerImage.image = [[FTDataManager sharedManager] loadImage:newFeed.ownerImage];
        }
        
        NSString* urlString = photo.path;
        if(![[FTDataManager sharedManager] loadImage:urlString])
        {
            NSURLRequest* request2 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
            [((FTTableViewCell*)cell).postImage setImageWithURLRequest:request2
                                                      placeholderImage:nil
                                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                                   weakCell.postImage.image = image;
                                                                   [[FTDataManager sharedManager] saveImage:((FTTableViewCell*)cell).postImage.image withPath:urlString];
                                                               }
                                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
             {
                 weakCell.postImage.image = self.placeholder;
             }];
        }
        else
        {
            ((FTTableViewCell*)cell).postImage.image = [[FTDataManager sharedManager] loadImage:urlString];
        }
        
        ((FTTableViewCell*)cell).postDate.text = newFeed.date;
        ((FTTableViewCell*)cell).isOnline.text = [newFeed.isOnline isEqualToString:@"1"]?@"Online":@"";
        ((FTTableViewCell*)cell).postText.text = newFeed.postText;
        ((FTTableViewCell*)cell).likes.text = [NSString stringWithFormat:@"%@",newFeed.likes];
        ((FTTableViewCell*)cell).likesImage.image = self.likeImage;
        ((FTTableViewCell*)cell).ownerName.text = newFeed.ownerName;
        [((FTTableViewCell*)cell) layoutIfNeeded];
    }
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsCount+1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((indexPath.row==0 && newsCount == 0) || (newsCount!=0 && indexPath.row == newsCount))
        return 91.f;
    FTTableViewCell* cell = cell = [[FTTableViewCell alloc] init];
    FTNew* newFeed = [[FTDataManager sharedManager] getNewWithRow:indexPath.row];
    
    FTPhoto* photo = newFeed.mainPostImage;
    CGFloat ratio = [[photo width] floatValue]/[[photo height] floatValue];
    cell.widthConstraint.constant = 310.f;
    cell.heightConstraint.constant = 310.f/ratio;
    
    cell.postDate.text = newFeed.date;
    cell.isOnline.text = newFeed.isOnline;
    cell.postText.text = newFeed.ownerName;
    cell.likes.text = [NSString stringWithFormat:@"%@",newFeed.likes];
    cell.likesImage.image = [UIImage imageNamed:@"like.png"];
    [cell layoutIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == newsCount)
    {
        [self getNewsWithIdentifier:GAOldNewsIdentifier];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if(indexPath.row == newsCount && [cell isKindOfClass:[FTActivityCell class]])
    {
        [((FTActivityCell*)cell).activityIndicator stopAnimating];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"SHOW_DETAIL"])
    {
        FTDetailViewController* destination = (FTDetailViewController*)segue.destinationViewController;
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"row==%ld", selectedPath.row];
        FTNew* newFeed =[[FTNew MR_findAllWithPredicate:predicate] firstObject];
        destination.feed = newFeed;
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedPath = indexPath;
    [self performSegueWithIdentifier:@"SHOW_DETAIL" sender:nil];
}


- (IBAction)goBack:(id)sender
{
    [[FTDataManager sharedManager] clearSession];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end

