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
#import "JZJWebViewController.h"
#import "UIScrollView+BottomRefreshControl.h"
#import "JZJRequestCenter.h"
@interface JZJFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray* allBooks;
@property (nonatomic,strong) NSURLSessionDataTask* task;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSString* httpUrl;
@property (nonatomic,strong) NSString* httpArg;
@property (nonatomic,strong) JZJNavigationItem* itemView;
@property (nonatomic,strong) NSString* cityName;
@property (nonatomic,assign) int page;

@end


@implementation JZJFirstViewController
-(NSMutableArray *)allBooks
{
    if (!_allBooks)
    {
        _allBooks=[@[]mutableCopy];
    }
    return _allBooks;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"JZJTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight=300;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    [self loadNewBooksWithCityName:nil];
    [self setupRefreshControl];
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
    
    NSMutableString *ms = [[NSMutableString alloc] initWithString:self.itemView.searchTextField.text];
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
        self.cityName=ms;
        [self loadNewBooksWithCityName:self.cityName];
        [self.tableView setContentOffset:CGPointZero animated:NO];
    }
}

#pragma  mark - 请求JSON数据
/*第一次加载界面*/
- (void)loadNewBooksWithCityName:(NSString*)cityName
{
    self.page=1;
    [self sendRequestToServerWithCityName:cityName andPage:self.page];
}

- (void)loadMoreBooks
{
    self.page++;
    [self sendRequestToServerWithCityName:self.cityName andPage:self.page];
}

- (void)sendRequestToServerWithCityName:(NSString*)cityName andPage:(int)page
{
    self.httpArg =[NSString stringWithFormat:@"query=%@&page=%d",cityName?cityName:@"%22%22",page];
    [self requestWithHttpArg:self.httpArg];
 
}

-(void)requestWithHttpArg: (NSString*)HttpArg  {
    NSString* httpUrl = @"http://apis.baidu.com/qunartravel/travellist/travellist";
//    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
//    NSURL *url = [NSURL URLWithString: urlStr];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
//    [request setHTTPMethod: @"GET"];
//    [request addValue: @"5a9455242f3f74e42f972f2f9323e33a" forHTTPHeaderField: @"apikey"];
//    NSLog(@"%@",request);
//    self.task=[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error)
//        {
//            NSLog(@"HttpError:%@",error.userInfo);
//            [self.tableView.bottomRefreshControl endRefreshing];
//        }
//        else
//        {
//            NSInteger responseCode=[(NSHTTPURLResponse*)response statusCode];
//            if (responseCode==200)
//            {
//                if (self.page==1)
//                {
//                    [self.allBooks removeAllObjects];
//                }
//                [self.allBooks addObjectsFromArray:[JZJDataManager getBooksFromData:data]];
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.tableView reloadData];
//                    [self.tableView.bottomRefreshControl endRefreshing];
//                });
//            }
//        }
//    }];
//    [self.task resume];
    [JZJRequestCenter tableView:self.tableView requestHttpUrl:httpUrl withHttpArg:HttpArg onPage:self.page forMutableArray:self.allBooks];
}

#pragma mark - 下拉刷新
- (void)setupRefreshControl
{
    UIRefreshControl* refreshControl=[[UIRefreshControl alloc]init];
    refreshControl.attributedTitle=[[NSAttributedString alloc]initWithString:@"正在加载更多……"];
    refreshControl.triggerVerticalOffset=50;
    [refreshControl addTarget:self action:@selector(loadMoreBooks) forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl=refreshControl;
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
    JZJWebViewController* webView=[[JZJWebViewController alloc]init];
    webView.book=self.allBooks[indexPath.row];
    [self.navigationController pushViewController:webView animated:YES];
}

@end
