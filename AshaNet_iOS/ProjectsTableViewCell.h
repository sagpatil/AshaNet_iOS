//
//  ProjectsTableViewCell.h
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
@interface ProjectsTableViewCell : UITableViewCell
@property (nonatomic, strong) Project *project;

- (void) customizeCell:(Project *)project;

@end
