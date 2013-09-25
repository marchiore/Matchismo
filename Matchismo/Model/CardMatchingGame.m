//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Matheus Marchiore on 7/18/13.
//  Copyright (c) 2013 Matheus Marchiore. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame()
//Atributo Private

@property(strong, nonatomic) NSMutableArray *cards;
@property(nonatomic) int score; //Aqui ele não é readonly visto que ele é apenas private
@property(nonatomic) NSString *action;

@end

@implementation CardMatchingGame
@synthesize numberMatch = _numberMatch;

//Lazy Instantiantion para evitar problemas com chamada a objetos não existentes
- (NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (int) numberMatch{
    if(!_numberMatch){
        _numberMatch = 2;
    }
    return _numberMatch;
}

- (void) setNumberMatch:(int)numberMatch{
    if(numberMatch < 2) _numberMatch = 2;
    else if(numberMatch > 3) _numberMatch = 3;
    else _numberMatch = numberMatch;
}

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck{
    self = [super init];
    
    if(self){
        //Rodando a quantidade de cartas e setando ela no array de cartas
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            
            if(!card){
                self = nil;
            }else{
                self.cards[i] = card; //Podemos fazer isso visto que é um MutableArray
            }
        }        
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index{
    return (index < self.cards.count) ? self.cards[index] : nil;

}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (card && !card.isunplayable) {
        if (!card.isFaceUp) {
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            NSMutableArray *otherContents = [[NSMutableArray alloc] init];
            
            //Passando por todas as cartas da mesa e gravando aquelas que estão viradas para cima e não estão inativas
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isunplayable) {
                    [otherCards addObject:otherCard];
                    [otherContents addObject:otherCard.contents];
                }
            }
            
            if ([otherCards count] < self.numberMatch - 1) {
                self.action = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            } else {
                //Laço para comparar todas as cartas
                int matchScore = 0;
                BOOL bNotMatch = NO;
                
                for (Card *otherCard in otherCards) {

                    //matchScore = [card match:otherCards];
                    matchScore = [card match:otherCards];
                                        
                    if (!matchScore) {
                        //NSLog(@"NOT MATCHED");
                        bNotMatch = YES;
                        
                        for (Card *otherCard in otherCards) {
                            otherCard.faceUp = NO;
                        }
                        self.score -= MISMATCH_PENALTY;
                        self.action = [NSString stringWithFormat:@"%@ & %@ don’t match! %d point penalty!", card.contents, [otherContents componentsJoinedByString:@" & "],
                         MISMATCH_PENALTY];
                        
                        break;
                    }else{
                        //NSLog(@"MATCHED");
                        bNotMatch = NO;
                        card.unplayable = YES;
                        for (Card *otherCard in otherCards) {
                            otherCard.unplayable = YES;
                        }
                        self.score += matchScore * MATCH_BONUS;
                        self.action =
                        [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, [otherContents componentsJoinedByString:@" & "], matchScore * MATCH_BONUS];
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
}



@end
