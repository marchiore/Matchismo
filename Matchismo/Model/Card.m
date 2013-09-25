//
//  Card.m
//  Matchismo
//
//  Created by Matheus Marchiore on 6/26/13.
//  Copyright (c) 2013 Matheus Marchiore. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards{
    int score = 0;
    
    /* Verificação utilizada para verificar se a carta atual é igual a um
     * array que será enviado como parâmetro;
     */
    for (Card *card in otherCards) {
        NSLog(@"%@ - %@", card.contents, self.contents );
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    return score;

}

@end
