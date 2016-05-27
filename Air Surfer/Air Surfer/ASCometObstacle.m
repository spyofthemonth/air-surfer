//
//  ASCometObstacle.m
//  Air Surfer
//
//  Created by Ryan King on 1/11/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import "ASCometObstacle.h"

static const uint32_t cometCategory = 0x1 << 9;
//static const uint32_t obstacleCategory = 0x1 << 5;
static const uint32_t playerCategory  = 0x1 << 0;
static const uint32_t boardCategory = 0x1 << 0;
//static const uint32_t fireGeneratorCategory = 0x1 << 8;
static const uint32_t gameFrameCategory = 0x1 << 6;

@implementation ASCometObstacle
- (id) init{
    self = [[ASCometObstacle alloc]initWithTexture:NULL];
    self.size = CGSizeMake(60, 60);
    self.zPosition = 13;
    self.name = @"cometObstacle";
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = cometCategory;
    self.physicsBody.collisionBitMask = cometCategory;
    self.physicsBody.contactTestBitMask = gameFrameCategory | playerCategory | boardCategory;
    
    self.cometAction = [SKAction moveByX:-600 y:-400 duration:1.5];
    // ^^ temp
    NSLog(@"category bitmask ISSSN %u",self.physicsBody.categoryBitMask);
    return self;
}

- (void) getSpriteTextures{
    SKTextureAtlas *cometAtlas = [SKTextureAtlas atlasNamed:@"cometObstacle"];
    SKTexture *cometTextureOne = [cometAtlas textureNamed:@"cometSprite.png"];
    SKTexture *cometTextureTwo = [cometAtlas textureNamed:@"cometSprite1.png"];
    SKTexture *cometTextureThree = [cometAtlas textureNamed:@"cometSprite2.png"];
    self.framesArray = [NSArray arrayWithObjects:cometTextureOne,cometTextureTwo,cometTextureThree, nil];
    
}

@end
