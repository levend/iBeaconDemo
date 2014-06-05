//
//  TPURegionManager.m
//  iBeaconDemo
//
//  Created by Balazs Gollner on 2014.06.03..
//  Copyright (c) 2014 Balazs Gollner. All rights reserved.
//

#import "TPURegionManager.h"
#import <CoreLocation/CoreLocation.h>
#import "TPUBackendInterface.h"

@interface TPURegionManager () <CLLocationManagerDelegate>

@end

@implementation TPURegionManager {
	CLLocationManager *_locationManager;
	TPUBackendInterface *_backendInterface;
}

- (instancetype)initWithBackendInterface:(TPUBackendInterface *)backendInterface {
	self = [super init];
	if (self) {
		_locationManager = [[CLLocationManager alloc] init];
		_locationManager.delegate = self;
		_backendInterface = backendInterface;
	}

	return self;
}

- (void)registerRegions {
    
	[self registerRegionWithProximityID:@"5c2a2bb7-7149-4a52-b12a-862ec7e54f5c" andIdentifier:@"Balazs's desk"];
    
    [self registerRegionWithProximityID:@"e8ca20c2-5aa0-4cff-9dac-49492b3b0a4a" andIdentifier:@"Moszi's desk"];
    
    [self registerRegionWithProximityID:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e" andIdentifier:@"EPAM Kithcen"];
}

- (void)registerRegionWithProximityID:(NSString *)proxymityID andIdentifier:(NSString *)identifier{
	NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:proxymityID];

	CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:identifier];

	[_locationManager startMonitoringForRegion:region];
}

#pragma mark - LocationManager callbacks

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
	[_backendInterface reportEvent:TPURegionChangeEnter forRegionIdentifier:region.identifier];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
	[_backendInterface reportEvent:TPURegionChangeExit forRegionIdentifier:region.identifier];
}

@end
