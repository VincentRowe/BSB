//
//  VtcNewViewController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/20.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcNewViewController.h"
#import "VtcSubTagViewController.h"

@interface VtcNewViewController ()

@end

@implementation VtcNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavItemContent];
}

#pragma mark - 设置导航条内容
- (void)setupNavItemContent {

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:[UIImage imageNamed:@"MainTagSubIcon"] highlightedImageName:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagClick)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

#pragma mark - 点击订阅标签按钮
- (void)tagClick {

    //进入推荐标签界面
    VtcSubTagViewController *subTagVC = [[VtcSubTagViewController alloc] init];
    [self.navigationController pushViewController:subTagVC animated:YES];
    
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
