//
//  MovieModel.h
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject


@property (strong, nonatomic) NSNumber *adult;
@property (strong, nonatomic) NSNumber *popularity;
@property (strong, nonatomic) NSNumber *voteCount;
@property (strong, nonatomic) NSNumber *video;
@property (strong, nonatomic) NSNumber *voteAverage;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *originalTitle;
@property (strong, nonatomic) NSString *originalLanguage;
@property (strong, nonatomic) NSString *posterPath;
@property (strong, nonatomic) NSString *backdropPath;
@property (strong, nonatomic) NSString *overview;
@property (strong, nonatomic) NSString *releaseDate;
@property (strong, nonatomic) NSArray *genreIds;

- (instancetype)initWithDictionary:(NSDictionary*)otherDictionary;

@end
