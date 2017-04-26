//
//  VtcMeViewController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/20.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcMeViewController.h"

#import "VtcSettingViewController.h"

#import <AFNetworking/AFNetworking.h>

#import "VtcSquareItem.h"

#import <MJExtension/MJExtension.h>

#import "VtcSquareCell.h"

#import <SafariServices/SafariServices.h>
#import <WebKit/WebKit.h>

#import "VtcWebViewController.h"

static NSString * const ID = @"cell";

static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (VtcScreenWidth - (cols - 1) * margin) / cols


@interface VtcMeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SFSafariViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation VtcMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavItemContent];
    
    // 设置tabView的底部视图
    [self setupFoodView];
    
    // 展示方块的内容 -> 请求数据
    [self loadSquareData];
    
    /**
     调整细节
        1.collectionView的高度根据内容重新计算 => 有数据了 需要根据数据进行计算
        2.collectionVIew不需要滚动
     */
    
    // 处理tableViewCell的间距 tableView分组样式 默认头部和尾部间距都是有值得
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}
- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
//    VtcLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
}

#pragma mark - 设置我界面tabView 的底部视图
- (void)setupFoodView {
    
    /**
     使用UIVollectionViwe注意点：
        1.初始化要设置流水布局
        2.cell必须要注册
        3.cell必须自定义
     */
    // 创建UICollectionView的流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设计cell的尺寸
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    
    collectionView.dataSource = self;
    
    collectionView.delegate = self;
    
    collectionView.scrollEnabled = NO;
    
    [collectionView registerNib:[UINib nibWithNibName:@"VtcSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    self.collectionView = collectionView;
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}

#pragma mark - 请求方块数据
- (void)loadSquareData {

    //1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager vtc_manager];
    
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    //3.发送请求
    [mgr GET:VtcCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
//        [responseObject writeToFile:@"/Users/Vincent/Desktop/X-code/VCtext/squareData.plist" atomically:YES];
//        VtcLog(@"%@", responseObject);
        
        NSArray *dictArray = responseObject[@"square_list"];
//        NSDictionary *squareDic = [responseObject[@"square_list"]lastObject];
        //将字典数值转模型数组
        self.squareItems = [VtcSquareItem mj_objectArrayWithKeyValuesArray:dictArray];
        
        //处理数据 => 补齐缺口
        [self resloveData];
        
        // 设置UICollectionView 计算UICollectionView的高度 => rows * itemWH
        // rows = (count - 1) / cols + 1;   // 万能公式
        NSInteger count = self.squareItems.count;
        // 计算总行数 => rows = (count - 1) / cols + 1;   // 万能公式
        NSInteger rows = (count - 1) / cols + 1;
        
        //设置collectionView的高度
        self.collectionView.vtc_height = rows * itemWH + (rows - 1) * margin;
        
        // 更新tableView滚动范围
        self.tableView.tableFooterView = self.collectionView;
        //设置tableView滚动范围 自己计算
        self.tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.collectionView.frame));
        
        //刷新表格
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 处理请求完成的数据
- (void)resloveData {

    // 判断缺了几个
    NSInteger count = self.squareItems.count;
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i++) {
            VtcSquareItem *item = [[VtcSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
    
}


#pragma mark - 设置导航条内容
- (void)setupNavItemContent {
    
    // 夜间模式
    UIBarButtonItem *nightMode = [UIBarButtonItem itemWithNormalImageName:[UIImage imageNamed:@"mine-moon-icon"] selectedImageName:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(nightMode:)];
    
    // 设置
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithNormalImageName:[UIImage imageNamed:@"mine-setting-icon"] highlightedImageName:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingItem)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightMode];
    self.navigationItem.title = @"我的";
    
    
}

#pragma mark - 夜间模式
- (void)nightMode:(UIButton *)button {

    button.selected = !button.selected;
}

#pragma mark - 设置
- (void)settingItem {
    
    
    //跳转至设置界面
    VtcSettingViewController *settingVC = [[VtcSettingViewController alloc] init];
    
    //必须要在跳转之前设置
    settingVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settingVC animated:YES];
    
    /**问题：
        1.底部条没有隐藏 -> hidesBottomBarWhenPushed
        2.处理返回按钮样式
     */
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    // 从缓存池取
    VtcSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor yellowColor];
    cell.item = self.squareItems[indexPath.item];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    // 跳转界面 push，展示网页
    /**
     1.Safari openURL : 自带很多功能（进度条，刷新，前进，倒退等等）必须要跳出当前应用
     2.UIWebView（没有功能）在当前应用打开网页，UIWebView实现不了进度条功能
     3.既想不退出当前应用，又想实现有进度条功能，SFSafariViewController:专门用来展示网页的 iOS9才能使用
        3.1 导入<SafariServices/SafariServices.h>
     4.WKWebViwe：UIWebView升级版 iOS8 ）（添加功能，1.监听进度条，2.缓存）
        4.1 导入<WebKit/WebKit.h>
     */
    /**
    ************************** SFSafariViewController **************************
    VtcSquareItem *item = self.squareItems[indexPath.item];
    if (![item.url containsString:@"http"])  return;
    
    NSURL *url = [NSURL URLWithString:item.url];
    SFSafariViewController *safariView = [[SFSafariViewController alloc] initWithURL:url];
    safariView.delegate = self;
    
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:safariView animated:YES];
    
    [self.navigationController presentViewController:safariView animated:YES completion:nil];
    */
    
    /************************** SFSafariViewController **************************/
    VtcSquareItem *item = self.squareItems[indexPath.item];
    if (![item.url containsString:@"http"]) return;
    
    VtcWebViewController *webVC = [[VtcWebViewController alloc] init];
    webVC.url = [NSURL URLWithString:item.url];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - SFSafariViewControllerDelegate
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {

    [self.navigationController popViewControllerAnimated:YES];
}

/**
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    VtcLog(@"%@", NSStringFromCGRect(cell.frame));
}
 */
@end
