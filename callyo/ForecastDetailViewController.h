//
//  ForecastDetailViewController.h
//  callyo
//
//  Created by Justin Garcia on 3/25/18.
//  Copyright © 2018 Justin Garcia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Forecast;

@interface ForecastDetailViewController : UIViewController
@property (strong, nonatomic) Forecast *forecast;
@end
