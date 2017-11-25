//
//  NetworkManager.m
//  CareemTest
//
//  This is singleton class for the network model
//
//  Created by Peigen.Liu on 2017/11/25.
//

#import "NetworkManager.h"



@implementation NetworkManager
static NetworkManager *_manager = nil;
+ (NetworkManager *)defaultManager{
    @synchronized (self){
        if (_manager == nil) {
            _manager = [[NetworkManager alloc] init];
        }
    }
    return _manager;
}

- (id) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}


+ (NSURLSessionTask * _Nullable)getMovieResultWithQuery:(NSString * _Nonnull)query WithPage:(NSInteger)page OnGetResultBack:(void (^_Nonnull)(NSInteger returnCode, SearchResult* _Nullable result))resultBackResult {

    if (query == nil || query.length == 0) {
        return nil;
    }
    
    // =============================================================
    // Send Network Request
    // =============================================================
    // Create Request URL
    NSString *requestURL = [[NSString stringWithFormat:kNetworkManagerMovieSearchURL,query,page] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:requestURL];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url
                                                                   cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                               timeoutInterval:kNetworkManagerTimeOut];
    
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil){
#if DEBUG
            NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *jsonBackDebug = @{@"RequestAPI" :urlRequest.URL.relativeString,
                                            @"JsonData" : jsonStr == nil ? @"" : jsonStr,
                                            @"DataLength" : jsonStr == nil ? @0 : @(jsonStr.length)};
            NSLog(@"JSON Back:\n%@",jsonBackDebug);
#endif
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *error;
                NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:&error];
                SearchResult *result;
                if (error == nil) {
                    result = [[SearchResult alloc] initWithDictionary:jsonDic];
                }else{
                    SearchResult *result = [[SearchResult alloc] init];
                    result.code = [NSNumber numberWithInteger:error.code];
                }

                resultBackResult([result.code integerValue] , result);

            });
            
            
        }else{
#if DEBUG
            NSLog(@"Network Error:%@",error);
#endif
            SearchResult *result = [[SearchResult alloc] init];
            result.code = [NSNumber numberWithInteger:error.code];
            resultBackResult([result.code integerValue] , result);
        }
    }];
    
    [task resume];
    
    return task;
    
    return nil;
}




@end
