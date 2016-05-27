//
//  ASGameLevel.h
//  Air Surfer
//
//  Created by Ryan King on 24/06/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@class ASPlayer;
@class ASSurferBoard;
@class ASFireGenerators;
@class ASBasicObstacle;
@class ASCometObstacle;

@interface ASGameLevel : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) ASPlayer *player;
@property (nonatomic) ASSurferBoard *playerBoard;

@property (nonatomic) SKSpriteNode *endZone;

- (void) spawnObstacles;
- (void) spawnFireGenerators;
- (void) spawnCometObstacle;

- (void) spawnEmitters;
- (void) gameOver;

@property (nonatomic) int obstaclesCount;

@property (nonatomic) BOOL fingerDown;
@property (nonatomic) BOOL gameOperational;
@property (nonatomic) BOOL gameFinished;

@property (nonatomic) SKSpriteNode *backGround;
@property (nonatomic) SKSpriteNode *middleGround;
@property (nonatomic) SKSpriteNode *foreGround;
@property (nonatomic) SKSpriteNode *secondBackGround;
@property (nonatomic) SKSpriteNode *secondMiddleGround;
@property (nonatomic) SKSpriteNode *secondForeGround;

@property (nonatomic) SKAction *backGroundAction;
@property (nonatomic) SKAction *middleGroundAction;
@property (nonatomic) SKAction *foreGroundAction;

@property (nonatomic) float time;
@property (nonatomic) SKLabelNode *stopWatchNode;

@property (nonatomic) SKSpriteNode *restartButton;
@property (nonatomic) SKLabelNode *backButton;
@property (nonatomic) SKLabelNode *scoreLabel;
@property (nonatomic) SKLabelNode *startButton;

//temp

@property (nonatomic) SKPhysicsJoint *surferJoint;
@property (nonatomic) ASBasicObstacle *basicObstacle;
@property (nonatomic) ASFireGenerators *fireGenerator;
@property (nonatomic) ASCometObstacle *cometObstacle;

@end
