//
//  CareemTestTests.m
//  CareemTestTests
//
//  Created by Peigen.Liu on 2017/11/24.
//

#import <XCTest/XCTest.h>

#import "NetworkManager.h"

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
    
    [[NetworkManager defaultManager] getMovieResultWithQuery:@"Bond" WithPage:1 OnGetResultBack:^(NSInteger returnCode, SearchResult * _Nullable result) {
        XCTAssertFalse(result.code.integerValue == 200 && result.results.count > 0, @"Query working");
        [expectation fulfill];
    }];
                  
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
