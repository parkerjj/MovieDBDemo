//
//  SearchResult.m
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import "SearchResult.h"
#import "MovieModel.h"

@implementation SearchResult


- (instancetype)initWithDictionary:(NSDictionary*)otherDictionary{
    self = [super init];
    if (self) {
        
        // Using setValuesForKeysWithDictionary has so many issues.
        // Example, if cannot find property in object of any key in dictionary, it will crash.
        // If using open source extension etc. JSONModel is safer and easier.
        // But just cuz this is only a demo application for test my coding not the opensource project, so i didn't import JSONModel.
        [self setValuesForKeysWithDictionary:otherDictionary];
        
        // Regenerator Result Array
        NSArray *dicArray = self.results;
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:dicArray.count];
        for (NSDictionary *dic in dicArray) {
            MovieModel *model = [[MovieModel alloc] initWithDictionary:dic];
            [mArray addObject:model];
        }
        self.results = [NSArray arrayWithArray:mArray];
        
        // 200 is HTTP OK flag.
        self.code = @200;
    }
    
    return self;
}

@end
