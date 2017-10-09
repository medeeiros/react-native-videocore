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

#define VIDEOCORE_CURRENT_CAMERA_KEY @"currentCameraKey"

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
  CGFloat scale = [UIScreen mainScreen].scale;
  NSNumber *currentCamera = [RCTVideoCoreView getDefaultNumberFofKey:VIDEOCORE_CURRENT_CAMERA_KEY withDefaultValue:[NSNumber numberWithInteger:VCCameraStateFront]];

  session = [[VCSimpleSession alloc] initWithVideoSize:CGSizeMake(1280, 720)
                                             frameRate:30
                                               bitrate:1000000
                               useInterfaceOrientation:YES
                                           cameraState:[currentCamera integerValue]
                                            aspectMode:VCAspectModeFit
             ];
  
  if(currentCamera == [NSNumber numberWithInteger:VCCameraStateFront]) {
    [session.previewView setTransform:CGAffineTransformMakeScale(-1, 1)];
  }
  
//  session = [[VCSimpleSession alloc] initWithVideoSize:CGSizeMake(rect.size.height * scale, rect.size.width * scale)
//                                             frameRate:30
//                                               bitrate:1000000
//                               useInterfaceOrientation:YES
//                                           cameraState:[currentCamera integerValue]
//                                            aspectMode:VCAscpectModeFill
//             ];
  
  
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
  session = nil;
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
    [session.previewView setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self saveDefaultNumber:[NSNumber numberWithInteger:VCCameraStateFront] forKey:VIDEOCORE_CURRENT_CAMERA_KEY];
  } else {
    [session setCameraState:VCCameraStateBack];
    [session.previewView setTransform:CGAffineTransformMakeScale(1, 1)];
    [self saveDefaultNumber:[NSNumber numberWithInteger:VCCameraStateBack] forKey:VIDEOCORE_CURRENT_CAMERA_KEY];
  }
}

+(void)setResolution:(int)width andHeight:(int)height {
  [session setVideoSize:CGSizeMake(width, height)];
  dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.5);
//  dispatch_after(delay, dispatch_get_main_queue(), ^(void){
//    // do work in the UI thread here
//    [session.previewView setFrame:[UIScreen mainScreen].bounds];
//  });
  
}

+(void)setBitrate:(int)bitrate {
  [session setBitrate:bitrate];
}

+(void)setFps:(int)fps {
  [session setFps:fps];
}

+(void) saveDefaultNumber:(NSNumber *)number forKey:(NSString *)key
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:number forKey:key];
  [defaults synchronize];
}

+(NSNumber *) getDefaultNumberFofKey:(NSString *)key withDefaultValue:(NSNumber *)defaultValue
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSNumber *value = [defaults objectForKey:key];
  return value ? value : defaultValue;
}

@end
