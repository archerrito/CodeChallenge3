//
//  Location.h
//  CodeChallenge3
//
//  Created by Supreme Overlord on 11/7/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject

@property (nonatomic, strong) NSString *stationName;
@property int availableBikes;
@property CLLocationCoordinate2D coordinate;

-(instancetype)initWithDictionary: (NSDictionary *)dictionary;

@end
