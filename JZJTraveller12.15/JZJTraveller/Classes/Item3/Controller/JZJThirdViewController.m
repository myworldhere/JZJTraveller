//
//  JZJThirdViewController.m
//  UniversalTemplate
//
//  Created by tarena on 15/11/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJThirdViewController.h"
#import "JZJRequestCenter.h"
#import "JZJDataManager.h"
#import "JZJTrainTableViewCell.h"
#import "JZJTrain.h"
#import "JZJSeatsInfoTableViewController.h"
@interface JZJThirdViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSURLSessionDataTask* task;
@property (nonatomic,strong) NSArray* allTrainLists;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *startStationTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;
@end

@implementation JZJThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (IBAction)clickSearchButton:(id)sender
{
  
    [self.tableView reloadData];
    if ([self.startStationTextField.text isEqualToString:@""]||[self.destinationTextField.text isEqualToString:@""])
    {
        return;
    }
    
    NSCharacterSet* startSet=[NSCharacterSet characterSetWithCharactersInString:self.startStationTextField.text];
    NSCharacterSet* DestinationSet=[NSCharacterSet characterSetWithCharactersInString:self.destinationTextField.text];
    
    NSString* startStationStr=[self.startStationTextField.text stringByAddingPercentEncodingWithAllowedCharacters:startSet];
    NSString* destinationStr=[self.destinationTextField.text stringByAddingPercentEncodingWithAllowedCharacters:DestinationSet];
    self.datePicker.minimumDate=[NSDate date];
    NSDate* date=self.datePicker.date;
    
    NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd";
    NSString* dateString = [formatter stringFromDate:date];
    NSString *httpArg =[NSString stringWithFormat:@"version=1.0&from=%@&to=%@&date=%@",startStationStr,destinationStr,dateString];

    [self requestWithHttpArg:httpArg];
    [self.view endEditing:YES];


}





-(void)requestWithHttpArg: (NSString*)HttpArg  {
    NSString *httpUrl = @"http://apis.baidu.com/qunar/qunar_train_service/s2ssearch";
    NSURLRequest* request=[JZJRequestCenter generateRequestByHttpUrl:httpUrl withHttpArg:HttpArg];
    self.task=[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"httpError:%@",error.userInfo);
        }
        else
        {
            NSInteger responseCode=[(NSHTTPURLResponse*)response statusCode];
            if (responseCode==200)
            {
               
               NSDictionary* originalDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                id trainListArray=originalDict[@"data"][@"trainList"];
                if (![trainListArray isKindOfClass:[NSNull class]])
                {
                    self.allTrainLists = [JZJDataManager getTrainList:trainListArray];
                }
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }
    }];
    
    [self.task resume];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allTrainLists.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JZJTrainTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"trainCell" forIndexPath:indexPath];
    
    cell.trainInfo=self.allTrainLists[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JZJTrain* trainInfo=self.allTrainLists[indexPath.row];
    JZJSeatsInfoTableViewController* seatInfoVC=[self.storyboard instantiateViewControllerWithIdentifier:@"seatInfoVC"];
    seatInfoVC.trainInfo=trainInfo;
    [self.navigationController pushViewController:seatInfoVC animated:YES];
}
@end
