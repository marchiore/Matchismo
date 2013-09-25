//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Matheus Marchiore on 7/18/13.
//  Copyright (c) 2013 Matheus Marchiore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//Inicializador da Classe onde passamos a quantidade de cartas e o deck de cartas
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

//Virar a carta em um determinado Index
- (void)flipCardAtIndex:(NSUInteger)index;

//Verificar qual a carta em um determinado index
- (Card *)cardAtIndex:(NSUInteger)index;


//Propriedade ReadOnly para administração do Score
//ReadOnly significa que esta propriedade não possui setter
@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSString *action;
@property (nonatomic) int numberMatch;
@property int numberOfCardsUp;

@end
