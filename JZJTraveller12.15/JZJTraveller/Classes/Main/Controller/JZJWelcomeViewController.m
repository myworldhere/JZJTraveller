//
//  JZJWelcomeViewController.m
//  JZJTraveller
//
//  Created by tarena on 15/12/3.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJWelcomeViewController.h"
#import "JZJTabBarController.h"
NSString* const JZJIsNotFirstTimeToOpen=@"IsNotFirstTimeOpen";
@interface JZJWelcomeViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIPageControl* pc;
@end

@implementation JZJWelcomeViewController

static const int numberOfImages=4;
static const int heightOfPageControl=20;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    [self setupPageControl];
}

-(void)setupScrollView
{
    UIScrollView*scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.delegate=self;
    for (int i=0 ; i<numberOfImages ; i++ )
    {
        NSString* imageName=[NSString stringWithFormat:@"welcome_%d.jpg",i+1];
        
        UIImageView* iv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        CGRect iFram=iv.frame;
        if (i==3)
        {
            UIButton* button=[[UIButton alloc]initWithFrame:self.view.bounds];
            [button addTarget:self action:@selector(gotoStartView:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:button];
            iv.userInteractionEnabled=YES;
        }
        iFram.origin=CGPointMake(i*self.view.bounds.size.width, 0);
        iFram.size=self.view.bounds.size;
        iv.frame=iFram;
        [scrollView addSubview:iv];
        
    }
    
    scrollView.contentSize=CGSizeMake(numberOfImages*self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:scrollView];
    scrollView.bounces=NO;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.pagingEnabled=YES;
}

-(void)setupPageControl
{
    UIPageControl* pc=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height*0.8, self.view.bounds.size.width, heightOfPageControl)];
    pc.numberOfPages=numberOfImages;
    pc.userInteractionEnabled=NO;
    self.pc=pc;
    [self.view addSubview:pc];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index=round(scrollView.contentOffset.x/self.view.bounds.size.width);
    self.pc.currentPage=index;
}
-(void)gotoStartView:(UIButton*)sender
{
    UIApplication* appilcation=[UIApplication sharedApplication];
    appilcation.keyWindow.rootViewController=[[JZJTabBarController alloc]init];
    NSUserDefaults* userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setBool:YES forKey:JZJIsNotFirstTimeToOpen];
}
@end






