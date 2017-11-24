//
//  NetworkManager.h
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import <Foundation/Foundation.h>
#import "SearchResult.h"

@interface NetworkManager : NSObject




/**
 Get the singleton

 @return Singleton
 */
+ (NetworkManager * _Nonnull)defaultManager;


- (NSURLSessionTask * _Nullable)getMovieResultWithQuery:(NSString * _Nonnull)query WithPage:(NSInteger)page OnGetResultBack:(void (^_Nonnull)(NSInteger returnCode, SearchResult * _Nullable result))resultBackResult;

@end
