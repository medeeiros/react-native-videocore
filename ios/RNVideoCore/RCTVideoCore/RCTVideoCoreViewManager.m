//
//  RCTVideoCoreViewManager.m
//  RNVideoCore
//
//  Created by Guilherme Medeiros on 17/12/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import "RCTVideoCoreViewManager.h"
#import "RCTVideoCoreView.h"

@implementation RCTVideoCoreViewManager

RCT_EXPORT_MODULE();

@synthesize bridge = _bridge;

- (UIView *) view
{
  return [[RCTVideoCoreView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(startStreaming: (NSString *)streamUrl andStreamKey:(NSString *) streamKey) {
  [RCTVideoCoreView startStream:streamUrl andStreamKey:streamKey];
}

RCT_EXPORT_METHOD(stopStreaming) {
  [RCTVideoCoreView stopStream];
}

RCT_EXPORT_METHOD(toggleTorch) {
  [RCTVideoCoreView toggleTorch];
}

RCT_EXPORT_METHOD(flipCamera) {
  [RCTVideoCoreView flipCamera];
}

@end
