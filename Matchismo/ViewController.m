//
//  ViewController.m
//  Matchismo
//
//  Created by Matheus Marchiore on 6/26/13.
//  Copyright (c) 2013 Matheus Marchiore. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"
#define IMAGEM  @"cardback.png"

@interface ViewController ()
//Setando a variável FlipLabel
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;

//Variável referente ao contador de flips
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) GameResult *gameResult;


@end

@implementation ViewController

-(GameResult *)gameResult{
    if (!_gameResult) {
        _gameResult = [[GameResult alloc] init];
    }
    return _gameResult;
}
-(void)viewDidLoad{

    UIImage *cardBackImage = [UIImage imageNamed:IMAGEM];
    for (UIButton *button in _cardButtons) {
        [button setImage:cardBackImage forState:UIControlStateNormal];
    }
}


-(CardMatchingGame *)game{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]];
    return _game;
}


-(void)setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons;
    [self updateUI];
    
}

- (IBAction)changeGameMatch:(UISegmentedControl*)sender {
    if([[sender titleForSegmentAtIndex:[sender selectedSegmentIndex]] isEqualToString:@"2"]){
        [_game setNumberMatch:2];
    }else{
        [_game setNumberMatch:3];
    }        
}

-(void)updateUI{
    
    UIImage *cardBackImage = [UIImage imageNamed:IMAGEM];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isunplayable;
        cardButton.alpha = card.isunplayable ? 0.3 : 1.0;
        
        if (!card.isFaceUp) {
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.actionLabel.text = [NSString stringWithFormat:@"%@", self.game.action];

}
- (IBAction)deal:(id)sender {
    UIImage *cardBackImage = [UIImage imageNamed:IMAGEM];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        cardButton.selected = NO;
        cardButton.enabled = YES;
        cardButton.alpha = 1.0;
        self.flipCount = 0;
    }
    
    _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: 0"];
    self.actionLabel.text = [NSString stringWithFormat:@""];
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: 0"];
    self.segmentControl.userInteractionEnabled = YES;
    self.segmentControl.selectedSegmentIndex = 0;
}

-(void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
    
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.segmentControl.userInteractionEnabled = NO;
    self.flipCount++;
    self.gameResult.score = self.game.score;
    [self updateUI];
}

@end
