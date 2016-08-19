//
//  DeviceAngles.m
//  DeviceAngles
//
//  Created by Cristian Szwarc on 20/08/16.
//

#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "DeviceAngles.h"

@implementation DeviceAngles

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (id) init {
    self = [super init];
    
    if (self) {
        self->_motionManager = [[CMMotionManager alloc] init];
        
        if([self->_motionManager isGyroAvailable])
        {
            NSLog(@"gyroscope is available");
        } else {
            NSLog(@"no gyroscope available");
        }
    }
    return self;
}

RCT_EXPORT_METHOD(setDeviceMotionUpdateInterval:(double) interval) {
    [self->_motionManager setDeviceMotionUpdateInterval:interval];
}

RCT_EXPORT_METHOD(getDeviceMotionUpdateInterval:(RCTResponseSenderBlock) callback) {
    double interval = self->_motionManager.deviceMotionUpdateInterval;
    callback(@[[NSNull null], [NSNumber numberWithDouble:interval]]);
}

RCT_EXPORT_METHOD(startMotionUpdates) {
    [self->_motionManager startDeviceMotionUpdates];
    
    [self->_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                              withHandler:^(CMDeviceMotion *devMotion, NSError *error)
    {
        CMAttitude *attitude;
        attitude = devMotion.attitude;
        
        float pitch =  (180/M_PI) * attitude.pitch;
        float roll = (180/M_PI) * attitude.roll;
        float yaw = (180/M_PI) * attitude.yaw;
        
        [self.bridge.eventDispatcher sendDeviceEventWithName:@"AnglesData" body:@{
                                                                                  @"pitch" : [NSNumber numberWithDouble:pitch],
                                                                                  @"roll" : [NSNumber numberWithDouble:roll],
                                                                                  @"yaw" : [NSNumber numberWithDouble:yaw]
                                                                                  }];
    }];
    
}

RCT_EXPORT_METHOD(stopMotionUpdates) {
    [self->_motionManager stopDeviceMotionUpdates];
}

@end
