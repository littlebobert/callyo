//
//  Forecast.m
//  callyo
//
//  Created by Justin Garcia on 3/22/18.
//  Copyright © 2018 Justin Garcia. All rights reserved.
//

#import "Forecast.h"

float fahrenheitFromKelvin(float temperatureInKelvin) {
    return temperatureInKelvin * 9.0 / 5.0 - 459.67;
}

@implementation Forecast
+ (Forecast *)forecast {
    return [[Forecast alloc] init];
}

- (float)highInFarenheit {
    return fahrenheitFromKelvin(self.highInKelvin);
}

- (float)lowInFarenheit {
    return fahrenheitFromKelvin(self.lowInKelvin);
}
@end
