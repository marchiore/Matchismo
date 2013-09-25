//
//  Deck.m
//  Matchismo
//
//  Created by Matheus Marchiore on 6/26/13.
//  Copyright (c) 2013 Matheus Marchiore. All rights reserved.
//

#import "Deck.h"

@interface Deck()

//Propriedade atribuida dentro do implementation pois não queremos que este seja public
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck


// Lazy Instantiation
- (NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;        
}

/* Adiciona a objeto Card ao NSMutableArray, se não tiver nenhum
 * ele coloca na primeira posição caso contrário vai adicionando
 * Este método é utilizado Pela classe PlayingCardDeck para inserir Aleatóriamente as cartas no Array
 */
- (void)addCard:(Card *)card atTop:(BOOL)atTop{
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    }else{
        [self.cards addObject:card];
    }

}


/* Método utilizado para que a partir do Array seja removido uma carta
 * Randomica
 */
- (Card *)drawRandomCard{
    
    Card *randomCard = nil;
    
    if(self.cards.count){
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
    
}

@end
