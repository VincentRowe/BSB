//
//  VtcADViewController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/24.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcADViewController.h"

#import <AFNetworking/AFNetworking.h>

#import "VtcADItem.h"

#import <MJExtension/MJExtension.h>

#import <UIImageView+WebCache.h>

#import "VtcTabBarController.h"

/*
 http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam
 */

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface VtcADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;

@property (nonatomic, weak) UIImageView *adImageView;

@property (nonatomic, strong) VtcADItem *adItem;

@property (nonatomic, weak) NSTimer *timer; //定时器是系统处理的，所以使用weak，系统处理的东西，都用weak

@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;


@end

@implementation VtcADViewController

#pragma mark - lazyload
- (UIImageView *)adImageView {

    if (_adImageView == nil) {
        UIImageView *adImageView = [[UIImageView alloc] init];
        
        [self.adContainView addSubview:adImageView];
        
        //添加点按手势
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [adImageView addGestureRecognizer:tapGes];
        
        adImageView.userInteractionEnabled = YES;
        
        _adImageView = adImageView;
    }
    
    return _adImageView;
}

#pragma mark - 点击广告界面调用
- (void)tap {

    //跳转到界面 => safair
    NSURL *url = [NSURL URLWithString:self.adItem.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置启动图片
    [self setupLaunchImage];
    //6p:LaunchImage-800-Portrait-736h@3x.png
    //6:LaunchImage-800-667h@2x.png
    //5:LaunchImage-568h@2x.png
    //4s:LaunchImage@2x.png
    
    //加载广告数据 => 拿到活得数据 => 服务器 => 查看接口文档
    
    //导入AFN框架：cocodpods
    //cocodpods：管理第三方库，
        //cocodpods做的事情：导入一个框架，会把这个框架依赖的所有框架都导入
    //cocodpods使用步骤：\
        1.$pod init:描述需要导入哪些框架 podfile \
        2.$pod install:xcworkspace \
        3.$pod search \
        4.$pod initall
    
    [self loadADData];
    
    //倒计时
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

#pragma mark - 点击跳过按钮调用
- (IBAction)clickJumpBtn:(id)sender {
    
    //1.销毁广告界面
    VtcTabBarController *tabBarVC = [[VtcTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    
    //2.移除定时器
    [self.timer invalidate];
}

- (void)timeChange {

//    VtcLog(@"%s", __func__);
    //倒计时
    static int i = 3;
    
    if (i == 0) {
        
        [self clickJumpBtn:nil];
        
    }
    
    i--;
    //设置跳转按钮
    [self.jumpBtn setTitle:[NSString stringWithFormat:@"跳转 (%d)s", i] forState:UIControlStateNormal];
}

#pragma mark - 加载广告数据
- (void)loadADData {
    
    //1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager vtc_manager];
    
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    //3.发送请求
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {

//        [responseObject writeToFile:@"/Users/Vincent/Desktop/X-code/VCtext/AD.plist" atomically:YES];
        //请求数据 -> 解析数据(写成plist文件) -> 设计模型 -> 字典转模型 -> 展示数据
//        VtcLog(@"%@", responseObject);
        
        //获得字典
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
//        NSArray *adArray = responseObject[@"ad"];
        
        //字典转模型
        VtcADItem *adItem = [VtcADItem mj_objectWithKeyValues:adDict];
        
        //创建UIImageView展示图片 =>
        CGFloat h = VtcScreenWidth / adItem.w * adItem.h;
        self.adImageView.frame = CGRectMake(0, 0, VtcScreenWidth, h);
        
        //加载广告页面
        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:adItem.w_picurl]];
        
        self.adItem = adItem;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        VtcLog(@"%@", error);
    }];

}

#pragma mark - 设置启动图片
- (void)setupLaunchImage {
    
    if (iPhone6P) {   //6p
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
        
    }else if (iPhone6) {   //6
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
        
    }else if (iPhone5) {   //5
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h@2x"];
        
    }else if (iPhone4) {   //4
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage@2x"];
        
    }
    
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
