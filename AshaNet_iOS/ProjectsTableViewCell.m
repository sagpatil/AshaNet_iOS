//
//  ProjectsTableViewCell.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "ProjectsTableViewCell.h"
@interface ProjectsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chapterLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation ProjectsTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) customizeCell:(Project *)project{
    self.nameLabel.text = project.name;
    self.chapterLabel.text = project.chapter;
    self.areaLabel.text = project.area;
    self.typeLabel.text = [NSString stringWithFormat:(@"%@"), project.projectType];
}


@end
