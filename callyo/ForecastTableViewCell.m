//
//  CityTableViewCell.m
//  callyo
//
//  Created by Justin Garcia on 3/22/18.
//  Copyright © 2018 Justin Garcia. All rights reserved.
//

#import "ForecastTableViewCell.h"

#import "Forecast.h"

static float fahrenheitFromKelvin(float temperatureInKelvin) {
    return temperatureInKelvin * 9.0 / 5.0 - 459.67;
}

@interface ForecastTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *forecastIcon;
@property (weak, nonatomic) IBOutlet UILabel *dateAndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *highLowLabel;
@end

@implementation ForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIFont *monospacedFont = [UIFont monospacedDigitSystemFontOfSize:14.0 weight:UIFontWeightMedium];
    self.dateAndTimeLabel.font = monospacedFont;
    self.descriptionLabel.font = monospacedFont;
    self.highLowLabel.font = monospacedFont;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureWith:(Forecast *)forecast {
    self.forecastIcon.image = forecast.icon;
    static NSDateFormatter *formatter;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"hh:mm a";
    }
    self.dateAndTimeLabel.text = [formatter stringFromDate:forecast.time];
    self.descriptionLabel.text = forecast.forecastDescription;
    int high = fahrenheitFromKelvin(forecast.high);
    int low = fahrenheitFromKelvin(forecast.low);
    self.highLowLabel.text = [NSString stringWithFormat:@"%d°/%d°", high, low];
}

@end
