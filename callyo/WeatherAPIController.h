//
//  WeatherAPIController.h
//  callyo
//
//  Created by Justin Garcia on 3/22/18.
//  Copyright © 2018 Justin Garcia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class City;
@class Forecast;

@interface WeatherAPIController : NSObject
+ (void)fetchForecastsForCity:(City *)city
            completionHandler:(void (^)(NSArray<Forecast *> *forecasts))completionHandler
                 errorHandler:(void (^)(NSError *error))errorHandler;
@end
