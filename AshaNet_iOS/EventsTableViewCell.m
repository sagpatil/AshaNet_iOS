//
//  EventsTableViewCell.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "EventsTableViewCell.h"

@interface EventsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation EventsTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) customizeCell:(Event *)event{
    self.nameLabel.text = event.name;
    self.addressLabel.text = event.address;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yy, hh:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@",  [formatter stringFromDate:event.eventTime]];
}

@end
