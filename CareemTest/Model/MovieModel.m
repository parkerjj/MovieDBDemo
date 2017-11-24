//
//  MovieModel.m
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import "MovieModel.h"

@implementation MovieModel

- (instancetype)initWithDictionary:(NSDictionary*)otherDictionary{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:otherDictionary];
    }
    
    return self;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {

    }
}


@end
