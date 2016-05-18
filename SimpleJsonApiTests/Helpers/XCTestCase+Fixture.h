//
//  XCTestCase+Fixture.h
//  SimpleJsonApi
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import <XCTest/XCTest.h>

//##############################################################################
@interface XCTestCase (Fixture)

//##############################################################################
- (NSString *) fixtureWithFileName:(NSString *)fileName extension:(NSString *)extension;

//##############################################################################
@end
//##############################################################################