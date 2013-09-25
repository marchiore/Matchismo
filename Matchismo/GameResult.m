//
//  GameResult.m
//  Matchismo
//
//  Created by Matheus Marchiore on 9/22/13.
//  Copyright (c) 2013 Matheus Marchiore. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()

@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;

@end

@implementation GameResult

#define ALL_RESULTS_KEY @"gameResult_all"
#define START_KEY @"startDate"
#define SCORE_KEY @"scoreDate"
#define END_KEY @"endDate"


+(NSArray *)allGameResults{
    NSMutableArray *allGameResults = [[NSMutableArray alloc]init];
    
    for (id pList in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:pList];
        [allGameResults addObject:result];
    }
    return allGameResults;

}

-(id) initFromPropertyList:(id)pList{
    self = [self init];
    if(self){
        if([pList isKindOfClass:[NSDictionary class]]){
            NSDictionary *resultDictionary = (NSDictionary *)pList;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
        }
    }
    return self;
}

-(void) synchronize{
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    
    if (!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc]init];
    
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(id) asPropertyList{
    return @{ START_KEY : self.start, SCORE_KEY : @(self.score) , END_KEY : self.end };
}

- (id) init{
    self = [super init];
    if (self) {
        _start = [NSDate date];
        _end = _start;
    }
    
    return self;
    
}

-(NSTimeInterval) duration{
    return [self.end timeIntervalSinceDate:self.start];
}

-(void)setScore:(int)score{

    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

@end
