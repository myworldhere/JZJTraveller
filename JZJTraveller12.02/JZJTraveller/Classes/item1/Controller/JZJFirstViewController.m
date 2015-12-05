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
#import "JZJNavigationItem.h"
@interface JZJFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray* allBooks;
@property (nonatomic,strong) NSURLSessionDataTask* task;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSString* cityName;
@property (nonatomic,strong) NSString* httpUrl;
@property (nonatomic,strong) NSString* httpArg;
@property (nonatomic,strong) JZJNavigationItem* itemView;
@end


@implementation JZJFirstViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.httpUrl = @"http://apis.baidu.com/qunartravel/travellist/travellist";
    self.httpArg = @"query=%22%22&page=1";
    [self request:self.httpUrl withHttpArg: self.httpArg];
    
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"JZJTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight=300;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    [self setupNavigationItem];
    [self.view addSubview:self.tableView];
    

}
#pragma mark - navigationItem
-(void)setupNavigationItem
{
    JZJNavigationItem* itemView=[JZJNavigationItem navigationBarView];
    UIBarButtonItem* searchItem=[[UIBarButtonItem alloc]initWithCustomView:itemView];
    self.navigationItem.leftBarButtonItem=searchItem;
    
    [itemView.searchButton addTarget:self action:@selector(searchBlogs) forControlEvents:UIControlEventTouchUpInside];
    [itemView.searchTextField addTarget:self action:@selector(searchBlogs) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.itemView=itemView;
}

-(void)searchBlogs
{
    [self.itemView.searchTextField resignFirstResponder];
    
    self.cityName=self.itemView.searchTextField.text;
    NSMutableString *ms = [[NSMutableString alloc] initWithString:self.cityName];
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
//        NSLog(@"Pingying: %@", ms); // wǒ shì zhōng guó rén
    }
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
//        NSLog(@"Pingying: %@", ms); // wo shi zhong guo ren
        if (ms.length)
        {
            NSRange range=[ms rangeOfString:ms];
            [ms replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:range];
        }
        self.httpArg=[NSString stringWithFormat:@"query=%@&page=1",ms];
        [self request:self.httpUrl withHttpArg:self.httpArg];
    }
}

#pragma  mark - 请求JSON数据
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
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

#pragma  mark -Table View delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


@end
