//
//  ViewController.m
//  callyo
//
//  Created by Justin Garcia on 3/22/18.
//  Copyright © 2018 Justin Garcia. All rights reserved.
//

#import "ForecastsViewController.h"

#import <SVProgressHUD/SVProgressHUD.h>

#import "City.h"
#import "Forecast.h"
#import "ForecastTableViewCell.h"
#import "ForecastDetailViewController.h"
#import "NSDate+Extras.h"
#import "WeatherAPIController.h"

static NSArray<NSArray<Forecast *> *> *sectionsForArray(NSArray<Forecast *> *array) {
    NSMutableArray<NSMutableArray<Forecast *> *> *results = [NSMutableArray array];
    static NSDateFormatter *formatter;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MMMM d";
    }
    NSString *previousDay;
    NSMutableArray<Forecast *> *forecastsForPreviousDay = [NSMutableArray array];
    for (Forecast *forecast in array) {
        NSDate *time = forecast.time;
        NSString *day = [formatter stringFromDate:time];
        if (previousDay) {
            if ([previousDay isEqualToString:day]) {
                [forecastsForPreviousDay addObject:forecast];
            } else {
                [results addObject:forecastsForPreviousDay];
                forecastsForPreviousDay = [NSMutableArray arrayWithObject:forecast];
            }
        } else {
            [forecastsForPreviousDay addObject:forecast];
        }
        
        previousDay = day;
    }
    
    if (forecastsForPreviousDay.count > 0) {
        [results addObject:forecastsForPreviousDay];
    }
    
    return results;
}

@interface ForecastsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<NSArray<Forecast *> *> *sections;
@property (strong, nonatomic) City *city;
@end

@implementation ForecastsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.sections = [NSArray array];
    [self.tableView reloadData];
    
    City *defaultCity = [[City alloc] init];
    defaultCity.name = @"New York";
    self.city = defaultCity;
    
    self.title = self.city.name;
    
    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"Fetching weather for %@", self.city.name]];
    [WeatherAPIController fetchForecastsForCity:self.city completionHandler:^(NSArray<Forecast *> *forecasts) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            self.sections = sectionsForArray(forecasts);
            [self.tableView reloadData];
        });
    } errorHandler:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"There was an error fetching weather data. Please try again later."];
            NSLog(@"Encountered an error fetching weather data: %@", error);
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sections objectAtIndex:section].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray<Forecast *> *forecasts = [self.sections objectAtIndex:section];
    if (forecasts.count == 0) {
        return nil;
    }
    static NSDateFormatter *formatter;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MMMM d";
    }
    NSDate *time = [forecasts objectAtIndex:0].time;
    NSDate *currentTime = [NSDate date];
    if ([[NSCalendar currentCalendar] isDate:currentTime inSameDayAsDate:time]) {
        return @"Today";
    }
    NSDate *tomorrow = [NSDate CETomorrow];
    if ([[NSCalendar currentCalendar] isDate:tomorrow inSameDayAsDate:time]) {
        return @"Tomorrow";
    }
    return [formatter stringFromDate:time];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ForecastTableViewCell" forIndexPath:indexPath];
    NSArray<Forecast *> *forecasts = [self.sections objectAtIndex:indexPath.section];
    Forecast *forecast = [forecasts objectAtIndex:indexPath.row];
    [cell configureWith:forecast];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"ShowForecastDetail" sender:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowForecastDetail"]) {
        if (![sender isKindOfClass:[NSIndexPath class]]) {
            return;
        }
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        NSArray<Forecast *> *forecasts = self.sections[indexPath.section];
        Forecast *forecast = forecasts[indexPath.row];
        if (![segue.destinationViewController isKindOfClass:[ForecastDetailViewController class]]) {
            return;
        }
        ForecastDetailViewController *forecastDetailViewController = (ForecastDetailViewController *)segue.destinationViewController;
        forecastDetailViewController.forecast = forecast;
    }
}

@end
