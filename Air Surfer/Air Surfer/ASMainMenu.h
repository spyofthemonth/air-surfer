//
//  ASMainMenu.h
//  Air Surfer
//
//  Created by Ryan King on 2/11/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASMainMenu : SKScene

@property (nonatomic) SKSpriteNode *title;
@property (nonatomic) SKLabelNode *playButton;
@property (nonatomic) SKLabelNode *instructionsButton;
@property (nonatomic) SKLabelNode *creditsButton;
@property (nonatomic) SKSpriteNode *backGround;

- (void) movePlay;
- (void) moveInstructions;
- (void) moveCredits;
@end
