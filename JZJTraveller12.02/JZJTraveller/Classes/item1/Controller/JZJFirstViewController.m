//
//  JZJFirstViewController.m
//  UniversalTemplate
//
//  Created by tarena on 15/11/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJFirstViewController.h"
#import "JZJDataManager.h"
#import "JZJTableViewCell.h"
@interface JZJFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray* allBooks;
@property (nonatomic,strong) NSURLSessionDataTask* task;
@property (nonatomic,strong) UITableView* tableView;
@end


@implementation JZJFirstViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super  viewWillAppear:animated];
    [super viewDidLoad];
    

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *httpUrl = @"http://apis.baidu.com/qunartravel/travellist/travellist";
    NSString *httpArg = @"query=%22%22&page=1";
    [self request: httpUrl withHttpArg: httpArg];
    
    
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"JZJTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight=300;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    [self.view addSubview:self.tableView];
}



-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"5a9455242f3f74e42f972f2f9323e33a" forHTTPHeaderField: @"apikey"];
    
    self.task=[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"HttpError:%@",error.userInfo);
        }
        else
        {
            NSInteger responseCode=[(NSHTTPURLResponse*)response statusCode];
            if (responseCode==200)
            {
                self.allBooks=[JZJDataManager getBooksFromData:data];
                [self.tableView reloadData];
                
            }
        }
    }];
    [self.task resume];
}

#pragma  mark  - Table View Data Source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.allBooks.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JZJTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    JZJBooks* book=self.allBooks[indexPath.row];
    cell.book=book;
    return cell;
}

@end
