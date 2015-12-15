//
//  JZJTabBarController.m
//  UniversalTemplate
//
//  Created by tarena on 15/11/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJTabBarController.h"
#import "JZJFirstViewController.h"
#import "JZJSecondViewController.h"
#import "JZJThirdViewController.h"
#import "JZJForthViewController.h"
@interface JZJTabBarController ()

@end

@implementation JZJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.backgroundImage=[UIImage imageNamed:@"tabbar_back"];
    //1.add FirstViewController
    //1.1 initialization
    JZJFirstViewController* firstVC=[[JZJFirstViewController alloc]init];
    [self setupChildViewController:firstVC image:[UIImage imageNamed:@"home"] title:@"热门游记"];
    
    //2.add SecondViewController
    UIStoryboard* secondStoryboard=[UIStoryboard storyboardWithName:@"JZJSecondViewController" bundle:nil];
    JZJSecondViewController* secondVC=[secondStoryboard instantiateInitialViewController];
    [self setupChildViewController:secondVC image:[UIImage imageNamed:@"circle"] title:@"景点查询"];
    
    //3. add 3rdViewController
    UIStoryboard* thirdStoryboard=[UIStoryboard storyboardWithName:@"JZJThirdViewController" bundle:nil];
    JZJThirdViewController* thirdVC=[thirdStoryboard instantiateInitialViewController];
    [self setupChildViewController:thirdVC image:[UIImage imageNamed:@"train"] title:@"列车时刻"];
    
    //4. add 4thViewController
    UIStoryboard* storyboard=[UIStoryboard storyboardWithName:@"JZJForthViewController" bundle:nil];
    JZJForthViewController* forthVC=[storyboard instantiateInitialViewController];
    [self setupChildViewController:forthVC image:[UIImage imageNamed:@"settings"] title:@"设置"];
}
-(void)setupChildViewController:(UIViewController*)viewController image:(UIImage*)image title:(NSString*)title
{
    UINavigationController* navi=[[UINavigationController alloc]initWithRootViewController:viewController];
    navi.title=title;
    navi.tabBarItem.image=image;
    viewController.title=navi.title;
    [self addChildViewController:navi];
}


@end
