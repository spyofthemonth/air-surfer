//
//  ASBasicObstacle.m
//  Air Surfer
//
//  Created by Ryan King on 29/06/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import "ASBasicObstacle.h"
static const uint32_t obstacleCategory = 0x1 << 5;
static const uint32_t playerCategory  = 0x1 << 0;
static const uint32_t boardCategory = 0x1 << 0;
static const uint32_t endZoneCategory = 0x1 << 7;
static const uint32_t fireGeneratorCategory = 0x1 << 8;
//static const uint32_t cometCategory = 0x1 << 9;

@implementation ASBasicObstacle
- (id) init{
    self = [[ASBasicObstacle alloc]initWithTexture:NULL];
    CGSize obstacleSize;
    obstacleSize.height = 30;
    obstacleSize.width = 30;
    self.size = obstacleSize;
    self.zPosition = 11;
    self.name = @"basicObstacle";
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.categoryBitMask = obstacleCategory;
    self.physicsBody.contactTestBitMask = playerCategory | boardCategory | endZoneCategory | obstacleCategory | fireGeneratorCategory;
    self.physicsBody.collisionBitMask = boardCategory | obstacleCategory;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.affectedByGravity = NO;
    
    self.moveLeft = [SKAction moveByX:-5 y:0 duration:0.1];
    
    return self;
}

- (void) getSpriteTextures{
    SKTextureAtlas *basicObstacleAtlas = [SKTextureAtlas atlasNamed:@"basicObstacle"];
    SKTexture *basicObstacleTextureOne = [basicObstacleAtlas textureNamed:@"basicObstacleSprite.png"];
    SKTexture *basicObstacleTextureTwo = [basicObstacleAtlas textureNamed:@"basicObstacleSprite1.png"];
    SKTexture *basicObstacleTextureThree = [basicObstacleAtlas textureNamed:@"basicObstacleSprite2.png"];
    SKTexture *basicObstacleTextureFour = [basicObstacleAtlas textureNamed:@"basicObstacleSprite3.png"];
    SKTexture *basicObstacleTextureFive = [basicObstacleAtlas textureNamed:@"basicObstacleSprite4.png"];
    SKTexture *basicObstacleTextureSix = [basicObstacleAtlas textureNamed:@"basicObstacleSprite5.png"];
    self.framesArray = [NSArray arrayWithObjects:basicObstacleTextureOne,basicObstacleTextureTwo,basicObstacleTextureThree,basicObstacleTextureFour,basicObstacleTextureFive,basicObstacleTextureSix, nil];
    
}


@end
