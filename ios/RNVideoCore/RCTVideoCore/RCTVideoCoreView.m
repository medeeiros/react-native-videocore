//
//  RCTVideoCoreView.m
//  RNVideoCore
//
//  Created by Guilherme Medeiros on 17/12/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import "RCTVideoCoreView.h"

@implementation RCTVideoCoreView

static VCSimpleSession* session;

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher
{
  
  if(!session) {
    [self setUp];
  }
  
  session.delegate = self;
  _eventDispatcher = eventDispatcher;
  return [super initWithFrame:CGRectZero];
}


- (void) setUp
{

  CGRect rect = [[UIScreen mainScreen] bounds];

  session = [[VCSimpleSession alloc] initWithVideoSize:CGSizeMake(rect.size.height, rect.size.width) frameRate:30 bitrate:1000000 useInterfaceOrientation:YES  cameraState:VCCameraStateBack];
  session.orientationLocked = NO;
  session.useAdaptiveBitrate = YES;
  
}


RCT_NOT_IMPLEMENTED(- (instancetype)initWithCoder:(NSCoder *)aDecoder)
RCT_NOT_IMPLEMENTED(- (instancetype)initWithFrame:(CGRect)frame)

- (void)removeFromSuperview
{
  NSLog(@"---------------- REMOVE FROM SUPERVIEW");
  
  self.eventDispatcher = nil;
  session.delegate = nil;
  [super removeFromSuperview];
}

- (void)didMoveToWindow
{
  NSLog(@"------------ DID MOVE TO WINDOW");
  [self addSubview:session.previewView];
  
  // Get the subviews of the view
  NSArray *subviews = [self subviews];
  
  // Return if there are no subviews
  if ([subviews count] == 0) return; // COUNT CHECK LINE
  
  for (UIView *subview in subviews) {
    // Do what you want to do with the subview
    NSLog(@"%@", subview);
  }
  
}

- (void) layoutSubviews
{
  NSLog(@"------------ LAYOUT SUBVIEWS");
  
  session.previewView.frame = self.bounds;
  
  
  [self sendSubviewToBack:session.previewView];
  [super layoutSubviews];
}

+ (void) startStream:(NSString *)streamUrl andStreamKey:(NSString *)streamKey
{
  
  NSLog(@"startStream");
  [session startRtmpSessionWithURL:streamUrl andStreamKey:streamKey];
}

+ (void) stopStream
{
  NSLog(@"stopStream");
  [session endRtmpSession];
}

- (void) connectionStatusChanged:(VCSessionState) state
{
  
  NSString* eventName;
  
  switch(state) {
    case VCSessionStateStarting:
      eventName = @"VCSessionStateStarting";
      break;
      
    case VCSessionStateStarted:
      eventName = @"VCSessionStateStarted";
      break;
      
    case VCSessionStateError:
      eventName = @"VCSessionStateError";
      break;
      
    case VCSessionStateEnded:
      eventName = @"VCSessionStateEnded";
      break;
      
    case VCSessionStateNone:
      eventName = @"VCSessionStateNone";
      break;
      
    case VCSessionStatePreviewStarted:
      eventName = @"VCSessionStatePreviewStarted";
      break;
      
    default:
      eventName = @"default";
      break;
  }
  
  NSLog(@"%@", eventName);
  
  [self.eventDispatcher sendDeviceEventWithName:@"videocore.connectionStatusChanged" body:eventName];
}

+(void) toggleTorch {
  [session setTorch:!session.torch];
}

+(void) flipCamera {
  if (session.cameraState == VCCameraStateBack) {
    [session setCameraState:VCCameraStateFront];
  } else {
    [session setCameraState:VCCameraStateBack];
  }
}

@end
