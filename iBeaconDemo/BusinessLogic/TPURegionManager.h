//
//  TPURegionManager.h
//  iBeaconDemo
//
//  Created by Balazs Gollner on 2014.06.03..
//  Copyright (c) 2014 Balazs Gollner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TPUBackendInterface;

@interface TPURegionManager : NSObject

- (instancetype)initWithBackendInterface:(TPUBackendInterface *)backendInterface;

- (void)registerRegions;

@end
