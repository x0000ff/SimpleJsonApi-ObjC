//
//  Rate.h
//  SimpleJsonApi
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import <Foundation/Foundation.h>

//##############################################################################
@interface Rate : NSObject

//##############################################################################
@property (strong, nonatomic) NSString * rId;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSNumber * rate;
@property (strong, nonatomic) NSDate   * date;

//##############################################################################
- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

//##############################################################################
@end
//##############################################################################
