//
//  PlayingCard.h
//  Matchismo
//
//  Created by Matheus Marchiore on 7/1/13.
//  Copyright (c) 2013 Matheus Marchiore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

//Herda Card
@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit; //Nipes
@property (nonatomic) NSUInteger rank;   //Números e Letras

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
+ (NSString *)rankEquivalent:(NSUInteger)index;

@end
