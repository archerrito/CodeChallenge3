//
//  StationsListViewController.m
//  CodeChallenge3
//
//  Created by Vik Denic on 10/16/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "StationsListViewController.h"
#import "Location.h"
#import "MapViewController.h"
#define kURL @"http:www.bayareabikeshare.com/stations/json"
#import <MapKit/MapKit.h>

@interface StationsListViewController () <UITabBarDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property NSMutableArray *bikeArray;
@property MKPointAnnotation *busStopAnnotation;


@end

@implementation StationsListViewController

//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    NSString *searchTerm = textField.text;
//    [self loadAPIDataFromSearchTerm:searchTerm];
//    return YES;
//}

//-(void)loadAPIDataFromSearchTerm:(NSString *)searchTerm
//{
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bikeArray = [NSMutableArray array];


    NSURL *url = [NSURL URLWithString:kURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        ///just making sure error object exists
        if (connectionError)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error" message:connectionError.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Dayuuum" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            NSDictionary *bikesDictionary = [[NSDictionary alloc] init];
            bikesDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *bikeJsonArray = [[NSArray alloc] init];
            bikeJsonArray = [bikesDictionary objectForKey:@"stationBeanList"];
//            self.bikeArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            for (NSDictionary *dict in bikeJsonArray)
            {
                Location *location = [[Location alloc] initWithDictionary:dict];
                [self.bikeArray addObject:location];
                
            }

            [self.tableView reloadData];
        }

    }];

}


#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bikeArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Location *l = self.bikeArray[indexPath.row];

    cell.textLabel.text = l.stationName;

    NSString *string = [NSString stringWithFormat:@"%d", l.availableBikes];
    cell.detailTextLabel.text = string;

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    MapViewController *MVC = segue.destinationViewController;
    NSInteger rowNumber = [self.tableView indexPathForSelectedRow].row;
    Location *moveInfo = [self.bikeArray objectAtIndex:rowNumber];
    MVC.location = moveInfo;
    
}

@end
