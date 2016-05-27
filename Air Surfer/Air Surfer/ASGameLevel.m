//
//  ASGameLevel.m
//  Air Surfer
//
//  Created by Ryan King on 24/06/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import "ASGameLevel.h"
#import "ASPlayer.h"
#import "ASSurferBoard.h"
#import "ASBasicObstacle.h"
#import "ASFireGenerators.h"
#import "ASCometObstacle.h"
#import "ASMainMenu.h"

@import AVFoundation;

static const uint32_t gameFrameCategory = 0x1 << 6;
static const uint32_t obstacleCategory = 0x1 << 5;
static const uint32_t endZoneCategory = 0x1 << 7;

@interface ASGameLevel()
@property (nonatomic) AVAudioPlayer *backGroundPlayer;
@end
@implementation ASGameLevel
- (id) initWithSize:(CGSize)size{
    if(self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor blackColor];
        self.physicsWorld.contactDelegate = self;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = gameFrameCategory;
        self.physicsBody.contactTestBitMask = gameFrameCategory;
        self.anchorPoint = CGPointMake(0, 0);
        self.physicsWorld.gravity = CGVectorMake(0.0,-2.5);
        self.obstaclesCount = 0;
        self.fingerDown = NO;
        self.gameOperational = NO;
        self.gameFinished = NO;
        self.time = 0;
        self.basicObstacle = [[ASBasicObstacle alloc]init];
        self.fireGenerator = [[ASFireGenerators alloc]init];
        
        NSError *error;
        NSURL *backgroundMusicURL = [[NSBundle mainBundle]URLForResource:@"airSurferTheme" withExtension:@"mp3"];
        self.backGroundPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:backgroundMusicURL error:&error];
        self.backGroundPlayer.numberOfLoops = -1;
        [self.backGroundPlayer prepareToPlay];
        [self.backGroundPlayer play];
        
        self.stopWatchNode = [[SKLabelNode alloc]initWithFontNamed:@"Verdana-Bold"];
        self.stopWatchNode.text = [NSString stringWithFormat:@"%f",self.time];
        self.stopWatchNode.color = [SKColor whiteColor];
        self.stopWatchNode.fontSize = 35;
        self.stopWatchNode.zPosition = 12;
        self.stopWatchNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-30);
        [self addChild:self.stopWatchNode];
        
        self.restartButton = [[SKSpriteNode alloc]initWithImageNamed:@"restartButton.png"];
        self.restartButton.zPosition = 18;
        self.restartButton.size = CGSizeMake(60, 60);
        self.restartButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:self.restartButton];
        self.restartButton.hidden = YES;
        
        self.backButton = [[SKLabelNode alloc]initWithFontNamed:@"Verdana-Bold"];
        self.backButton.fontSize = 20;
        self.backButton.fontColor = [SKColor redColor];
        self.backButton.text = @"Back";
        self.backButton.zPosition = 18;
        self.backButton.position = CGPointMake(CGRectGetMidX(self.frame)-50, CGRectGetMidY(self.frame)+50);
        [self addChild:self.backButton];
        self.backButton.hidden = YES;
        
        self.startButton = [[SKLabelNode alloc]initWithFontNamed:@"Verdana-Bold"];
        self.startButton.fontSize = 35;
        self.startButton.fontColor = [SKColor yellowColor];
        self.startButton.text = @"Tap to start!";
        self.startButton.zPosition = 18;
        self.startButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+30);
        [self addChild:self.startButton];
        
        self.scoreLabel = [[SKLabelNode alloc]initWithFontNamed:@"Verdana-Bold"];
        self.scoreLabel.fontColor = [SKColor greenColor];
        self.scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-60);
        self.scoreLabel.zPosition = 18;
        
        self.backGroundAction = [SKAction moveByX:-1 y:0 duration:0.1];
        self.middleGroundAction = [SKAction moveByX:-2 y:0 duration:0.1];
        self.foreGroundAction = [SKAction moveByX:-3 y:0 duration:0.1];
        
        self.backGround = [[SKSpriteNode alloc]initWithImageNamed:@"starBG"];
        self.backGround.size = CGSizeMake(800, 500);
        self.backGround.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.backGround.zPosition = 1;
        [self addChild:self.backGround];
        
        self.secondBackGround = [[SKSpriteNode alloc]initWithImageNamed:@"starBG"];
        self.secondBackGround.size = CGSizeMake(800, 500);
        self.secondBackGround.zPosition = 1;
        self.secondBackGround.position = CGPointMake(5000,CGRectGetMidY(self.frame));
        [self.secondBackGround removeFromParent];
        [self addChild:self.secondBackGround];
        
        self.middleGround = [[SKSpriteNode alloc]initWithImageNamed:@"planetTexturesMG"];
        self.middleGround.size = CGSizeMake(800, 500);
        self.middleGround.zPosition = 2;
        self.middleGround.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:self.middleGround];
        
        self.secondMiddleGround = [[SKSpriteNode alloc]initWithImageNamed:@"planetTexturesMGSecond"];
        self.secondMiddleGround.size = CGSizeMake(800, 500);
        self.secondMiddleGround.zPosition = 2;
        self.secondMiddleGround.position = CGPointMake(5000, CGRectGetMidY(self.frame));
        [self addChild:self.secondMiddleGround];
        
        self.foreGround = [[SKSpriteNode alloc]initWithImageNamed:@"starFG"];
        self.foreGround.size = CGSizeMake(800, 500);
        self.foreGround.zPosition = 3;
        self.foreGround.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:self.foreGround];
        
        self.secondForeGround = [[SKSpriteNode alloc]initWithImageNamed:@"starFG"];
        self.secondForeGround.size = CGSizeMake(800, 500);
        self.secondForeGround.zPosition = 3;
        self.secondForeGround.position = CGPointMake(5000, CGRectGetMidY(self.frame));
        [self addChild:self.secondForeGround];
        
        self.endZone = [[SKSpriteNode alloc]initWithTexture:NULL];
        self.endZone.size = CGSizeMake(40, CGRectGetMaxY(self.frame));
        self.endZone.position = CGPointMake(CGRectGetMinX(self.frame)+5, CGRectGetMidY(self.frame));
        self.endZone.zPosition = 11;
        self.endZone.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.endZone.size];
        self.endZone.physicsBody.usesPreciseCollisionDetection = YES;
        self.endZone.physicsBody.affectedByGravity = NO;
        self.endZone.physicsBody.categoryBitMask = endZoneCategory;
        self.endZone.physicsBody.contactTestBitMask = obstacleCategory;
        self.endZone.physicsBody.collisionBitMask = endZoneCategory;
        NSArray *endZoneFramesArray;
        SKTextureAtlas *endZoneAtlas = [SKTextureAtlas atlasNamed:@"meteoWall"];
        SKTexture *endZoneTextureOne = [endZoneAtlas textureNamed:@"meteoWallSprite.png"];
        SKTexture *endZoneTextureTwo = [endZoneAtlas textureNamed:@"meteoWallSprite1.png"];
        SKTexture *endZoneTextureThree = [endZoneAtlas textureNamed:@"meteoWallSprite2.png"];
        SKTexture *endZoneTextureFour = [endZoneAtlas textureNamed:@"meteoWallSprite3.png"];
        endZoneFramesArray = [NSArray arrayWithObjects:endZoneTextureOne,endZoneTextureTwo,endZoneTextureThree,endZoneTextureFour, nil];
        [self addChild:self.endZone];
        [self.endZone runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:endZoneFramesArray timePerFrame:0.5]]];
        
        self.player = [[ASPlayer alloc]init];
        self.player.position = CGPointMake(CGRectGetMidX(self.frame)-90, CGRectGetMidY(self.frame));
        //[self addChild:self.player];
        
        self.playerBoard = [[ASSurferBoard alloc]init];
        self.playerBoard.position = CGPointMake(CGRectGetMidX(self.frame)-90, CGRectGetMidY(self.frame)-10);
       // [self addChild:self.playerBoard];
        [self.playerBoard getSpriteTextures];
        
        for (int i = 0; i < 3; i++) {
            SKTextureAtlas *heartAtlas = [SKTextureAtlas atlasNamed:@"heart"];
            SKTexture *heartTextureOne = [heartAtlas textureNamed:@"heartSprite1"];
            SKTexture *heartTextureTwo = [heartAtlas textureNamed:@"heartSprite2"];
            SKSpriteNode *heart = [[SKSpriteNode alloc]init];
            CGSize heartSize;
            heartSize.height = 15;
            heartSize.width = 20;
            heart.size = heartSize;
            heart.zPosition = 11;
            heart.name = @"heart";
            NSLog(@"life bar count is %ld",(long)self.player.hitPoints.count);
            NSLog(@"life bar is %@",self.player.hitPoints);
            if(self.player.hitPoints.count < 1)
            {
                heart.position = CGPointMake(CGRectGetMinX(self.frame)+40, CGRectGetMaxY(self.frame)-30);
                [self addChild:heart];
                [self.player.hitPoints addObject:heart];
                [heart runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[heartTextureOne,heartTextureTwo] timePerFrame:0.5]]];
                NSLog(@"creating heart RIGHt");
            }else if(self.player.hitPoints.count == 1 || self.player.hitPoints.count == 2){
                NSUInteger secondLastInt = [self.player.hitPoints count]-1;
                SKSpriteNode *previousHeart = [self.player.hitPoints objectAtIndex:secondLastInt];
                int newXForHeart = previousHeart.position.x + 20;
                heart.position = CGPointMake(CGRectGetMinX(self.frame)+newXForHeart, CGRectGetMaxY(self.frame)-30);
                [self addChild:heart];
                [self.player.hitPoints addObject:heart];
                [heart runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[heartTextureOne,heartTextureTwo] timePerFrame:0.5]]];
                NSLog(@"creating heart");
            }
            else{
                NSUInteger secondLastInt = [self.player.hitPoints count]-2;
                SKSpriteNode *previousHeart = [self.player.hitPoints objectAtIndex:secondLastInt];
                int newXForHeart = previousHeart.position.x + 20;
                heart.position = CGPointMake(CGRectGetMinX(self.frame)+newXForHeart, CGRectGetMaxY(self.frame)-30);
                [self addChild:heart];
                [self.player.hitPoints addObject:heart];
                [heart runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[heartTextureOne,heartTextureTwo] timePerFrame:0.5]]];
                NSLog(@"creating heart here");
                
            }
           // NSLog(@"life bar is %u",endZoneCategory);
            
        }
       
               //init joint
        self.surferJoint = [SKPhysicsJointFixed jointWithBodyA:self.player.physicsBody bodyB:self.playerBoard.physicsBody anchor:self.playerBoard.position];
        
        
        [self addChild:self.player];
        [self addChild:self.playerBoard];
        [self.physicsWorld addJoint:self.surferJoint];
        
        
        [self spawnEmitters];
        
        
        
    }
    
 
    
    return self;
}

- (void) spawnEmitters{
    //testing emitters
    NSString *myParticlePath = [[NSBundle mainBundle]pathForResource:@"fireParticle" ofType:@"sks"];
    //NSString *myOtherParticlePath = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"sks"];
    
    SKEmitterNode *myParticle = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
   // myParticle.particlePosition = self.endZone.position;
    myParticle.particleBirthRate = 100;
    myParticle.zPosition = 16;
    myParticle.targetNode = self.endZone;
    [self addChild:myParticle];
    
    SKEmitterNode *otherEndFrameParticle = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
    otherEndFrameParticle.particleBirthRate = 100;
    otherEndFrameParticle.zPosition = 16;
    otherEndFrameParticle.position = self.endZone.position;
    otherEndFrameParticle.particleSize = CGSizeMake(50, 200);
    [self addChild:otherEndFrameParticle];
    
    //these emitters are for the top and bottom
    SKEmitterNode *topFrameEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
    topFrameEmitter.particleBirthRate = 100;
    topFrameEmitter.zPosition = 16;
    topFrameEmitter.particleSize = CGSizeMake(900, 50);
    topFrameEmitter.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-10);
    [self addChild:topFrameEmitter];
    
    SKEmitterNode *bottomFrameEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
    bottomFrameEmitter.particleBirthRate = 30;
    bottomFrameEmitter.zPosition = 16;
    bottomFrameEmitter.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame)-40);
    bottomFrameEmitter.particleSize = CGSizeMake(900, 50);
    [self addChild:bottomFrameEmitter];
    
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!self.gameOperational && !self.gameFinished)
    {
        self.player.physicsBody.affectedByGravity = YES;
        self.playerBoard.physicsBody.affectedByGravity = YES;
        
        
        SKAction *spawnObstaclesAction = [SKAction sequence:@[[SKAction performSelector:@selector(spawnObstacles) onTarget:self],[SKAction waitForDuration:1]]];
        [self runAction:[SKAction repeatActionForever:spawnObstaclesAction]];
        
        SKAction *spawnFireGeneratorsAction = [SKAction sequence:@[[SKAction performSelector:@selector(spawnFireGenerators) onTarget:self],[SKAction waitForDuration:3]]];
        [self runAction:[SKAction repeatActionForever:spawnFireGeneratorsAction]];
        
        SKAction *spawnCometObstacle = [SKAction sequence:@[[SKAction waitForDuration:2],[SKAction performSelector:@selector(spawnCometObstacle) onTarget:self]]];
        [self runAction:[SKAction repeatActionForever:spawnCometObstacle]];
        
        NSLog(@"category is %u",obstacleCategory);
        NSLog(@"otherCategory is %u",self.fireGenerator.physicsBody.categoryBitMask);
        
        
        self.gameOperational = YES;
        
        [self.startButton removeFromParent];
    }
    if(!self.gameOperational)
    {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInNode:self];
        if([self.restartButton containsPoint:currentPoint] && self.restartButton.hidden == NO)
            {
                ASGameLevel *gameLevel = [[ASGameLevel alloc]initWithSize:self.size];
                gameLevel.scaleMode = SKSceneScaleModeAspectFill;
                SKTransition *transition = [SKTransition fadeWithColor:[UIColor blackColor] duration:1.5];
                [self.view presentScene:gameLevel transition:transition];
            }
        else if ([self.backButton containsPoint:currentPoint] && self.restartButton.hidden == NO)
        {
            ASMainMenu *mainMenu = [[ASMainMenu alloc]initWithSize:self.size];
            mainMenu.scaleMode = SKSceneScaleModeAspectFill;
            SKTransition *transition = [SKTransition fadeWithDuration:1];
            [self.view presentScene:mainMenu transition:transition];
        }
    }
    self.fingerDown = YES;
   
   self.playerBoard.texture = [self.playerBoard.framesArray objectAtIndex:1];
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.fingerDown = NO;
    self.playerBoard.texture = [self.playerBoard.framesArray objectAtIndex:0];
}


- (void) didBeginContact:(SKPhysicsContact *)contact{
    NSLog(@"here");
    NSLog(@"contacts are %u, %u",contact.bodyA.categoryBitMask,contact.bodyB.categoryBitMask);
    
    //handle contacts for endFrameCategory
    if(contact.bodyA.categoryBitMask == 128 || contact.bodyB.categoryBitMask == 128)
   {
       if(contact.bodyA.categoryBitMask == 32)
       {
           [contact.bodyA.node removeFromParent];
       }else if(contact.bodyB.categoryBitMask == 32)
       {
           [contact.bodyB.node removeFromParent];
       }
       if(contact.bodyA.categoryBitMask == 256)
       {
           [contact.bodyA.node removeFromParent];
           
       }else if (contact.bodyB.categoryBitMask == 256)
       {
           [contact.bodyB.node removeFromParent];
       }
       
   }
    
    if(contact.bodyA.categoryBitMask == 1 || contact.bodyB.categoryBitMask == 1)
    {
        if (contact.bodyA.categoryBitMask == 32 || contact.bodyB.categoryBitMask == 32) {
            
            SKSpriteNode *latestHeart = [self.player.hitPoints lastObject];
            [latestHeart removeFromParent];

            if(self.player.hitPoints.count != 0)
            {
                
                [self.player.hitPoints removeObjectAtIndex:[self.player.hitPoints count]-1];
                self.player.color = [SKColor redColor];
                self.playerBoard.color = [SKColor redColor];
                self.player.colorBlendFactor = 1;
                self.playerBoard.colorBlendFactor = 1;
                
            }else if (self.player.hitPoints.count == 0)
            {
                NSLog(@"Game Over");
                //game over
                [self gameOver];
                [self.player removeFromParent];
                [self.playerBoard removeFromParent];
            }
            
        }else if(contact.bodyA.categoryBitMask == 256 ||  contact.bodyB.categoryBitMask == 256)
        {
            if([[contact.bodyA.node.userData objectForKey:@"isFirePresent"] isEqualToString:@"firePresent"])
            {
                SKSpriteNode *latestHeart = [self.player.hitPoints lastObject];
                [latestHeart removeFromParent];
                
                if(self.player.hitPoints.count != 0)
                {
                    
                    [self.player.hitPoints removeObjectAtIndex:[self.player.hitPoints count]-1];
                    self.player.color = [SKColor redColor];
                    self.playerBoard.color = [SKColor redColor];
                    self.player.colorBlendFactor = 1;
                    self.playerBoard.colorBlendFactor = 1;
                    
                }else if (self.player.hitPoints.count == 0)
                {
                    NSLog(@"Game Over");
                    //game over
                    [self gameOver];
                    [self.player removeFromParent];
                    [self.playerBoard removeFromParent];
                }
                
            }else if([[contact.bodyB.node.userData objectForKey:@"isFirePresent"] isEqualToString:@"firePresent"]){
                 SKSpriteNode *latestHeart = [self.player.hitPoints lastObject];
                 [latestHeart removeFromParent];
                 
                 if(self.player.hitPoints.count != 0)
                 {
                     
                     [self.player.hitPoints removeObjectAtIndex:[self.player.hitPoints count]-1];
                     self.player.color = [SKColor redColor];
                     self.playerBoard.color = [SKColor redColor];
                     self.player.colorBlendFactor = 1;
                     self.playerBoard.colorBlendFactor = 1;
                     
                 }else if (self.player.hitPoints.count == 0)
                 {
                     NSLog(@"Game Over");
                     //game over
                     [self gameOver];
                     [self.player removeFromParent];
                     [self.playerBoard removeFromParent];
                 }
                
            }
            
        }else if (contact.bodyA.categoryBitMask == 512 || contact.bodyB.categoryBitMask == 512)
        {
            
            SKSpriteNode *latestHeart = [self.player.hitPoints lastObject];
            [latestHeart removeFromParent];
            
            if(self.player.hitPoints.count != 0)
            {
                
                [self.player.hitPoints removeObjectAtIndex:[self.player.hitPoints count]-1];
                NSLog(@"GOT HIT");
                self.player.color = [SKColor redColor];
                self.playerBoard.color = [SKColor redColor];
                self.player.colorBlendFactor = 1;
                self.playerBoard.colorBlendFactor = 1;
                
            }else if (self.player.hitPoints.count == 0)
            {
                NSLog(@"Game Over");
                //game over
                [self gameOver];
                [self.player removeFromParent];
                [self.playerBoard removeFromParent];
            }
        }
        if(contact.bodyA.categoryBitMask == 64 || contact.bodyB.categoryBitMask == 64)
        {
            [self gameOver];
            [self.player removeFromParent];
            [self.playerBoard removeFromParent];
            
        }
        if(contact.bodyA.categoryBitMask == 128 || contact.bodyB.categoryBitMask == 128)
        {
            [self gameOver];
            [self.player removeFromParent];
            [self.playerBoard removeFromParent];
        
        }
        
        
    }
    //endFrame
    if(contact.bodyA.categoryBitMask == 64 || contact.bodyB.categoryBitMask == 64)
    {
        if(contact.bodyA.categoryBitMask == 512)
        {
            [contact.bodyA.node removeFromParent];
            NSLog(@"got rid of comet");
        }else if(contact.bodyB.categoryBitMask == 512)
        {
            [contact.bodyB.node removeFromParent];
            NSLog(@"got rid of comet 2nd");

        }
        
    }
    
    //obstacleCollisions
    if(contact.bodyA.categoryBitMask == 32 || contact.bodyB.categoryBitMask == 32)
    {
        if(contact.bodyA.categoryBitMask == 256)
        {
            contact.bodyB.node.position = CGPointMake(contact.bodyA.node.position.x + 30, contact.bodyB.node.position.y);
            NSLog(@"moving obstacle FIRST");
        }else if(contact.bodyB.categoryBitMask == 256)
        {
            contact.bodyA.node.position = CGPointMake(contact.bodyB.node.position.x + 30, contact.bodyA.node.position.y);
            NSLog(@"moving obstacle SECOND");
        }
        
        if(contact.bodyA.categoryBitMask == 32 && contact.bodyB.categoryBitMask == 32)
        {
            contact.bodyB.node.position = CGPointMake(contact.bodyA.node.position.x + 30, contact.bodyB.node.position.y);
            NSLog(@"moving obstacle THIRD");
        }
    }
    
    
    
}

- (void) spawnObstacles{
    ASBasicObstacle *basicObstacle = [[ASBasicObstacle alloc]init];
    int maxY = CGRectGetMaxY(self.frame);
    int maxX = CGRectGetMaxX(self.frame);
   // NSLog(@"max X is %d",maxX);
    //70 and 50
    int randomY = arc4random_uniform(maxY);
    int randomX = arc4random() % maxX + maxX  / 2;
   // int randomX = arc4random() % maxX;
   // NSLog(@"random x and y is %d,%d",randomX,randomY);
    while(randomX < self.player.position.x)
    {
        randomX = arc4random() % 320;
        //NSLog(@"changing randomX");
    }
    basicObstacle.position = CGPointMake(maxX, randomY);
    
    
    [self addChild:basicObstacle];
    [basicObstacle getSpriteTextures];
    [basicObstacle runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:basicObstacle.framesArray timePerFrame:0.5]]];
    
 
    
    
}

- (void) spawnFireGenerators{
    ASFireGenerators *fireGenerator = [[ASFireGenerators alloc]init];
    int maxY = CGRectGetMidY(self.frame);
    int maxX = CGRectGetMaxX(self.frame);
    
    int minY = CGRectGetMidY(self.frame)-30;
    
    int randomY = arc4random_uniform(maxY) + minY;
    
    fireGenerator.position = CGPointMake(maxX, randomY);
    [self addChild:fireGenerator];
    [fireGenerator runAction:[SKAction repeatActionForever:fireGenerator.fireGeneratorAction]];
    
    
}

- (void) spawnCometObstacle{
    ASCometObstacle *cometObstacle = [[ASCometObstacle alloc]init];
    cometObstacle.position = CGPointMake(CGRectGetMidX(self.frame)+190, CGRectGetMidY(self.frame)+90);
    
    [self addChild:cometObstacle];
    [cometObstacle getSpriteTextures];
    [cometObstacle runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:cometObstacle.framesArray timePerFrame:0.3]]];
    [cometObstacle runAction:cometObstacle.cometAction];
    
    self.player.colorBlendFactor = 0;
    self.playerBoard.colorBlendFactor = 0;

}
- (void) didSimulatePhysics{
   
    //temp
    [self enumerateChildNodesWithName:@"basicObstacle" usingBlock:^(SKNode *obstacle, BOOL *stop)
    {
        
        [obstacle runAction:self.basicObstacle.moveLeft];
        //such bad code ^^ thats why its temporary
        
    }];
    [self enumerateChildNodesWithName:@"fireGenerators" usingBlock:^(SKNode *fireObstacle, BOOL *stop)
    {
        
        [fireObstacle runAction:self.fireGenerator.moveLeft];
        
    }];
    if(self.fingerDown)
    {
        
    [self.playerBoard.physicsBody applyForce:CGVectorMake(0, 50)];
    
    }
    
    //handle parralax scrolling
    [self.backGround runAction:self.backGroundAction];
    [self.secondBackGround runAction:self.backGroundAction];
    [self.middleGround runAction:self.middleGroundAction];
    [self.secondMiddleGround runAction:self.middleGroundAction];
    [self.foreGround runAction:self.foreGroundAction];
    [self.secondForeGround runAction:self.foreGroundAction];
    
    //backgroundScrolling
    if(self.backGround.position.x + (self.backGround.size.width / 2) <= CGRectGetMaxX(self.frame))
    {
        // NSLog(@"firstBackGroundDone");
        self.secondBackGround.position = CGPointMake(self.backGround.position.x + (self.backGround.size.width )-20,CGRectGetMidY(self.frame));
        
        
    }
    if(self.secondBackGround.position.x + (self.secondBackGround.size.width / 2) <= CGRectGetMaxX(self.frame))
    {
        self.backGround.position = CGPointMake(self.secondBackGround.position.x + (self.secondBackGround.size.width)-15, CGRectGetMidY(self.frame));
        // NSLog(@"second background done");
    }
    
    //middleGroundScrolling
    if(self.middleGround.position.x + (self.middleGround.size.width / 2) <= CGRectGetMaxX(self.frame))
    {
        
        self.secondMiddleGround.position = CGPointMake(self.middleGround.position.x + (self.middleGround.size.width )-20,CGRectGetMidY(self.frame));
        
        
        
    }
    if(self.secondMiddleGround.position.x + (self.secondMiddleGround.size.width / 2) <= CGRectGetMaxX(self.frame))
    {
        self.middleGround.position = CGPointMake(self.secondMiddleGround.position.x + (self.secondMiddleGround.size.width)-15, CGRectGetMidY(self.frame));
        
    }
    //foreGroundScrolling
    if(self.foreGround.position.x + (self.foreGround.size.width / 2) <= CGRectGetMaxX(self.frame))
    {
        
        self.secondForeGround.position = CGPointMake(self.foreGround.position.x + (self.foreGround.size.width )-20,CGRectGetMidY(self.frame));
        
        
        
    }
    if(self.secondForeGround.position.x + (self.secondForeGround.size.width / 2) <= CGRectGetMaxX(self.frame))
    {
        self.foreGround.position = CGPointMake(self.secondForeGround.position.x + (self.secondForeGround.size.width)-15, CGRectGetMidY(self.frame));
        
    }
    if(self.gameOperational)
    {
    self.time += 0.05;
    self.stopWatchNode.text = [NSString stringWithFormat:@"%f",self.time];
    }
}

- (void) gameOver{
    NSString *mySparkParticlePath = [[NSBundle mainBundle] pathForResource:@"sparkParticle" ofType:@"sks"];
    SKEmitterNode *sparkParticleNode = [NSKeyedUnarchiver unarchiveObjectWithFile:mySparkParticlePath];
    sparkParticleNode.particleBirthRate = 40;
    sparkParticleNode.zPosition = 16;
    sparkParticleNode.particlePosition = self.playerBoard.position;
    sparkParticleNode.particleSize = CGSizeMake(100, 100);
    [self addChild:sparkParticleNode];
    self.gameOperational = NO;
    self.gameFinished = YES;
    float finalTime;
    finalTime = self.time;
    int intValue = (int)finalTime;
    self.stopWatchNode.text = [NSString stringWithFormat:@"%f",finalTime];
    NSLog(@"final time is %f",finalTime);
    NSLog(@"EXPLODE");
    
    self.restartButton.hidden = NO;
    self.backButton.hidden = NO;
    self.scoreLabel.text = [NSString stringWithFormat:@"Final Score: %i seconds",intValue];
    [self addChild:self.scoreLabel];

    NSString *explosionExtension;
    int randomExplosion = arc4random_uniform(3);
    if(randomExplosion == 2)
    {
        explosionExtension = @".aif";
    }else{
        explosionExtension = @".mp3";
    }
    SKAction *playExplosion = [SKAction playSoundFileNamed:[NSString stringWithFormat:@"explosion%d%@", randomExplosion,explosionExtension] waitForCompletion:YES];
    [self runAction:playExplosion];
    
    [self.backGroundPlayer stop];
    
}

@end
