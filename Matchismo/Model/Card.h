//
//  Card.h
//  Matchismo
//
//  Created by Matheus Marchiore on 6/26/13.
//  Copyright (c) 2013 Matheus Marchiore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isunplayable) BOOL unplayable;

-(int)match:(NSArray *)otherCards;

@end
