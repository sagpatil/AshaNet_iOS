//
//  Event.m
//  AshaNet_iOS
//
//  Created by Patil, Sagar on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "Event.h"




@implementation Event

- (id)initWithDictionary:(NSDictionary *)object{
    
    self = [super init];
    if (self) {
        self.name = object[@"Name"];
        self.description = object[@"Description"];
        self.address = object [@"Address"];
        self.eventTime = object [@"Event_time"];
        self.ticketUrl = object [@"Ticket_site_url"];
        PFFile *userImageFile = object[@"Image"];
        [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                self.eventImage = [UIImage imageWithData:imageData];
            }
        }];
        
    }
    return self;
}
@end
