//
//  ASSurferBoard.m
//  Air Surfer
//
//  Created by Ryan King on 24/06/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import "ASSurferBoard.h"
static const uint32_t boardCategory = 0x1 << 0;
static const uint32_t gameFrameCategory = 0x1 << 6;
static const uint32_t endZoneCategory = 0x1 << 7;

@implementation ASSurferBoard

- (id) init{
    SKTextureAtlas *textureAtlasBoard = [SKTextureAtlas atlasNamed:@"board"];
    SKTexture *textureBoardOne = [textureAtlasBoard textureNamed:@"airSurferBoardSprite"];
    SKTexture *textureBoardTwo = [textureAtlasBoard textureNamed:@"airSurferBoardSprite2"];
    self.framesArray = [[NSArray alloc]initWithObjects:textureBoardOne,textureBoardTwo,nil];
    
    self = [[ASSurferBoard alloc]initWithTexture:textureBoardOne];
    CGSize boardSize;
    boardSize.height = 10;
    boardSize.width = 40;
    self.size = boardSize;
    self.zPosition = 11;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = boardCategory;
    self.physicsBody.contactTestBitMask = gameFrameCategory | endZoneCategory;
   // self.physicsBody.contactTestBitMask = playerCategory;

    
    return self;
    
}

- (void) getSpriteTextures{
    //temp????
    SKTextureAtlas *textureAtlasBoard = [SKTextureAtlas atlasNamed:@"board"];
    SKTexture *textureBoardOne = [textureAtlasBoard textureNamed:@"airSurferBoardSprite"];
    SKTexture *textureBoardTwo = [textureAtlasBoard textureNamed:@"airSurferBoardSprite2"];
    self.framesArray = [[NSArray alloc]initWithObjects:textureBoardOne,textureBoardTwo,nil];
}

@end
