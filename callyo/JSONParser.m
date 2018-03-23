//
//  JSONParser.m
//  callyo
//
//  Created by Justin Garcia on 3/22/18.
//  Copyright © 2018 Justin Garcia. All rights reserved.
//

#import "JSONParser.h"

#import "Forecast.h"

@implementation JSONParser
+ (NSArray<Forecast *> *)forecastsForJSONData:(NSData *)data {
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) {
        return nil;
    }
    if (![json isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSDictionary *dictionary = (NSDictionary *)json;
    id list = dictionary[@"list"];
    if (![list isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSArray *array = (NSArray *)list;
    NSMutableArray<Forecast *> *forecasts = [NSMutableArray array];
    for (id element in array) {
        if (![element isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        NSDictionary *forecastDictionary = (NSDictionary *)element;
        Forecast *forecast = [[Forecast alloc] init];
        UIImage *icon;
        NSString *description;
        [self getIcon:&icon andDescription:&description fromForecastDictionary:forecastDictionary];
        forecast.icon = icon;
        forecast.forecastDescription = description;
        forecast.time = [self timeFromForecastDictionary:forecastDictionary];
        float high, low, humidity;
        [self getHigh:&high low:&low andHumidity:&humidity fromForecastDictionary:forecastDictionary];
        forecast.high = high;
        forecast.low = low;
        forecast.humidity = humidity;
        
        [forecasts addObject:forecast];
    }
    return forecasts;
}

+ (void)getIcon:(UIImage **)iconPointer andDescription:(NSString **)descriptionPointer fromForecastDictionary:(NSDictionary *)forecastDictionary {
    id weather = forecastDictionary[@"weather"];
    if (![weather isKindOfClass:[NSArray class]]) {
        return;
    }
    NSArray *weatherArray = (NSArray *)weather;
    if (weatherArray.count == 0) {
        return;
    }
    id first = [weatherArray objectAtIndex:0];
    if (![first isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSDictionary *firstDictionary = (NSDictionary *)first;
    if (iconPointer) {
        *iconPointer = [UIImage imageNamed:firstDictionary[@"icon"]];
    }
    if (descriptionPointer) {
        *descriptionPointer = firstDictionary[@"description"];
    }
}

+ (NSDate *)timeFromForecastDictionary:(NSDictionary *)forecastDictionary {
    NSString *dateString = forecastDictionary[@"dt_txt"];
    static NSDateFormatter *formatter;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    }
    return [formatter dateFromString:dateString];
}

+ (void)getHigh:(float *)highPointer low:(float *)lowPointer andHumidity:(float *)humidityPointer fromForecastDictionary:(NSDictionary *)forecastDictionary {
    id main = forecastDictionary[@"main"];
    if (![main isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSDictionary *mainDictionary = (NSDictionary *)main;
    if (highPointer) {
        id value = mainDictionary[@"temp_max"];
        if (![value isKindOfClass:[NSNumber class]]) {
            return;
        }
        *highPointer = [((NSNumber *)value) floatValue];
    }
    if (lowPointer) {
        id value = mainDictionary[@"temp_min"];
        if (![value isKindOfClass:[NSNumber class]]) {
            return;
        }
        *lowPointer = [((NSNumber *)value) floatValue];
    }
    if (humidityPointer) {
        id value = mainDictionary[@"humidity"];
        if (![value isKindOfClass:[NSNumber class]]) {
            return;
        }
        *humidityPointer = [((NSNumber *)value) floatValue];
    }
}
@end
