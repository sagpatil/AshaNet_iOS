//
//  EventsViewController.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "EventsViewController.h"
#import "EventsTableViewCell.h"

@interface EventsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *eventsTable;
@property (nonatomic, strong) EventsTableViewCell *prototypeCell;
@property (nonatomic, copy) NSArray *projects;

@end

@implementation EventsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Row..... %i", indexPath.row);
    EventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell" forIndexPath:indexPath];
    //   cell.project = self.projects[indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
