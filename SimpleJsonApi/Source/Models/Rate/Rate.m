//
//  Rate.m
//  SimpleJsonApi
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import "Rate.h"

//##############################################################################
@implementation Rate

//##############################################################################
- (instancetype) initWithDictionary:(NSDictionary *)dictionary {

    if (self = [super init]) {

        self.rId = dictionary[@"id"];
        self.name = dictionary[@"Name"];

        self.rate = [[self.class createDefaultFormatter] numberFromString:dictionary[@"Rate"]];

        NSString * dateString =  dictionary[@"Date"];
        NSString * timeString = [dictionary[@"Time"] uppercaseString];

        NSString * dateAndTimeString = [NSString stringWithFormat:@"%@ %@",
                                        dateString ? dateString : @"",
                                        timeString ? timeString : @""
                                       ];

        self.date = [[self.class dateFormatter] dateFromString:dateAndTimeString];
    }

    return self;
}

//##############################################################################
+ (NSNumberFormatter *) createDefaultFormatter {

    NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.decimalSeparator = @".";

    return numberFormatter;

}

//##############################################################################
+ (NSDateFormatter *) dateFormatter {

    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale     = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.timeZone   = [NSTimeZone timeZoneForSecondsFromGMT:0];
    dateFormatter.dateFormat = @"M/dd/yyyy h:mma";

    return dateFormatter;
}

//##############################################################################
- (BOOL)isEqual:(id)object {

    if (![object isKindOfClass:self.class]) {
        return NO;
    }

    Rate * anRate = object;
    if (![self.rId isEqualToString:anRate.rId]) {
        return NO;
    }

    if (![self.name isEqualToString:anRate.name]) {
        return NO;
    }

    if (![self.date isEqualToDate:anRate.date]) {
        return NO;
    }

    if (![self.rate isEqualToNumber:anRate.rate]) {
        return NO;
    }

    return YES;
}

//##############################################################################
@end
//##############################################################################
