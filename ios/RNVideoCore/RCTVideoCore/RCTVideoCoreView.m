//
//  RCTVideoCoreView.m
//  RNVideoCore
//
//  Created by Guilherme Medeiros on 17/12/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import "RCTVideoCoreView.h"

@implementation RCTVideoCoreView

static VCSimpleSession *aSession;

- (instancetype)initWithFrame:(CGRect)frame {
  NSLog(@"init with frame: %@", NSStringFromCGRect(frame));
  self = [super initWithFrame:frame];
  if ( self ) {
    if(!aSession) {
      [self setUp];
    }
  }
  return self;
}

- (void)didMoveToWindow {
  NSLog(@"did move to window");
  [self addSubview:aSession.previewView];
}

- (void)setUp
{
  CGRect rect = [[UIScreen mainScreen] bounds];
  
  aSession = [[VCSimpleSession alloc] initWithVideoSize:rect.size frameRate:30 bitrate:1000000 useInterfaceOrientation:YES  cameraState:VCCameraStateFront aspectMode:VCAscpectModeFill];
  aSession.orientationLocked = YES;
  aSession.useAdaptiveBitrate = YES;
  aSession.delegate = self;
  aSession.previewView.frame = rect;

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
