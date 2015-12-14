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
#import "MBProgressHUD+KR.h"
#import "JZJSecondViewController.h"
#import "UIBarButtonItem+JZJSearchItem.h"
@interface JZJFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray* allBooks;
@property (nonatomic,strong) NSURLSessionDataTask* task;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSString* httpUrl;
@property (nonatomic,strong) NSString* httpArg;
@property (nonatomic,strong) JZJNavigationItem* leftItemView;
@property (nonatomic,strong) JZJNavigationItem* rightItemView;
@property (nonatomic,strong) NSString* cityName;
@property (nonatomic,assign) int page;
@property (nonatomic,strong) UITapGestureRecognizer* tapGR;

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
    
    self.tapGR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGR:)];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowed:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHided:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardShowed:(NSNotification*)notification
{
    
    [self.tableView addGestureRecognizer:self.tapGR];
    
}

- (void)keyboardHided:(NSNotification*)notification
{
    [self.tableView removeGestureRecognizer:self.tapGR];
}


-(void)tapGR:(UITapGestureRecognizer*)gr
{
    [self.leftItemView.searchTextField resignFirstResponder];
    [self.rightItemView.searchTextField resignFirstResponder];
}

#pragma mark - navigationItem
-(void)setupNavigationItem
{
    JZJNavigationItem* leftItemView=[JZJNavigationItem navigationBarView];
    
    UIBarButtonItem* leftItem=[UIBarButtonItem generaterBarButtonItemWithCustomView:leftItemView Target:self buttonAction:@selector(searchBlogs) andTextfieldAction:@selector(beginToInput)];
    self.navigationItem.leftBarButtonItem=leftItem;
    self.leftItemView=leftItemView;
    
    
    JZJNavigationItem* rightItemView=[JZJNavigationItem navigationBarView];
    UIBarButtonItem* rightItem=[UIBarButtonItem generaterBarButtonItemWithCustomView:rightItemView Target:self buttonAction:@selector(searchResorts) andTextfieldAction:nil];
    self.navigationItem.rightBarButtonItem=rightItem;
    self.rightItemView=rightItemView;
    rightItemView.searchTextField.placeholder=@"泰山";
    
}

-(void)beginToInput
{
    [MBProgressHUD showError:@"请输入城市名, 如 西安或 xian"];
    
}

#pragma mark -搜索城市
-(void)searchBlogs
{
    [self.leftItemView.searchTextField resignFirstResponder];
    self.cityName=[self MandarinTransformToLatin:self.leftItemView.searchTextField];
    [self loadNewBooksWithCityName:self.cityName];
    [self.tableView setContentOffset:CGPointZero animated:NO];
}

#pragma  mark -搜索热门景点
-(void)searchResorts
{
    [self.rightItemView.searchTextField resignFirstResponder];

    UIStoryboard* secondStroyboard=[UIStoryboard storyboardWithName:@"JZJSecondViewController" bundle:nil];
    JZJSecondViewController* secondVC=[secondStroyboard instantiateInitialViewController];
    secondVC.resortName=[self MandarinTransformToLatin:self.rightItemView.searchTextField];
    secondVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:secondVC animated:YES];
    
}

#pragma mark - 汉字转拼音
- (NSString*)MandarinTransformToLatin:(UITextField*)sender
{
    NSMutableString *ms = [[NSMutableString alloc] initWithString:sender.text];
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        //        MYLog(@"Pingying: %@", ms); // wǒ shì zhōng guó rén
    }
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        //        MYLog(@"Pingying: %@", ms); // wo shi zhong guo ren
        if (ms.length)
        {
            NSRange range=[ms rangeOfString:ms];
            [ms replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:range];
        }
    }
    return [ms copy];
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
    self.httpArg =[NSString stringWithFormat:@"query=%@&page=%d",cityName?cityName:@"%22",page];
    [self requestWithHttpArg:self.httpArg];
 
}

-(void)requestWithHttpArg: (NSString*)HttpArg  {
    NSString* httpUrl = @"http://apis.baidu.com/qunartravel/travellist/travellist";
    NSURLRequest* request=[JZJRequestCenter generateRequestByHttpUrl:httpUrl withHttpArg:HttpArg];
   
    self.task=[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            MYLog(@"HttpError:%@",error.userInfo);
            [self.tableView.bottomRefreshControl endRefreshing];
        }
        else
        {
            NSInteger responseCode=[(NSHTTPURLResponse*)response statusCode];
            if (responseCode==200)
            {
                if (self.page==1)
                {
                    [self.allBooks removeAllObjects];
                }
                NSDictionary* originaldict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSArray* originalArray=originaldict[@"data"][@"books"];
                
                [self.allBooks addObjectsFromArray:[JZJDataManager getBooksFromData:originalArray]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    [self.tableView.bottomRefreshControl endRefreshing];
                });
            }
        }
    }];
    [self.task resume];
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
