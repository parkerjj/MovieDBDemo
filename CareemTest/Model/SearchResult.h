//
//  SearchResult.h
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import <Foundation/Foundation.h>
@class MovieModel;

@interface SearchResult : NSObject

@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSNumber *total_pages;
@property (nonatomic, strong) NSNumber *total_results;
@property (nonatomic, strong) NSArray<MovieModel*> *results;
@property (nonatomic, strong) NSNumber *code;



/**
 Instance Object from a NSDictonary

 @param otherDictionary Dictonary
 @return InstanceType
 */
- (instancetype)initWithDictionary:(NSDictionary*)otherDictionary;


@end
