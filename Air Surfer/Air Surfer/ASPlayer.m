//
//  ASPlayer.m
//  Air Surfer
//
//  Created by Ryan King on 24/06/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import "ASPlayer.h"
static const uint32_t playerCategory  = 0x1 << 0;
static const uint32_t endZoneCategory = 0x1 << 7;
static const uint32_t gameFrameCategory = 0x1 << 6;
@implementation ASPlayer
- (id) init{
    self = [[ASPlayer alloc]initWithImageNamed:@"airSurferPlayerSprite.png"];
    CGSize playerSize;
    playerSize.height = 20;
    playerSize.width = 20;
    self.size = playerSize;
    self.zPosition = 10;
    self.name = @"player";
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.categoryBitMask = playerCategory;
    self.physicsBody.contactTestBitMask = gameFrameCategory | endZoneCategory;
    
    self.hitPoints = [[NSMutableArray alloc]init];
    
    return self;
}
@end
