//
//  GameResult.h
//  Matchismo
//
//  Created by Matheus Marchiore on 9/22/13.
//  Copyright (c) 2013 Matheus Marchiore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (nonatomic, readonly) NSDate *start;
@property (nonatomic, readonly) NSDate *end;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic) int score;


+ (NSArray *)allGameResults;

@end
