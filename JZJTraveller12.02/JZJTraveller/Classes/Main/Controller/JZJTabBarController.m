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
    //1.add FirstViewController
    //1.1 initialization
    JZJFirstViewController* firstVC=[[JZJFirstViewController alloc]init];
    [self setupChildViewController:firstVC image:[UIImage imageNamed:@"home"] title:@"热门游记"];
    
    //2.add SecondViewController
    JZJSecondViewController* secondVC=[[JZJSecondViewController alloc]init];
    [self setupChildViewController:secondVC image:[UIImage imageNamed:@"circle"] title:@"xxxx"];
    
    //3. add 3rdViewController
    JZJThirdViewController* thirdVC=[[JZJThirdViewController alloc]init];
    [self setupChildViewController:thirdVC image:[UIImage imageNamed:@"heart"] title:@"xxx"];
    
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
