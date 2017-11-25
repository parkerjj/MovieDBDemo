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



/**
 Get Movie Result With Query

 @param query Query
 @param page PageNumber
 @param resultBackResult You will get result and return code in this block.
        result will be nil if got error on anything.
 @return Return Session if you want to cancel it.
 */
+ (NSURLSessionTask * _Nullable)getMovieResultWithQuery:(NSString * _Nonnull)query
                                               WithPage:(NSInteger)page
                                        OnGetResultBack:(void (^_Nonnull)(NSInteger returnCode, SearchResult * _Nullable result))resultBackResult;





@end
