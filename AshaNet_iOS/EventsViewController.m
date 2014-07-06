//
//  EventsViewController.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "EventsViewController.h"
#import "EventsTableViewCell.h"
#import "EventDetailsViewController.h"
#import <Parse/Parse.h>

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
    self.eventsTable.dataSource = self;
    self.eventsTable.delegate = self;
    self.eventsTable.rowHeight = 140;
    // Do any additional setup after loading the view from its nib.
    UINib *EventCellNib = [UINib nibWithNibName:@"EventsTableViewCell" bundle:nil];
    [self.eventsTable registerNib:EventCellNib forCellReuseIdentifier:@"EventCell"];
    self.prototypeCell = [self.eventsTable dequeueReusableCellWithIdentifier:@"EventCell"];
    
    self.navigationItem.title = @"Events - Fundraisers";
    
    [self getEventsFromParse];
    
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
    EventDetailsViewController *edvc = [[EventDetailsViewController alloc]init];
    edvc.selectedEvent = evt;
    edvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:edvc animated:YES];
}

#pragma  mark - Helper methods

- (void) getEventsFromParse{
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    NSArray *objects = [query findObjects];

    for (NSDictionary *object in objects){
        Event *e = [[Event alloc]initWithDictionary:object];
        [self.events addObject:e];
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
