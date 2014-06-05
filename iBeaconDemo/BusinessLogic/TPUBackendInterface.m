//
//  TPUBackendInterface.m
//  iBeaconDemo
//
//  Created by Balazs Gollner on 2014.06.03..
//  Copyright (c) 2014 Balazs Gollner. All rights reserved.
//

#import "TPUBackendInterface.h"

@implementation TPUBackendInterface

NSString * const kBackendEndpoint = @"http://beaconfarm.herokuapp.com/report";

- (void)reportEvent:(TPURegionChange)eventType forRegionIdentifier:(NSString *)regionIdentifier {
    
    NSString *eventString = eventType==TPURegionChangeEnter ? @"Enter" : @"Exit";
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    NSString *bodyString = [NSString stringWithFormat:@"{ \"region\" : \"%@\", \"eventType\" : \"%@\", \"user\":\"%@\" }", regionIdentifier, eventString, username];

    NSURL *url = [NSURL URLWithString:kBackendEndpoint];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:nil];
    [connection start];
    
    NSLog(@"Sent report : %@", bodyString);
    
    //also generate local notification if enabled
    BOOL notificationEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"notificationEnabled"];
    
    if (notificationEnabled) {
        
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        
        if (eventType == TPURegionChangeEnter)
            notif.alertBody = [NSString stringWithFormat:@"You entered to region %@", regionIdentifier];
        else
            notif.alertBody = [NSString stringWithFormat:@"You left region %@", regionIdentifier];
        notif.repeatInterval = 0;
        notif.fireDate = nil;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
}

@end
