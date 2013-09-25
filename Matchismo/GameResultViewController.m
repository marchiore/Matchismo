//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Matheus Marchiore on 9/22/13.
//  Copyright (c) 2013 Matheus Marchiore. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()

@end

@implementation GameResultViewController

- (void)updateUI{
    NSString *displayText = @"";
    for (GameResult *result in [GameResult allGameResults]) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n", result.score, result.end, round(result.duration)];
    }
    self.display.text = displayText;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
