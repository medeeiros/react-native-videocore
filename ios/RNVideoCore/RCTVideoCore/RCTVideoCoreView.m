//
//  RCTVideoCoreView.m
//  RNVideoCore
//
//  Created by Guilherme Medeiros on 17/12/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import "RCTVideoCoreView.h"

@implementation RCTVideoCoreView

- (id)initWithManager:(RCTVideoCoreViewManager *)manager bridge:(RCTBridge *)bridge
{
  if ((self = [super init])) {
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    _session = [[VCSimpleSession alloc] initWithVideoSize:rect.size frameRate:30 bitrate:1000000 useInterfaceOrientation:YES  cameraState:VCCameraStateBack aspectMode:VCAscpectModeFill];
    _session.orientationLocked = YES;
    _session.useAdaptiveBitrate = YES;
    _session.delegate = self;
    _session.previewView.frame = rect;
    
    [self addSubview:_session.previewView];
    
    [_session startRtmpSessionWithURL:@"rtmp://104.155.71.82:1935/live" andStreamKey:@"myStream"];
    
  }
  
  return self;
}

- (void) connectionStatusChanged:(VCSessionState) state
{
  
  switch(state) {
    case VCSessionStateStarting:
      NSLog(@"VCSessionStateStarting");
//      [self.btnConnect setTitle:@"Connecting" forState:UIControlStateNormal];
      break;
    case VCSessionStateStarted:
      NSLog(@"VCSessionStateStarted");
//      [self.btnConnect setTitle:@"Disconnect" forState:UIControlStateNormal];
      break;
      
    case VCSessionStateError:
      NSLog(@"VCSessionStateError");
//      [self.btnConnect setTitle:@"Disconnect" forState:UIControlStateNormal];
      break;
      
    case VCSessionStateEnded:
      NSLog(@"VCSessionStateEnded");
//      [self.btnConnect setTitle:@"Disconnect" forState:UIControlStateNormal];
      break;
      
    case VCSessionStateNone:
      NSLog(@"VCSessionStateNone");
//      [self.btnConnect setTitle:@"Disconnect" forState:UIControlStateNormal];
      break;
      
    case VCSessionStatePreviewStarted:
      NSLog(@"VCSessionStatePreviewStarted");
      break;
      
    default:
      NSLog(@"default");
//      [self.btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
      break;
  }
}


@end
