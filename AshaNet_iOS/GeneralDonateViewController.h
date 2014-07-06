//
//  GeneralDonateViewController.h
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"

@interface GeneralDonateViewController : UIViewController <PayPalPaymentDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, strong, readwrite) NSString *resultText;
@end
