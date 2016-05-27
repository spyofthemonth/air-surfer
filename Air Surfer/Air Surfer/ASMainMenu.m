//
//  ASMainMenu.m
//  Air Surfer
//
//  Created by Ryan King on 2/11/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import "ASMainMenu.h"
#import "ASGameLevel.h"
#import "ASInstructionsScene.h"
#import "ASCreditsScene.h"

@implementation ASMainMenu
- (id) initWithSize:(CGSize)size{
    if(self = [super initWithSize:size])
       {
           self.backgroundColor = [SKColor blackColor];
           self.backGround = [[SKSpriteNode alloc]initWithImageNamed:@"starBG"];
           self.backGround.size = CGSizeMake(800, 500);
           self.backGround.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
           self.backGround.zPosition = 1;
           [self addChild:self.backGround];
           
           self.title = [[SKSpriteNode alloc]initWithImageNamed:@"titleFontAirSurfer.png"];
           self.title.size = CGSizeMake(100, 20);
           self.title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-50);
           self.title.zPosition = 11;
           [self addChild:self.title];
           SKAction *titleAction = [SKAction group:@[[SKAction rotateByAngle:2 * M_PI duration:2],[SKAction scaleXBy:5 y:5 duration:2]]];
           [self.title runAction:titleAction];
           
           self.playButton = [[SKLabelNode alloc]initWithFontNamed:@"GillSans-BoldItalic"];
           self.playButton.text = @"Play!";
           self.playButton.fontSize = 50;
           self.playButton.fontColor = [SKColor redColor];
           self.playButton.position = CGPointMake(CGRectGetMidX(self.frame)-300, CGRectGetMidY(self.frame));
           [self addChild:self.playButton];
           
           
           self.instructionsButton = [[SKLabelNode alloc]initWithFontNamed:@"GillSans-BoldItalic"];
           self.instructionsButton.text = @"Instructions";
           self.instructionsButton.fontSize = 45;
           self.instructionsButton.fontColor = [SKColor greenColor];
           self.instructionsButton.position = CGPointMake(CGRectGetMidX(self.frame)-410, CGRectGetMidY(self.frame)-60);
           [self addChild:self.instructionsButton];
           
           self.creditsButton = [[SKLabelNode alloc]initWithFontNamed:@"GillSans-BoldItalic"];
           self.creditsButton.text = @"Credits";
           self.creditsButton.fontSize = 45;
           self.creditsButton.fontColor = [SKColor blueColor];
           self.creditsButton.position = CGPointMake(CGRectGetMidX(self.frame)-400, CGRectGetMidY(self.frame)-120);
           [self addChild:self.creditsButton];
           
           SKAction *moveAllButtonsAction = [SKAction sequence:@[ [SKAction performSelector:@selector(movePlay) onTarget:self],[SKAction waitForDuration:1], [SKAction performSelector:@selector(moveInstructions) onTarget:self], [SKAction waitForDuration:1], [SKAction performSelector:@selector(moveCredits) onTarget:self]]];
           [self runAction:moveAllButtonsAction];
           
           
       }
    
    return self;
}

- (void) movePlay{
    SKAction *movePlay = [SKAction moveByX:+300 y:0 duration:1];
    [self.playButton runAction:movePlay];
    
    
}

- (void) moveInstructions{
    SKAction *moveInstructions = [SKAction moveByX:+410 y:0 duration:1];
    [self.instructionsButton runAction:moveInstructions];
    
}

- (void) moveCredits{
    SKAction *moveCredits = [SKAction moveByX:+400 y:0 duration:1];
    [self.creditsButton runAction:moveCredits];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInNode:self];
    
    if([self.playButton containsPoint:currentPoint])
    {
        self.playButton.color = [SKColor redColor];
        ASGameLevel *gameLevel = [[ASGameLevel alloc]initWithSize:self.size];
        gameLevel.scaleMode = SKSceneScaleModeAspectFill;
        SKTransition *transition = [SKTransition fadeWithDuration:1];
        [self.view presentScene:gameLevel transition:transition];
        
    }
    if([self.instructionsButton containsPoint:currentPoint])
    {
        self.instructionsButton.color = [SKColor redColor];
        ASInstructionsScene *instructionsScene = [[ASInstructionsScene alloc]initWithSize:self.size];
        instructionsScene.scaleMode = SKSceneScaleModeAspectFill;
        SKTransition *transition = [SKTransition doorsOpenHorizontalWithDuration:1];
        [self.view presentScene:instructionsScene transition:transition];
                                
    }
    if([self.creditsButton containsPoint:currentPoint])
    {
        self.creditsButton.color = [SKColor redColor];
        ASCreditsScene *creditsScene = [[ASCreditsScene alloc]initWithSize:self.size];
        creditsScene.scaleMode = SKSceneScaleModeAspectFill;
        SKTransition *transition = [SKTransition flipHorizontalWithDuration:1];
        [self.view presentScene:creditsScene transition:transition];
        
    }
    
}
@end
