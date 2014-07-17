//
//  AshaHomeViewController.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/17/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "AshaHomeViewController.h"

@interface AshaHomeViewController ()

@end

@implementation AshaHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setThemeColor:(UIColor *)themeColor {
	_themeColor = themeColor;
    self.view.backgroundColor = self.themeColor;
	//[self _updateAppearance];
}

- (void)_updateAppearance {
	if ([self isViewLoaded]) {
		self.view.backgroundColor = self.themeColor;
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
