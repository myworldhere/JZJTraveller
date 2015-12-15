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
@property (nonatomic,strong) NSMutableArray* allTrainLists;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation JZJThirdViewController

-(NSMutableArray *)allTrainLists
{
    if (!_allTrainLists)
    {
        _allTrainLists=[@[]mutableCopy];
    }
    return _allTrainLists;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
   
    NSString *httpArg = @"version=1.0&from=%E5%8C%97%E4%BA%AC&to=%E4%B8%8A%E6%B5%B7&date=2015-12-25";
    [self requestWithHttpArg:httpArg];

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
                NSDictionary* trainListArray=originalDict[@"data"][@"trainList"];
                [self.allTrainLists addObjectsFromArray:[JZJDataManager getTrainList:trainListArray]];
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
   
    
}
@end
