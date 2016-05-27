//
//  ASBasicObstacle.h
//  Air Surfer
//
//  Created by Ryan King on 29/06/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASBasicObstacle : SKSpriteNode

@property (nonatomic) NSArray *framesArray;

- (void) getSpriteTextures;

@property (nonatomic) SKAction *moveLeft;
@end
