//
//  ASFireGenerators.m
//  Air Surfer
//
//  Created by Ryan King on 1/07/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import "ASFireGenerators.h"

static const uint32_t fireGeneratorCategory = 0x1 << 8;
static const uint32_t endZoneCategory = 0x1 << 7;
static const uint32_t playerCategory = 0x1 << 0;
static const uint32_t obstacleCategory = 0x1 << 5;

@implementation ASFireGenerators

- (id) init{
    self = [[ASFireGenerators alloc]initWithImageNamed:@"fireGeneratorSprite.png"];
    self.size = CGSizeMake(20, 100);
    self.zPosition = 12;
    self.name = @"fireGenerators";
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20) center:CGPointMake(0, 40)];
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = fireGeneratorCategory;
    self.physicsBody.contactTestBitMask = playerCategory | endZoneCategory | obstacleCategory;
    self.physicsBody.collisionBitMask = fireGeneratorCategory;
    self.firePresent = NO;
    self.userData = [NSMutableDictionary dictionary];
    [self.userData setValue:@"fireNotPresent" forKey:@"isFirePresent"];
    self.fireGeneratorAction = [SKAction sequence:@[[SKAction performSelector:@selector(generateFire)onTarget:self],[SKAction waitForDuration:0.5],[SKAction performSelector:@selector(extinguishFire) onTarget:self],[SKAction waitForDuration:0.5]]];
    self.moveLeft = [SKAction moveByX:-5 y:0 duration:0.1];
    
    return self;
}


- (void) generateFire{
    self.firePresent = YES;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.categoryBitMask = fireGeneratorCategory;
    self.physicsBody.contactTestBitMask = playerCategory | endZoneCategory | obstacleCategory;
    self.physicsBody.collisionBitMask = fireGeneratorCategory;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.affectedByGravity = NO;
    self.texture = [SKTexture textureWithImageNamed:@"fireGeneratorSprite2"];
    [self.userData setValue:@"firePresent" forKey:@"isFirePresent"];
    //change texture here
    
    
}

- (void) extinguishFire{
    self.firePresent = NO;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20) center:CGPointMake(0, 40)];
    self.physicsBody.categoryBitMask = fireGeneratorCategory;
    self.physicsBody.contactTestBitMask = playerCategory | endZoneCategory | obstacleCategory;
    self.physicsBody.collisionBitMask = fireGeneratorCategory;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.affectedByGravity = NO;
    self.texture = [SKTexture textureWithImageNamed:@"fireGeneratorSprite.png"];
    [self.userData setValue:@"fireNotPresent" forKey:@"isFirePresent"];
    
}

@end
