//
//  EventsTableViewCell.h
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventsTableViewCell : UITableViewCell
@property (nonatomic, strong) Event *event;

- (void) customizeCell:(Event *)event;
@end
