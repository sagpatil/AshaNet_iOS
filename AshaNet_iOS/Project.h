//
//  Project.h
//  AshaNet_iOS
//
//  Created by Patil, Sagar on 7/6/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Project : NSObject
@property (nonatomic, strong) NSNumber *projectId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *purpose;
@property (nonatomic, strong) NSString *orgDescription;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSDate *year;
@property (nonatomic, strong) NSString *fundsDonated;
@property (nonatomic, strong) NSString *projectType;
@property (nonatomic, strong) NSString *focus;
@property (nonatomic, strong) NSString *chapter;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) PFFile *eventImage;

- (id)initWithDictionary:(NSDictionary *)object;
@end