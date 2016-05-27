//
//  ASCometObstacle.h
//  Air Surfer
//
//  Created by Ryan King on 1/11/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASCometObstacle : SKSpriteNode

@property (nonatomic) SKAction *cometAction;

- (void) getSpriteTextures;
@property (nonatomic) NSArray *framesArray;


@end
