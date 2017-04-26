//
//  VtcTabBarController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/21.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcTabBarController.h"

#import "VtcEssenceViewController.h"
#import "VtcFriendTrendViewController.h"
#import "VtcMeViewController.h"
#import "VtcNewViewController.h"
#import "VtcPublishViewController.h"

#import "VtcTabBar.h"

#import "UIImage+VtcImage.h"

#import "VtcNavigationController.h"

@interface VtcTabBarController ()

@end

@implementation VtcTabBarController

/**
 问题：
    1.选中按钮的图片被渲染 -> iOS7之后默认tabBar上按钮图片会被渲染
        1>修改图片
        2>通过代码（抽分类，UIImage）
    2.选中按钮的标题颜色：黑色，标题字体变大 -> 对应子控制器tabBarItem
    3.发布按钮显示不出来：
        分析：1.有没有文字，图片的位置都是固定的，
             2.加号的图片比其他图片大，因此就会超过tabBar
             3.不想要超出，让加号的图片垂直居中 => 修改加号按钮位置 => tabBar上按钮位置由系统决定，我们自己不能决定 => 系统的tabBarButton没有提供高亮的图片状态，因此实现不了示例效果 => 加号，应该是普通按钮，普通按钮才有高亮状态 => 发布控制器不是tabBarController的子控制器
        解决：调整系统tabBar上按钮的位置，平均分成5等分，把加号按钮显示在中间就好了
        调整系统自带控件的子控件的位置 => 自定义tabBar
    系统的tabBarButton在viewWillAppear的时候添加上去 
 */

//只会调用一次
+ (void)load {
    
    /**
     appearance:只能在空间显示之前设置才有作用
        1.只要遵守了UIAppearance协议，还要实现这个方法
        2.哪些属性可以通过appearance设置，只有被UI_APPEARANCE_SELECTOR宏修饰的属性，才能设置
     */
    
    //获取UITabBarItem
//    UITabBarItem *item = [UITabBarItem appearance];
    
//    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];

    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[VtcTabBarController class]]];
    
    //设置按钮选中标题的颜色：富文本；描述一个文字颜色、字体、阴影、空心、图文混排
    //创建一个描述文字属性的字典
    NSMutableDictionary *attrsSelected = [NSMutableDictionary dictionary];
    attrsSelected[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrsSelected forState:UIControlStateSelected];
    
    // 设置字体尺寸：只有在正常状态下，才会有效果
    NSMutableDictionary *attrsNomal = [NSMutableDictionary dictionary];
    attrsNomal[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [item setBadgeTextAttributes:attrsNomal forState:UIControlStateNormal];
}

//可能调用多次
//+ (void)initialize {
//
//    if (self == [VtcTabBarController class]) {
//        
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1. 添加自控制器（5个自控制器）-> 自定义控制器 -> 划分项目文件结构
    [self setupAllChildViewController];
    
    //2. 设置tabBar上按钮内容 -> 有对应的子控制器的tabBarItem属性决定
    [self setupAllTabBarButtonContent];
    
    //3. 自定义tabBar
    [self setupTabBar];
}

#pragma mark - 自定义tabBar
- (void)setupTabBar {

    VtcTabBar *tabBar = [[VtcTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
//    self.tabBar = tabBar;
//    NSLog(@"%@", tabBar);
    
//    self.tabBar.delegate = self;
}
/**
 reason: 'Changing the delegate of a tab bar managed by a tab bar controller is not allowed.
 被UITabBarController所管理的UITabBar的delegte是不允许修改的
 */


#pragma mark - 添加所有的子控制器
- (void) setupAllChildViewController {

    
    //精华
    VtcEssenceViewController *essenceVC = [[VtcEssenceViewController alloc] init];
    VtcNavigationController *essenceNavVC = [[VtcNavigationController alloc] initWithRootViewController:essenceVC];
    // initWithRootViewController:push
    // tabBarVC默认会把第0个子控制器添加上去
    [self addChildViewController:essenceNavVC];
    
    //新帖
    VtcNewViewController *newVC = [[VtcNewViewController alloc] init];
    VtcNavigationController *newNavVC = [[VtcNavigationController alloc] initWithRootViewController:newVC];
    [self addChildViewController:newNavVC];
    
    //发布
//    UIViewController *publishVC = [[UIViewController alloc] init];
//    [self addChildViewController:publishVC];
    
    //关注
    VtcFriendTrendViewController *friendTrendVC = [[VtcFriendTrendViewController alloc] init];
    VtcNavigationController *friendTrendNavVC = [[VtcNavigationController alloc] initWithRootViewController:friendTrendVC];
    [self addChildViewController:friendTrendNavVC];
    
    //我
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([VtcMeViewController class]) bundle:nil];
    //加载箭头指向控制器
    VtcMeViewController *meVC = [storyboard instantiateInitialViewController];
//    VtcMeViewController *meVC = [[VtcMeViewController alloc] init];
    VtcNavigationController *meNavVC = [[VtcNavigationController alloc] initWithRootViewController:meVC];
    [self addChildViewController:meNavVC];
}

#pragma mark - 设置tabBarItem上所有内容
- (void)setupAllTabBarButtonContent {
    
    // --------------- 精华 ---------------
    UINavigationController *essenceNavVC = self.childViewControllers[0];
    essenceNavVC.tabBarItem.title = @"精华";
    essenceNavVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    essenceNavVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    // --------------- 新帖 ---------------
    UINavigationController *newNavVC = self.childViewControllers[1];
    newNavVC.tabBarItem.title = @"新帖";
    newNavVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    newNavVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    // --------------- 发布 ---------------
//    VtcPublishViewController *publishVC = self.childViewControllers[2];
//    publishVC.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_publish_icon"];
//    publishVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
    
    //设置图片位置
//    publishVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    // --------------- 关注 ---------------
    UINavigationController *friendTrendNavVC = self.childViewControllers[2];
    friendTrendNavVC.tabBarItem.title = @"关注";
    friendTrendNavVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    friendTrendNavVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    // --------------- 我的 ---------------
    UINavigationController *meNavVC = self.childViewControllers[3];
    meNavVC.tabBarItem.title = @"我";
    meNavVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    meNavVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
