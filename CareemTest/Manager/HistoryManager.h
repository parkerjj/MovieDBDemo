//
//  HistoryManager.h
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import <Foundation/Foundation.h>

@interface HistoryManager : NSObject


/**
 Get the singleton
 
 @return Singleton
 */
+ (HistoryManager * _Nonnull)defaultManager;



/**
 Get History of Search

 @return NSArray of History
 */
+ (NSArray <NSString*>*_Nonnull)historyOfSearch;



/**
 Add new Query into history

 @param query Query
 */
+ (void)addToHistoryOfSearchWithQuery:(NSString*)query;



@end
