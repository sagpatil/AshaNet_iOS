//
//  EventsViewController.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "EventsViewController.h"
#import "EventsTableViewCell.h"
#import "NewEventViewController.h"
#import "FullViewViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface EventsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *eventsTable;
@property (nonatomic, strong) EventsTableViewCell *prototypeCell;
@property (nonatomic, strong) NSMutableArray *events;

@end

@implementation EventsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         self.events = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Events - Fundraisers";
    
    [self getEventsFromParse];

    self.eventsTable.dataSource = self;
    self.eventsTable.delegate = self;
    self.eventsTable.rowHeight = 130;
    // Do any additional setup after loading the view from its nib.
    UINib *EventCellNib = [UINib nibWithNibName:@"EventsTableViewCell" bundle:nil];
    [self.eventsTable registerNib:EventCellNib forCellReuseIdentifier:@"EventCell"];
    self.prototypeCell = [self.eventsTable dequeueReusableCellWithIdentifier:@"EventCell"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    

    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.events.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell" forIndexPath:indexPath];
    [cell customizeCell:self.events[indexPath.row]];
    return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    Event *evt = self.events[indexPath.row];
    
    [self.eventsTable deselectRowAtIndexPath:indexPath animated:NO];
   // EventDetailsViewController *edvc = [[EventDetailsViewController alloc]init];
    FullViewViewController *edvc = [[FullViewViewController alloc]init];
    edvc.selectedEvent = evt;
    edvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:edvc animated:YES];
}

#pragma  mark - Helper methods

- (void) getEventsFromParse{
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu records.", (unsigned long)objects.count);
            for (NSDictionary *object in objects){
                Event *e = [[Event alloc]initWithDictionary:object];
                [self.events addObject:e];
            }

            [self.eventsTable reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Failed to retreive the list of chapters from the Backend"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
    }];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
