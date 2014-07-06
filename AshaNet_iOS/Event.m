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
        self.address = object [@"Address"];
        self.eventTime = object [@"Event_time"];
        self.ticketUrl = object [@"Ticket_site_url"];
    }
    return self;
}
@end
