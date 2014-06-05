//
//  TPUViewController.m
//  iBeaconDemo
//
//  Created by Balazs Gollner on 2014.06.03..
//  Copyright (c) 2014 Balazs Gollner. All rights reserved.
//

#import "TPUViewController.h"

#import "TPURegionManager.h"
#import "TPUBackendInterface.h"

@interface TPUViewController ()

@end

@implementation TPUViewController {
    
    TPURegionManager *_regionManager;
    __weak IBOutlet UITextField *_nameTextfield;
    __weak IBOutlet UISwitch *_notificationSwitch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //load back the UI from userdefaults
    NSString *savedUsername = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    if ( !savedUsername ) {
        
        savedUsername = @"John Appleseed";
        
        [[NSUserDefaults standardUserDefaults] setObject:savedUsername forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    _nameTextfield.text = savedUsername;
    
    _notificationSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"notificationEnabled"];
    
    _regionManager = [[TPURegionManager alloc] initWithBackendInterface:[TPUBackendInterface new]];
    [_regionManager registerRegions];

}

- (IBAction)notificationSwitchValueChanged:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:_notificationSwitch.on forKey:@"notificationEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)textFieldEditingFinished:(id)sender {

    [[NSUserDefaults standardUserDefaults] setObject:_nameTextfield.text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
