//
//  VtcNavigationController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/23.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcNavigationController.h"

@interface VtcNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation VtcNavigationController

+ (void)load {

    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[VtcNavigationController class]]];
    
    //只要是通过模型设置，都是通过富文本设置
    //设置导航条标题 => UINavigationBar
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    
    //设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //解决滑动返回功能失效问题
    // 控制手势什么时候触发，只有非根控制器才需要触发手势
//    self.interactivePopGestureRecognizer.delegate = self;
    
    // 假死状态：程序还在运行，但是界面死了
    /**
     为什么导航控制器的手势不是全屏滑动
     */
    
//    UIScreenEdgePanGestureRecognizer *edgePanGes = self.interactivePopGestureRecognizer;
//    edgePanGes.edges = UIRectEdgeNone;
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:panGes];
    
//    VtcLog(@"%@", self.interactivePopGestureRecognizer);
    /**
     target= <(action=handleNavigationTransition:, 
     target=<_UINavigationInteractiveTransition 0x7fae48009bb0>)>>
     */
    //设置代理
    panGes.delegate = self;
    
    //禁止之前的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

#pragma mark - 统一设置返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

//    VtcLog(@"%s", __func__);
    
    if (self.childViewControllers.count > 0) {  //非根控制器
        
        //恢复滑动返回功能 -> 分析：把系统的返回按钮覆盖 -> 1.手势实效
        
        // ------------ 隐藏底部tabBar ------------
        viewController.hidesBottomBarWhenPushed = YES;
        
        // --------------------------------------
        
        //设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backWithNormalImageName:[UIImage imageNamed:@"navigationButtonReturn"] highlightedImageName:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
    }
    
    //真正在跳转
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGestureRecognizerDelegate代理方法
//决定是否出发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {

    return self.childViewControllers.count > 1;
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
