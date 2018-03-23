//
//  JSONParser.h
//  callyo
//
//  Created by Justin Garcia on 3/22/18.
//  Copyright © 2018 Justin Garcia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Forecast;

@interface JSONParser : NSObject
+ (NSArray<Forecast *> *)forecastsForJSONData:(NSData *)data;
@end
