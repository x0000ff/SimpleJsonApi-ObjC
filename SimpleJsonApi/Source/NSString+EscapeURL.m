//
//  NSString+EscapeURL.m
//  SimpleJsonApi
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import "NSString+EscapeURL.h"

//##############################################################################
@implementation NSString (EscapeURL)

//##############################################################################
- (NSString *) escapeForURL {

    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

//##############################################################################
@end
//##############################################################################
