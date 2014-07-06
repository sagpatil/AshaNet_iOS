//
//  Project.m
//  AshaNet_iOS
//
//  Created by Patil, Sagar on 7/6/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "Project.h"


@implementation Project
- (id)initWithDictionary:(NSDictionary *)object{
    
    self = [super init];
    if (self) {
        self.name = object[@"Name"];
        self.address = object [@"Address"];
        self.projectId  = object[@"project_id"];
        self.description  = object[@"Description"];
        self.purpose  = object[@"Purpose"];
        self.orgDescription  = object[@"Org_Description"];
        self.projectType  = object[@"Project_type"];
        self.focus  = object[@"Focus"];
        self.area  = object[@"Area"];
        self.chapter  = object[@"Chapter"];
        self.year  = object[@"Year"];
        self.status = object[@"Status"];
        self.fundsDonated = object[@"Funds_donated"];
    }
    return self;
}
@end
