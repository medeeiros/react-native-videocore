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

- (UIView *) view
{
  return [[RCTVideoCoreView alloc] initWithManager:self bridge:self.bridge];
}

@end
