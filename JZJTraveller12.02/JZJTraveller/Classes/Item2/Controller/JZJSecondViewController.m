//
//  JZJSecondViewController.m
//  UniversalTemplate
//
//  Created by tarena on 15/11/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJSecondViewController.h"
#import "JZJResort.h"
#import "JZJRequestCenter.h"
#import "JZJDataManager.h"
#import "JZJDetailInformationViewController.h"
#import "JZJTicketInformation.h"
#import "JZJTicketAttention.h"
#import "UIBarButtonItem+JZJSearchItem.h"
#import "JZJNavigationItem.h"
@interface JZJSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSURLSessionDataTask* task;
@property (weak, nonatomic) IBOutlet UILabel *reSortNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (nonatomic,strong) JZJResort* resort;
@property (weak, nonatomic) IBOutlet UIImageView *firstStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *forthStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fifthStarImageView;
@property (weak, nonatomic) IBOutlet UITableView *ticketInfoTableView;
@property (nonatomic,strong) JZJTicketInformation* information;
@property (nonatomic,strong) NSArray* allAttentions;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ticketViewVerticalConstraint;
@property (weak, nonatomic) IBOutlet UITableView *ticketInformationTableView;
@property (nonatomic,strong) JZJNavigationItem* rightItemView;

@end

@implementation JZJSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNewResorts];
    [self setupNavigationItem];
    
}

-(void)setupNavigationItem
{
    JZJNavigationItem* rightItemView=[JZJNavigationItem navigationBarView];
    UIBarButtonItem* rightItem=[UIBarButtonItem generaterBarButtonItemWithCustomView:rightItemView Target:self buttonAction:@selector(searchResorts) andTextfieldAction:nil];
    self.navigationItem.rightBarButtonItem=rightItem;
    self.rightItemView=rightItemView;
    rightItemView.searchTextField.placeholder=@"泰山";
}

#pragma  mark -搜索热门景点
-(void)searchResorts
{
    [self.rightItemView.searchTextField resignFirstResponder];
    self.resortName=[self MandarinTransformToLatin:self.rightItemView.searchTextField];
    [self loadNewResorts];
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

-(void)loadNewResorts
{
    NSString *httpArg =[NSString stringWithFormat:@"id=%@&output=json",self.resortName];
    [self requestWithHttpArg:httpArg];

}

-(void)requestWithHttpArg:(NSString*)httpArg
{
    NSString* httpUrl=@"http://apis.baidu.com/apistore/attractions/spot";
    NSURLRequest* request=[JZJRequestCenter generateRequestByHttpUrl:httpUrl withHttpArg:httpArg];
    self.task=[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            MYLog(@"HttpError:%@",error.userInfo);
        }
        else
        {
            NSInteger statusCode=[(NSHTTPURLResponse*)response statusCode];
            if (statusCode==200)
            {
                NSDictionary* originalDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSDictionary* resultDict=originalDict[@"result"];
                self.resort=[JZJDataManager getResortsFromData:resultDict];
                
                NSDictionary* ticket_infoDict=resultDict[@"ticket_info"];
                self.information=[JZJDataManager getTicketInformationOfResort:ticket_infoDict];
                NSArray* attentionArray=ticket_infoDict[@"attention"];
                self.allAttentions=[JZJDataManager getTicketAttentionOfTicketInformation:attentionArray];
                [self update:self.resort];
            }
        
        }
    }];
    [self.task resume];
}
#pragma mark - 更新界面
- (void)update:(JZJResort*)resort
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.reSortNameLabel.text=resort.name;
      
        switch ([self.resort.star intValue])
        {
            case 1:
            {
                self.firstStarImageView.image=[UIImage imageNamed:@"solidStar"];
            }
                break;
            case 2:
            {
                self.firstStarImageView.image=[UIImage imageNamed:@"solidStar"];
                self.secondStarImageView.image=[UIImage imageNamed:@"solidStar"];
            }
                break;
            case 3:
            {
                self.firstStarImageView.image=[UIImage imageNamed:@"solidStar"];
                self.secondStarImageView.image=[UIImage imageNamed:@"solidStar"];
                self.thirdStarImageView.image=[UIImage imageNamed:@"solidStar"];
            }
                break;
            case 4:
            {
                self.firstStarImageView.image=[UIImage imageNamed:@"solidStar"];
                self.secondStarImageView.image=[UIImage imageNamed:@"solidStar"];
                self.thirdStarImageView.image=[UIImage imageNamed:@"solidStar"];
                self.forthStarImageView.image=[UIImage imageNamed:@"solidStar"];
            }
                break;
            case 5:
            {
                self.firstStarImageView.image=[UIImage imageNamed:@"solidStar"];
                self.secondStarImageView.image=[UIImage imageNamed:@"solidStar"];
                self.thirdStarImageView.image=[UIImage imageNamed:@"solidStar"];
                self.forthStarImageView.image=[UIImage imageNamed:@"solidStar"];
                self.fifthStarImageView.image=[UIImage imageNamed:@"solidStar"];
            }
                break;
        }
        self.abstractLabel.text=resort.abstract;
        self.descriptionTextView.text=resort.resortDescription;
    });
}

- (IBAction)checkDetailInfo:(id)sender
{
    JZJDetailInformationViewController* detailInfoVC=[[JZJDetailInformationViewController alloc]init];
    detailInfoVC.urlString=self.resort.url;
    [self.navigationController pushViewController:detailInfoVC animated:YES];
}

- (IBAction)TicketInfoButton:(id)sender
{
    [self.ticketInformationTableView reloadData];
    self.ticketViewVerticalConstraint.constant=50;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:
    ^{
        [self.view layoutIfNeeded];
    }completion:nil];
}

- (IBAction)clickreturnButtonOfTicketInfoTableView:(id)sender
{
    self.ticketViewVerticalConstraint.constant=self.view.bounds.size.height;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         [self.view layoutIfNeeded];
                     }completion:nil];
}

#pragma mark - TableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return [self.resort.ticket_info allKeys].count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2)
    {
       
        return self.information.attention.count;
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier=@"cell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.textLabel.numberOfLines=0;
        cell.detailTextLabel.numberOfLines=0;
        cell.textLabel.font=[UIFont systemFontOfSize:10];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:10];
    }
    switch (indexPath.section)
    {
        case 0:
        {
            cell.textLabel.text=self.information.price;
            cell.detailTextLabel.text=nil;
        }
            break;
        case 1:
        {
            cell.textLabel.text=self.information.open_time;
            cell.detailTextLabel.text=nil;
        }
            break;
            
        case 2:
        {
            JZJTicketAttention* attention=self.allAttentions[indexPath.row];
            cell.textLabel.text=attention.attentionDescription;
            cell.detailTextLabel.text=attention.name;
        }
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray* allkeys=[self.resort.ticket_info allKeys];
    
    return allkeys[section];
}
@end
