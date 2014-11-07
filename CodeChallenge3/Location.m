//
//  Location.m
//  CodeChallenge3
//
//  Created by Supreme Overlord on 11/7/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Location.h"

@implementation Location

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    self.coordinate = CLLocationCoordinate2DMake([dictionary[@"latitude"] floatValue], [dictionary[@"longitude"] floatValue]);

    self.stationName = dictionary[@"stAddress1"];
    self.availableBikes = [dictionary[@"availableBikes"] intValue];

    return self;
}

@end
