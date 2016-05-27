//
//  ASCreditsScene.m
//  Air Surfer
//
//  Created by Ryan King on 2/11/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import "ASCreditsScene.h"
#import "ASMainMenu.h"

@implementation ASCreditsScene
- (id) initWithSize:(CGSize)size{
    if(self = [super initWithSize:size])
    {
        
        self.backgroundColor = [SKColor grayColor];
        
        self.backButton = [[SKLabelNode alloc]initWithFontNamed:@"Verdana-Bold"];
        self.backButton.fontSize = 20;
        self.backButton.fontColor = [SKColor redColor];
        self.backButton.text = @"Back";
        self.backButton.position = CGPointMake(CGRectGetMinX(self.frame)+50, CGRectGetMaxY(self.frame)-40);
        [self addChild:self.backButton];
        
        self.copyrightButton = [[SKLabelNode alloc]initWithFontNamed:@"AvenirNext-BoldItalic"];
        self.copyrightButton.fontSize = 15;
        self.copyrightButton.fontColor = [SKColor greenColor];
        self.copyrightButton.text = @"© 2014 Ryan King. All rights reserved.";
        self.copyrightButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+20);
        [self addChild:self.copyrightButton];
        
        self.creditsTitle = [[SKLabelNode alloc]initWithFontNamed:@"GillSans-BoldItalic"];
        self.creditsTitle.fontSize = 40;
        self.creditsTitle.fontColor = [SKColor blueColor];
        self.creditsTitle.text = @"Credits";
        self.creditsTitle.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-40);
        [self addChild:self.creditsTitle];
        
        self.airSurferTitle = [[SKSpriteNode alloc]initWithImageNamed:@"titleFontAirSurfer"];
        self.airSurferTitle.size = CGSizeMake(300, 60);
        self.airSurferTitle.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-75);
        self.airSurferTitle.zPosition = 11;
        [self addChild:self.airSurferTitle];
        
        self.creditsImage = [[SKSpriteNode alloc]initWithImageNamed:@"airSurferCreditsDone.gif"];
        self.creditsImage.size = CGSizeMake(300, 100);
        self.creditsImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-90);
        self.creditsImage.zPosition = 11;
        [self addChild:self.creditsImage];
        
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
