//
//  MovieModel.m
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import "MovieModel.h"

#define kPosterThumbnailURL @"http://image.tmdb.org/t/p/w92/%@"
#define kPosterFullURL @"http://image.tmdb.org/t/p/w185/%@"

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

    }else if ([key isEqualToString:@"poster_path"]){
        self.posterPath = [value copy];
    }else if ([key isEqualToString:@"release_date"]){
        self.releaseDate = [value copy];
    }
}


- (NSString*)getPosterThumbnailURLString{
    if (self.posterPath == nil || self.posterPath.length == 0) {
        return nil;
    }
    
    return [[NSString stringWithFormat:kPosterThumbnailURL,self.posterPath] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString*)getPosterURLString{
    if (self.posterPath == nil || self.posterPath.length == 0) {
        return nil;
    }
    
    return [[NSString stringWithFormat:kPosterFullURL,self.posterPath] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}


@end
