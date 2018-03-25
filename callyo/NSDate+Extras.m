//
//  NSDate+Extras.m
//  callyo
//
//  Created by Justin Garcia on 3/25/18.
//  Copyright © 2018 Justin Garcia. All rights reserved.
//

#import "NSDate+Extras.h"

@implementation NSDate (CallyoExtras)
+ (NSDate *)CETomorrow {
    NSDate *now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:now];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    components = [[NSDateComponents alloc] init];
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    NSDate *otherDate = [gregorian dateFromComponents:components];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:1];
    return [gregorian dateByAddingComponents:offsetComponents toDate:otherDate options:0];
}
@end
