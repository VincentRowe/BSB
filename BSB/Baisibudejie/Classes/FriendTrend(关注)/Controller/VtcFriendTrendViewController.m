//
//  VtcFriendTrendViewController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/20.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcFriendTrendViewController.h"

#import "VtcLoginRegisterViewController.h"

@interface VtcFriendTrendViewController ()

@end

@implementation VtcFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavItemContent];
}

#pragma mark - 点击登录注册就会调用
- (IBAction)clickLoginRegister:(id)sender {
    
    //进入到登录注册界面
    // moda 出来
    VtcLoginRegisterViewController *loginRegisterVC = [[VtcLoginRegisterViewController alloc] init];
    
    [self presentViewController:loginRegisterVC animated:YES completion:nil];
    
}


#pragma mark - 设置导航条内容
- (void)setupNavItemContent {

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:[UIImage imageNamed:@"friendsRecommentIcon"] highlightedImageName:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    
    self.navigationItem.title = @"我的关注";
}

#pragma mark - 推荐关注
- (void)friendsRecomment {

    
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
