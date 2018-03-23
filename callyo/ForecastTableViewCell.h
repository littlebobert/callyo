//
//  CityTableViewCell.h
//  callyo
//
//  Created by Justin Garcia on 3/22/18.
//  Copyright © 2018 Justin Garcia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Forecast;

@interface ForecastTableViewCell : UITableViewCell
- (void)configureWith:(Forecast *)forecast;
@end
