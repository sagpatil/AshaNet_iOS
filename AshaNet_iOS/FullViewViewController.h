//
//  FullViewViewController.h
//  AshaNet_iOS
//
//  Created by Patil, Sagar on 7/12/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"



@interface FullViewViewController : UIViewController
@property (strong, nonatomic, readwrite) Event *selectedEvent;
@end
