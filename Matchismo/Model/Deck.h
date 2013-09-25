//
//  Deck.h
//  Matchismo
//
//  Created by Matheus Marchiore on 6/26/13.
//  Copyright (c) 2013 Matheus Marchiore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
