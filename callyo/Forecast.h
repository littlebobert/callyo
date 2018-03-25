//
//  Forecast.h
//  callyo
//
//  Created by Justin Garcia on 3/22/18.
//  Copyright © 2018 Justin Garcia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Forecast : NSObject
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) NSDate *time;
@property (strong, nonatomic) NSString *forecastDescription;
@property (nonatomic) float highInKelvin;
@property (readonly, nonatomic) float highInFarenheit;
@property (nonatomic) float lowInKelvin;
@property (readonly, nonatomic) float lowInFarenheit;
@property (nonatomic) float humidity;
@end
