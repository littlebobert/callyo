//
//  ForecastDetailViewController.m
//  callyo
//
//  Created by Justin Garcia on 3/25/18.
//  Copyright © 2018 Justin Garcia. All rights reserved.
//

#import "ForecastDetailViewController.h"

#import "Forecast.h"

@interface ForecastDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ForecastDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *titleDateFormatter = [[NSDateFormatter alloc] init];
    titleDateFormatter.dateFormat = @"EEEE";
    self.title = [titleDateFormatter stringFromDate:self.forecast.time];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@""];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"EEEE, MMMM d, yyyy";
    NSString *dateString = [dateFormatter stringFromDate:self.forecast.time];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"h:mm:ss a";
    NSString *timeString = [timeFormatter stringFromDate:self.forecast.time];
    NSString *dateAndTimeString = [NSString stringWithFormat:@"%@ at %@", dateString, timeString];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:dateAndTimeString]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"High: "]];
    NSString *highString = [NSString stringWithFormat:@"%d°F", (int)self.forecast.highInFarenheit];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:highString]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Low: "]];
    NSString *lowString = [NSString stringWithFormat:@"%d°F", (int)self.forecast.lowInFarenheit];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:lowString]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Humidity: "]];
    NSString *humidityString = [NSString stringWithFormat:@"%d%%", (int)self.forecast.humidity];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:humidityString]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6.0;
    
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:14.0],
                                  NSParagraphStyleAttributeName : paragraphStyle };
    
    [attributedText setAttributes:attributes range:NSMakeRange(0, [attributedText length])];
    
    NSTextAttachment *iconAttachment = [[NSTextAttachment alloc] init];
    iconAttachment.image = self.forecast.icon;
    NSAttributedString *iconAttachmentString = [NSAttributedString attributedStringWithAttachment:iconAttachment];
    [attributedText insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n"] atIndex:0];
    [attributedText insertAttributedString:iconAttachmentString atIndex:0];
    
    self.textView.attributedText = attributedText;
    
    self.textView.textContainerInset = UIEdgeInsetsMake(0, 20, 0, 20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
