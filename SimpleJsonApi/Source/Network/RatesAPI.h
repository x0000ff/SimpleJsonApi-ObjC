//
//  RatesAPI.h
//  SimpleJsonApi
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import <Foundation/Foundation.h>

#import "Rate.h"

//##############################################################################
@interface RatesAPI : NSObject

//##############################################################################
typedef void (^GetRatesSuccessCallback) (NSArray<Rate *> * rates);
typedef void (^FailureCallback) (NSError * error);

//##############################################################################
- (void) getRates:(GetRatesSuccessCallback)success failure:(FailureCallback)failure;

//##############################################################################
@end
//##############################################################################
