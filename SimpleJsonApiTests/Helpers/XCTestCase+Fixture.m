//
//  XCTestCase+Fixture.m
//  SimpleJsonApi
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import "XCTestCase+Fixture.h"

//##############################################################################
@implementation XCTestCase (Fixture)

//##############################################################################
- (NSString *) fixtureWithFileName:(NSString *)fileName extension:(NSString *)extension {

    NSString * path = [[NSBundle bundleForClass:self.class] pathForResource:fileName
                                                                     ofType:extension];

    NSError * error = nil;
    NSString * fixtureString = [[NSString alloc] initWithContentsOfFile:path
                                                               encoding:NSUTF8StringEncoding
                                                                  error:&error];
    if (error) {
        NSLog(@"Error while reading fuxture \"%@.%@\": %@", fileName, extension, error.localizedDescription);
    }

    return fixtureString;
}

//##############################################################################
@end
//##############################################################################
