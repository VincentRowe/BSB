//
//  VtcLoginRegisterViewController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/28.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcLoginRegisterViewController.h"

#import "VtcLoginRegisterView.h"

#import "VtcFastLoginView.h"


@interface VtcLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewLeadingCons;
@end

@implementation VtcLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建登录的view
    VtcLoginRegisterView *loginView = [VtcLoginRegisterView loginView];
    
    // 从新固定尺寸
//    loginView.frame = CGRectMake(0, 0, self.middleView.vtc_width * 0.5, self.middleView.vtc_height);
    
    // 添加到中间的view
    [self.middleView addSubview:loginView];
    
    // 创建注册的View
    VtcLoginRegisterView *registerView = [VtcLoginRegisterView registerView];
    
    registerView.vtc_x = self.middleView.vtc_width * 0.5;
    VtcLog(@"x ==== %f", registerView.vtc_x);
    
    // 从新固定尺寸
//    registerView.frame = CGRectMake(registerView.vtc_x, 0, self.middleView.vtc_width * 0.5, self.middleView.vtc_height);
    
    //添加到中间的VIew
    [self.middleView addSubview:registerView];
    
    //添加快速登陆view
    VtcFastLoginView *fastLoginView = [VtcFastLoginView fastLoginView];
    
    //添加到底部View上面
    [self.bottomView addSubview:fastLoginView];
    
    /**
     屏幕适配：
        1.一个view从xib加载，需要从新固定尺寸
        2.在开发中，一般在viewDidLayoutSubviews布局子控件
     */

    
}
- (IBAction)CloseLoginRegisterVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickLoginRegisterBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    //平移中间View
    self.middleViewLeadingCons.constant = self.middleViewLeadingCons.constant == 0 ? -self.middleView.vtc_width * 0.5 : 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    
    VtcLoginRegisterView *loginView = self.middleView.subviews[0];
    // 从新固定尺寸
    loginView.frame = CGRectMake(0, 0, self.middleView.vtc_width * 0.5, self.middleView.vtc_height);
    
    VtcLoginRegisterView *registerView = self.middleView.subviews[1];
    // 从新固定尺寸
    registerView.frame = CGRectMake(registerView.vtc_x, 0, self.middleView.vtc_width * 0.5, self.middleView.vtc_height);
    
    VtcFastLoginView *fastLoginView = self.bottomView.subviews.firstObject;
    fastLoginView.frame = self.bottomView.bounds;
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
