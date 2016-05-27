//
//  ASFireGenerators.h
//  Air Surfer
//
//  Created by Ryan King on 1/07/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASFireGenerators : SKSpriteNode

@property (nonatomic) BOOL firePresent;
@property (nonatomic) SKAction *moveLeft;

- (void) generateFire;
- (void) extinguishFire;

@property (nonatomic) SKAction *fireGeneratorAction;


@end
