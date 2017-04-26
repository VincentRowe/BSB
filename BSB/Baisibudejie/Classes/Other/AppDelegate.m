//
//  AppDelegate.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/20.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "AppDelegate.h"

#import "VtcTabBarController.h"

#import "VtcADViewController.h"

/**
    优先级：LaunchScreen > LaunchImage
    在Xcode配置了LaunchImage不起作用原因
        1.清空Xcode缓存 -> command + shift + k
        2.直接删除程序，重新运行
        3.重启Xcode
    如果是通过LaungchImage设置启动界面，那么屏幕的可视范围由图片决定
 */

/**
    项目架构（结构）搭建
 */


/**
 每次程序旭东的时候进入广告界面
    1.在启动的时候，去加个广告界面（F）
    2.启动完成的时候，加个广告界面（展示了启动图片）（T）
        a.程序一启动就进入广告界面，窗口的根控制器设置为广告控制器
        b.直接往窗口上在架上一个广告界面，等几秒过去后，在去广告界面移除 
 */

@interface AppDelegate ()

@end

@implementation AppDelegate

// 自定义类：1.可以管理自己业务
// 封装：谁的事情谁管理 方便以后代码维护

// 程序启动的时候就会调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置窗口的根控制器
//    VtcTabBarController *tabBarVC = [[VtcTabBarController alloc] init];
    VtcADViewController *adVC = [[VtcADViewController alloc] init];
    // init -> initWithNibName
        //1.首先判断有没有指定nibName
        //2.判断下有没有跟类名同名xib
    self.window.rootViewController = adVC;
    
    //3.显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
