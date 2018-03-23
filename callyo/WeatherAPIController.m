//
//  WeatherAPIController.m
//  callyo
//
//  Created by Justin Garcia on 3/22/18.
//  Copyright © 2018 Justin Garcia. All rights reserved.
//

#import "WeatherAPIController.h"

#import <Foundation/Foundation.h>

#import "City.h"
#import "Forecast.h"
#import "JSONParser.h"

const NSString *APIKey = @"2236a2b253d7435308f13dca89bf183f";

@implementation WeatherAPIController
+ (void)fetchForecastsForCity:(City *)city
            completionHandler:(void (^)(NSArray<Forecast *> *forecasts))completionHandler
                 errorHandler:(void (^)(NSError *error))errorHandler {
    NSString *urlEncodedCityName = [city.name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *urlString = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/forecast?q=%@&appid=%@", urlEncodedCityName, APIKey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            errorHandler(error);
        } else {
            completionHandler([JSONParser forecastsForJSONData:data]);
        }
    }];
    [task resume];
}
@end
