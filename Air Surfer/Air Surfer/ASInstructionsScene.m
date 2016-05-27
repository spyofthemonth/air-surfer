//
//  ASInstructionsScene.m
//  Air Surfer
//
//  Created by Ryan King on 2/11/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import "ASInstructionsScene.h"
#import "ASMainMenu.h"
#import "ASPlayer.h"
#import "ASSurferBoard.h"
#import "ASBasicObstacle.h"
#import "ASCometObstacle.h"


@implementation ASInstructionsScene
-(id) initWithSize:(CGSize)size{
    if(self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor blueColor];
        
        self.instructionsTitle = [[SKLabelNode alloc]initWithFontNamed:@"MarkerFelt-Thin"];
        self.instructionsTitle.fontSize = 50;
        self.instructionsTitle.fontColor = [SKColor greenColor];
        self.instructionsTitle.text = @"Instructions";
        self.instructionsTitle.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-40);
        [self addChild:self.instructionsTitle];
        
        self.backButton = [[SKLabelNode alloc]initWithFontNamed:@"Verdana-Bold"];
        self.backButton.fontSize = 20;
        self.backButton.fontColor = [SKColor redColor];
        self.backButton.text = @"Back";
        self.backButton.position = CGPointMake(CGRectGetMinX(self.frame)+50, CGRectGetMaxY(self.frame)-40);
        [self addChild:self.backButton];
        
        
        self.firstInstructions = [[SKLabelNode alloc]initWithFontNamed:@"CourierNewPS-BoldItalicMT"];
        self.firstInstructions.fontSize = 15;
        self.firstInstructions.fontColor = [SKColor yellowColor];
        self.firstInstructions.text = @"Dodge obstacles to escape the incoming wall of meteorites!";
        self.firstInstructions.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-80);
        [self addChild:self.firstInstructions];
        
        self.secondInstructions = [[SKLabelNode alloc]initWithFontNamed:@"CourierNewPS-BoldItalicMT"];
        self.secondInstructions.fontSize = 10;
        self.secondInstructions.fontColor = [SKColor yellowColor];
        self.secondInstructions.text = @"Incoming comets and obstacles will push you back and damage your board";
        self.secondInstructions.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:self.secondInstructions];
        
        self.thirdInstructions = [[SKLabelNode alloc]initWithFontNamed:@"CourierNewPS-BoldItalicMT"];
        self.thirdInstructions.fontSize = 10;
        self.thirdInstructions.fontColor = [SKColor yellowColor];
        self.thirdInstructions.zPosition = 16;
        self.thirdInstructions.text = @"Tap to hover up!";
        self.thirdInstructions.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+30);
        [self addChild:self.thirdInstructions];
        
        self.fourthInstructions = [[SKLabelNode alloc]initWithFontNamed:@"CourierNewPS-BoldItalicMT"];
        self.fourthInstructions.fontSize = 10;
        self.fourthInstructions.fontColor = [SKColor redColor];
        self.fourthInstructions.zPosition = 11;
        self.fourthInstructions.text = @"Survive as long as you can and don't fall too low or hover too high!";
        self.fourthInstructions.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+100);
        [self addChild:self.fourthInstructions];
        
        self.playerSprite = [[ASPlayer alloc]init];
        self.playerSprite.position = CGPointMake(CGRectGetMidX(self.frame)-110, CGRectGetMidY(self.frame)+70);
        self.playerSprite.physicsBody.affectedByGravity = NO;
        [self addChild:self.playerSprite];
        
        self.surferBoardSprite = [[ASSurferBoard alloc]init];
        self.surferBoardSprite.position = CGPointMake(CGRectGetMidX(self.frame)-50, CGRectGetMidY(self.frame)+70);
        self.surferBoardSprite.physicsBody.affectedByGravity = NO;
        [self addChild:self.surferBoardSprite];
        [self.surferBoardSprite getSpriteTextures];
        [self.surferBoardSprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.surferBoardSprite.framesArray timePerFrame:1]]];
        
        self.basicObstacleSprite = [[ASBasicObstacle alloc]init];
        self.basicObstacleSprite.position = CGPointMake(CGRectGetMidX(self.frame)+10, CGRectGetMidY(self.frame)+70);
        [self addChild:self.basicObstacleSprite];
        [self.basicObstacleSprite getSpriteTextures];
        [self.basicObstacleSprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.basicObstacleSprite.framesArray timePerFrame:0.5]]];
        
        self.cometObstacleSprite = [[ASCometObstacle alloc]init];
        self.cometObstacleSprite.position = CGPointMake(CGRectGetMidX(self.frame)+70, CGRectGetMidY(self.frame)+70);
        [self addChild:self.cometObstacleSprite];
        [self.cometObstacleSprite getSpriteTextures];
        [self.cometObstacleSprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.cometObstacleSprite.framesArray timePerFrame:0.5]]];
        
        
    }
    
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentPont = [touch locationInNode:self];
    if([self.backButton containsPoint:currentPont])
    {
        ASMainMenu *mainMenu = [[ASMainMenu alloc]initWithSize:self.size];
        mainMenu.scaleMode = SKSceneScaleModeAspectFill;
        SKTransition *transition = [SKTransition fadeWithDuration:1];
        [self.view presentScene:mainMenu transition:transition];
        
    }
    
}
@end
