//
//  ASViewController.m
//  Air Surfer
//
//  Created by Ryan King on 24/06/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import "ASViewController.h"
#import "ASGameLevel.h"
#import "ASMainMenu.h"

@implementation ASViewController

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
   // skView.showsFPS = YES;
   // skView.showsNodeCount = YES;
    //skView.showsPhysics = YES;

    
    // Create and configure the scene.
    ASMainMenu* scene = [ASMainMenu sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL) prefersStatusBarHidden{
    return true;
}

@end
