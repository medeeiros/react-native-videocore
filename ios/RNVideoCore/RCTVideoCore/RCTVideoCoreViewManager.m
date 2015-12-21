//
//  RCTVideoCoreViewManager.m
//  RNVideoCore
//
//  Created by Guilherme Medeiros on 17/12/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import "RCTVideoCoreViewManager.h"
#import "RCTVideoCoreView.h"

@interface RCTVideoCoreViewManager()

@property (nonatomic) RCTVideoCoreView * videoCoreView;

@end



@implementation RCTVideoCoreViewManager

RCT_EXPORT_MODULE();

- (UIView *) view
{
  self.videoCoreView = [[RCTVideoCoreView alloc] init];
  return self.videoCoreView;
}

- (instancetype) init
{
  self = [super init];
  if ( self ) {
    NSLog(@"RCTVideoCoreViewManager init");
  }
  return self;
}


@end
