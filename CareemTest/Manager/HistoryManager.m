//
//  HistoryManager.m
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import "HistoryManager.h"

#define kSearchHistoryFileName @"SearchHistory.dat"
#define kMaxSearchHistoryCount 10

@interface HistoryManager(){
}

@property (nonatomic,strong) NSMutableArray *searchArray;
@end

@implementation HistoryManager
static HistoryManager *_manager = nil;
+ (HistoryManager *)defaultManager{
    @synchronized (self){
        if (_manager == nil) {
            _manager = [[HistoryManager alloc] init];
        }
    }
    return _manager;
}

- (id) init{
    self = [super init];
    if (self) {
        NSString *historyFilePath = [[HistoryManager documentsPath] stringByAppendingString:kSearchHistoryFileName];
        self.searchArray = [NSMutableArray arrayWithContentsOfFile:historyFilePath];
        if (self.searchArray == nil) {
            self.searchArray = [NSMutableArray arrayWithCapacity:10];
        }
    }
    return self;
}


+ (NSString*)documentsPath{
    return [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
}


+ (NSArray <NSString*>*)historyOfSearch{
    return [NSArray arrayWithArray:[[HistoryManager defaultManager] searchArray]];
}

+ (void)addToHistoryOfSearchWithQuery:(NSString*)query{
    NSMutableArray *mArray = [[HistoryManager defaultManager] searchArray];
    NSInteger duplicatedIndex = -1;
    for (NSString *str in mArray) {
        if ([str isEqualToString:query]) {
            // Got duplicate
            duplicatedIndex = [mArray indexOfObject:str];
            break;
        }
    }
    
    if (duplicatedIndex >= 0) {
        // Remove the duplicate
        [mArray removeObjectAtIndex:duplicatedIndex];
    }
    
    // Insert new Query to front
    [mArray insertObject:query atIndex:0];

    if (mArray.count > kMaxSearchHistoryCount) {
        [mArray removeLastObject];
    }
    
    // Save Array to file
    NSString *historyFilePath = [[HistoryManager documentsPath] stringByAppendingString:kSearchHistoryFileName];
    [mArray writeToFile:historyFilePath atomically:YES];
}

@end
