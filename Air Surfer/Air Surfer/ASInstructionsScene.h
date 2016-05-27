//
//  ASInstructionsScene.h
//  Air Surfer
//
//  Created by Ryan King on 2/11/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class ASBasicObstacle;
@class ASPlayer;
@class ASSurferBoard;
@class ASCometObstacle;

@interface ASInstructionsScene : SKScene

@property (nonatomic) SKLabelNode *instructionsTitle;

@property (nonatomic) SKLabelNode *backButton;

@property (nonatomic) SKLabelNode *firstInstructions;
@property (nonatomic) SKLabelNode *secondInstructions;
@property (nonatomic) SKLabelNode *thirdInstructions;
@property (nonatomic) SKLabelNode *fourthInstructions;

@property (nonatomic) ASBasicObstacle *basicObstacleSprite;
@property (nonatomic) ASPlayer *playerSprite;
@property (nonatomic) ASSurferBoard *surferBoardSprite;
@property (nonatomic) ASCometObstacle *cometObstacleSprite;

@end
