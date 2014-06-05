//
//  TPUBackendInterface.h
//  iBeaconDemo
//
//  Created by Balazs Gollner on 2014.06.03..
//  Copyright (c) 2014 Balazs Gollner. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TPURegionChange) {
    TPURegionChangeEnter,
    TPURegionChangeExit
};

extern NSString * const kBackendEndpoint;

@interface TPUBackendInterface : NSObject

- (void)reportEvent:(TPURegionChange)eventType forRegionIdentifier:(NSString *)regionIdentifier;

@end
