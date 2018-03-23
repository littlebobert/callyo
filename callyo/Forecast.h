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
@property (nonatomic) CGFloat high;
@property (nonatomic) CGFloat low;
@property (nonatomic) CGFloat humidity;
@end
