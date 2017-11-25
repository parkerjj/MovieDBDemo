//
//  CareemTestTests.m
//  CareemTestTests
//
//  Created by Peigen.Liu on 2017/11/24.
//

#import <XCTest/XCTest.h>

#import "NetworkManager.h"
#import "SearchResult.h"


@interface CareemTestTests : XCTestCase

@end

@implementation CareemTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


- (void)testSearch{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Test Search"];
    
    [NetworkManager getMovieResultWithQuery:@"Bond" WithPage:1 OnGetResultBack:^(NSInteger returnCode, SearchResult * _Nullable result) {
        XCTAssert(result.code.integerValue == 200 && result.results.count > 0, @"Query working");
        [expectation fulfill];
    }];
                  
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
    }];
}

- (void)testJSON{
    NSString *vaildStr = @"{\"page\":1,\"total_results\":98,\"total_pages\":5,\"results\":[{\"vote_count\":2284,\"id\":268,\"video\":false,\"vote_average\":7,\"title\":\"Batman\",\"popularity\":15.726497,\"poster_path\":\"/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg\",\"original_language\":\"en\",\"original_title\":\"Batman\",\"genre_ids\":[14,28],\"backdrop_path\":\"/2blmxp2pr4BhwQr74AdCfwgfMOb.jpg\",\"adult\":false,\"overview\":\"The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker, who has seized control of Gotham's underworld.\",\"release_date\":\"1989-06-23\"}]}";
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:[vaildStr dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
    
    SearchResult *result = [[SearchResult alloc] initWithDictionary:jsonDic];
    XCTAssertNotNil(result);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
