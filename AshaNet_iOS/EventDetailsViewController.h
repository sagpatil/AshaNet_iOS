//
//  EventDetailsViewController.h
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/6/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetailsViewController : UIViewController

@property (strong, nonatomic, readwrite) Event *selectedEvent;

@end
