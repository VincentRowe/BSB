//
//  VtcSubTagViewController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/25.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcSubTagViewController.h"
#import <AFNetworking/AFNetworking.h>

#import "VtcSubTagItem.h"

#import <MJExtension/MJExtension.h>

#import "VtcSubTagCell.h"

#import <SVProgressHUD/SVProgressHUD.h>

@interface VtcSubTagViewController ()

@property (nonatomic, strong) NSArray *subTags;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@end

@implementation VtcSubTagViewController

static NSString * const ID = @"cell";

//如何看懂接口文档：请求url(基本url + 请求参数) 请求方式
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 展示数据 -> 请求数据（接口文档）-> 解析数据(写成plist) -> (image_list, sub_number, theme_name)
    [self loadSubTagData];
    
    // 2.注册cell。不需要在xib绑定identifier：“Cell”
    [self.tableView registerNib:[UINib nibWithNibName:@"VtcSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.title = @"推荐标签";
    
    //处理cell分割线 1.自定义分割线 2.系统属性解决（ios8才支持）  3.万能方式（重写cell的setFrame）了解tabView的底层实现
        //3.1取消系统自带分割线
        //3.2把tabView背景色设置为分割线的背景色
        //3.3重写setFrame方法
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = VtcColor(220, 220, 221);
    
//    //清空tabView分割线的内边距，清空cell的约束边缘
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    /**
     tabView底层实现：
        1.首先把所有cell的位置全部计算好，保存
        2.当cell要显示的时候，就会拿到这个cell去设置frame
            cell.frame = self.frames[row]
     */
    
    //当加载数据的时候，提示用户正在加载数据 SVPro
    [SVProgressHUD showWithStatus:@"正在努力加载..."];
    
}

#pragma mark - 请求推荐标签
- (void)loadSubTagData {

    //1.创建会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager vtc_manager];
    
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    //3.发送请求
    [mgr GET:VtcCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        [responseObject writeToFile:@"/Users/Vincent/Desktop/X-code/VCtext/subTag.plist" atomically:YES];
        
        // 字典数组转模型数组
        self.subTags = [VtcSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        //刷新表格
        [self.tableView reloadData];
        
//        VtcLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        VtcLog(@"%@", error);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 当界面即将消失的时候调用
- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    // 销毁请求指示器
    [SVProgressHUD dismiss];
    
    // 取消之前的网络请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.subTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    static NSString *ID = @"cell";
    
    //自定义cell
    VtcSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
//    if (cell  == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        //从xib加载cell
        //1.如果cell从xib加载，一定要绑定标识符
        //2.或者注册cell
//        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([VtcSubTagCell class]) owner:nil options:nil][0];
//    }

    
    //获取模型
    VtcSubTagItem *item = self.subTags[indexPath.row];
    cell.item = item;
//    cell.imageView.image = [UIImage imageNamed:item.image_list];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}

@end
