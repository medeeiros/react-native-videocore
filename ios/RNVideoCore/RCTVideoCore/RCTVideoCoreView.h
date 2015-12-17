//
//  RCTVideoCoreView.h
//  RNVideoCore
//
//  Created by Guilherme Medeiros on 17/12/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import "RCTView.h"
#import "RCTVideoCoreViewManager.h"
#import "VCSimpleSession.h"
#import "RCTBridge.h"

@interface RCTVideoCoreView : RCTView <VCSessionDelegate>

@property (nonatomic, retain) VCSimpleSession* session;
- (id)initWithManager:(RCTVideoCoreViewManager*)manager bridge:(RCTBridge *)bridge;

@end
