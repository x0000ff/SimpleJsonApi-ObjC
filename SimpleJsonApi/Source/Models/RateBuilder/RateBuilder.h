//
//  RateBuilder.h
//  SimpleJsonApi
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import <Foundation/Foundation.h>
#import "Rate.h"

//##############################################################################
@interface RateBuilder : NSObject

//##############################################################################
- (NSArray<Rate *> *) parseRateFromJSONResponse:(NSString *)jsonResponse;
- (NSArray<Rate *> *) parseRateFromJSON:(NSDictionary *)json;

//##############################################################################
@end
//##############################################################################
