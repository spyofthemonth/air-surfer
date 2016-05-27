//
//  ASSurferBoard.h
//  Air Surfer
//
//  Created by Ryan King on 24/06/14.
//  Copyright (c) 2014 Ryan King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ASSurferBoard : SKSpriteNode
@property (nonatomic) NSArray *framesArray;

- (void) getSpriteTextures;

@end
