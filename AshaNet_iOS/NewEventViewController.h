//
//  NewEventViewController.h
//  AshaNet_iOS
//
//  Created by Patil, Sagar on 7/10/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface NewEventViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate>
- (id)initWithEvent:(Event *)e;
@end
