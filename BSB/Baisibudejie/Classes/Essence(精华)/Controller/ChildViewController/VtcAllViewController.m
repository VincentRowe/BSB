//
//  VtcAllViewController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/6.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcAllViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "VtcTopicItem.h"

#import "VtcTopicCell.h"


// 枚举的第一种写法
//typedef enum {
//    /** 全部 */
//    VtcTopicTypeAll = 1,
//    
//    /** 图片 */
//    VtcTopicTypePicture = 10,
//    
//    /** 段子 */
//    VtcTopicTypeWord = 29,
//    
//    /** 声音 */
//    VtcTopicTypeVoice = 31,
//    
//    /** 视频 */
//    VtcTopicTypeVideo = 41
//    
//} VtcTopicType;

// 枚举的第二种写法
typedef NS_ENUM(NSUInteger, VtcTopicType) {
    /** 全部 */
    VtcTopicTypeAll = 1,
    
    /** 图片 */
    VtcTopicTypePicture = 10,
    
    /** 段子 */
    VtcTopicTypeWord = 29,
    
    /** 声音 */
    VtcTopicTypeVoice = 31,
    
    /** 视频 */
    VtcTopicTypeVideo = 41
    
};

@interface VtcAllViewController ()
/** 用来缓存cell的高度(key: 模型 value: cell的高度) */
//@property (nonatomic, strong) NSMutableDictionary *cellHeightDict;

///** 页码 */
//@property (nonatomic,assign) NSUInteger page;

/** 当前最后一条帖子数据的描述信息， 专门用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;

/** 请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

/** 上拉刷新控件 */
@property (nonatomic, weak) UIView *footer;
/** 上拉刷新控件里面的文字 */
@property (nonatomic, weak) UILabel *footerLabel;
/** 上拉刷新控件是否正在刷新 */
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;

/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray<VtcTopicItem *> *topics;


/** 下拉刷新 */
@property (nonatomic, weak) UIView *header;

@property (nonatomic, weak) UILabel *headerLabel;

@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;

@end

@implementation VtcAllViewController

/** 方法二：cell的重用标识 */
// 使用一种cell（topicCell）描述
//static NSString * const VtcVideoCellID = @"VtcVideoCellID";
//static NSString * const VtcVoiceCellID = @"VtcVoiceCellID";
//static NSString * const VtcPictureCellID = @"VtcPictureCellID";
//static NSString * const VtcWordCellID = @"VtcWordCellID";

static NSString * const VtcTopicCellID = @"VtcTopicCellID";

#pragma mark - lazyLoad 
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager vtc_manager];
    }
    
    return _manager;
}
//
//- (NSMutableDictionary *)cellHeightDict {
//    if (!_cellHeightDict) {
//        _cellHeightDict = [NSMutableDictionary dictionary];
//    }
//    return _cellHeightDict;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = VtcColor(206, 206, 206);
    self.tableView.contentInset = UIEdgeInsetsMake(VtcNavMaxY + VtcTitlesViewH, 0, VtcTabBarH, 0);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    VtcLog(@"%@", self.view);
    
    // 计算cell的估算高度（每一行大约都是44）
//    self.tableView.estimatedRowHeight = 44;
    
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 方法二：注册cell
//    [self.tableView registerClass:[VtcVideoCell class] forCellReuseIdentifier:VtcVoiceCellID];
//    [self.tableView registerClass:[VtcVoiceCell class] forCellReuseIdentifier:VtcVoiceCellID];
//    [self.tableView registerClass:[VtcPictureCell class] forCellReuseIdentifier:VtcPictureCellID];
//    [self.tableView registerClass:[VtcWordCell class] forCellReuseIdentifier:VtcWordCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VtcTopicCell class]) bundle:nil] forCellReuseIdentifier:VtcTopicCellID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:VtcTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(titleButtonDidRepeatClick) name:VtcTitleButtonDidRepeatClickNotification object:nil];
    
    [self setupRefresh];
}

- (void)setupRefresh {
    
    // 广告条
    UILabel *adLabel = [[UILabel alloc] init];
    adLabel.backgroundColor = [UIColor blackColor];
    adLabel.frame = CGRectMake(0, 0, 0, 30);
    adLabel.text = @"广告";
    adLabel.textColor = [UIColor whiteColor];
    adLabel.textAlignment = NSTextAlignmentCenter;
    
    self.tableView.tableHeaderView = adLabel;
    
    //header/下拉刷新 //此方法不可行，
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, -50, self.tableView.vtc_width, 50);
    
    UILabel *headerLabel = [[UILabel alloc] init];
    
    headerLabel.frame = header.bounds;
    headerLabel.backgroundColor = [UIColor grayColor];
    headerLabel.text = @"上拉刷新更多";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    [header addSubview:headerLabel];
    
    [self.tableView addSubview:header];
    
    self.header = header;
    self.headerLabel = headerLabel;
    
    // 让header自动进入刷新
    [self headerBeginRefreshing];
    
    //footer/上拉刷新
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, self.tableView.vtc_width, 35);
    
    UILabel *footerLabel = [[UILabel alloc] init];
    
    footerLabel.frame = footer.bounds;
    footerLabel.backgroundColor = [UIColor redColor];
    footerLabel.text = @"上拉刷新更多...";
    footerLabel.textAlignment = NSTextAlignmentCenter;
    
    [footer addSubview:footerLabel];
    
    self.tableView.tableFooterView = footer;
    
    self.footerLabel = footerLabel;
    self.footer = footer;
}

#pragma mark - tabBatButton重复点击调用
- (void)tabBarButtonDidRepeatClick {

//    if (重复点击的不是精华控制器) return
    if (self.view.window == nil) return;
    
//    if (显示在正中间的不是AllViewController) return;
    if (self.tableView.scrollsToTop == NO) return;
    
    VtcFunc;
    
    // 进入下拉刷新
    [self headerBeginRefreshing];
}



#pragma mark - tabBatButton重复点击调用
- (void)titleButtonDidRepeatClick {
    
//    //    if (重复点击的不是精华控制器) return
//    if (self.view.window == nil) return;
//    
//    //    if (先是在正中间的不是AllViewController) return;
//    if (self.tableView.scrollsToTop == NO) return;

    [self tabBarButtonDidRepeatClick];
//    VtcFunc;
}


- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 处理header
 */
- (void)dealHeader {

    if (self.isHeaderRefreshing) return;
    
    // 当scrollView的偏移量y值 <= offsetY时，代表header已经完全出现
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.vtc_height);
    if (self.tableView.contentOffset.y <= offsetY) { // header已经完全出现
        
        self.headerLabel.text = @"松开立即刷新";
        self.headerLabel.backgroundColor = [UIColor greenColor];
//        VtcFunc;
    }else {
    
        self.headerLabel.text = @"下拉可以刷新";
        self.headerLabel.backgroundColor = [UIColor grayColor];
    }
    
}

#pragma mark - 代理方法
/**
 用户松开scrollView时调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    
//    //如果正在下拉刷新，直接返回
//    if (self.isHeaderRefreshing) return;
//    
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.vtc_height);
    if (self.tableView.contentOffset.y <= offsetY) {    // header已经完全出现
    
        [self headerBeginRefreshing];
    }
}

/**
 处理footer
 */
- (void)dealFooter {

    //还没有任何内容的时候，不需要判断
    if (self.tableView.contentSize.height == 0) return;
    
//    //如果正在刷新，直接返回
//    if (self.isFirstResponder) return;
    
    //当scrollView的偏移量y值 >= offsetY时，代表footer已经完全出现
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.vtc_height - self.tableView.tableFooterView.vtc_height * 0.5;
    
//    VtcLog(@"%f ----- %f ------- %f", self.tableView.contentSize.height, self.tableView.contentInset.bottom, self.tableView.vtc_height);
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > -(self.tableView.contentInset.top)) { //foot完全出现，并且是向下拖拽
//         VtcLog(@"footer已经完全出现");
        
        [self footerBeginRefreshing];
    }
}

#pragma mark - 数据请求处理
/**
 * 服务器数据：45, 44, 43, 42, 41, ... ... 5, 4, 3, 2, 1
 * 下⬇️拉刷新 (new-最新) @[45, 44, 43];
 
 * 上⬆️拉刷新 (more-更多) @[37, 36, 35];
 
 * 客户端数据：
    self.topics = @[40, 39, 38];
 
 * 请求回来先后顺序
    1.
 */

/**
 * 发送请求给服务器，下拉刷新数据
 */
- (void)loadNewTopics {
    
    // 0.取消之前的请求
    // 取消所有的请求，并且关闭session(注意：一旦关闭session，这个manager再也无法发送任何请求)
//    [self.manager invalidateSessionCancelingTasks:YES];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    [self footerEndRefreshing];
    
    // 1.创建请求会话管理者
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager vtc_manager];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";
    parameters[@"type"] = @1;
    
//    parameters[@"mintime"] = @"";
    
    // 3.发送请求
    [self.manager GET:VtcCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        VtcAFNWriteToPlist(new_topics);
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组转模型数组
        self.topics = [VtcTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
//        NSMutableArray *newTopics = [VtcTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        
//        if (self.topics) {
//            
//            [self.topics insertObject:newTopics atIndex:[NSIndexSet indexSetWithIndex:0]];
//            
//        }else {
//            
//            self.topics = newTopics;
//        }
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self headerEndRefreshing];
        
//        VtcLog(@"%@", responseObject);

        // 清空之前计算的cell的高度
//        [self.cellHeightDict removeAllObjects];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 错误编码状态
        if (error.code != NSURLErrorCancelled) {   // 并非是取消任务导致的error，是其他网络问题
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
        
        
        
//        VtcLog(@"%@", error);
        // 结束刷新
        [self headerEndRefreshing];
        
        
    }];
}

/**
 * 发送请求给服务器，上拉加载更多数据
 */
- (void)loadMoreTopics {
    
    // 0.取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    [self headerEndRefreshing];
    
    // 1.创建请求会话管理者
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager vtc_manager];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";
    parameters[@"maxtime"] = self.maxtime;
//    self.page++;
//    parameters[@"page"] = @(self.page);   // ------方法一
//    parameters[@"page"] = @(self.page + 1); // ------方法二
    
    // 3.发送请求
    [self.manager GET:VtcCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        NSArray *moreTopics = [VtcTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 追加数据到久数组后面
        /**
         * self.topics = @[10, 9, 8];
         * moreTopics = @[7, 5, 4];
         */
        // self.topics = @[10, 9, 8, @[7, 5, 4]];
//        [self.topics addObject:moreTopics]
        
        // self.topics = @[10, 9, 8, 7, 5, 4];
        [self.topics addObjectsFromArray:moreTopics];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self footerEndRefreshing];
        
//        self.page = [parameters[@"page"] integerValue]; // ------方法二
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 错误编码状态
        if (error.code != NSURLErrorCancelled) {   // 并非是取消任务导致的error，是其他网络问题
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }

        
        // 结束刷新
        [self footerEndRefreshing];
        
//        self.page--;  // ------方法一
    }];
}


#pragma mark - headerRefresh
- (void)headerBeginRefreshing {
    
//    // 如果正在上拉刷新，直接返回
//    if (self.isFooterRefreshing) return;

    // 如果正在下拉刷新，直接返回
    if (self.isHeaderRefreshing) return;
    
    // 进入下拉刷新状态
    self.headerLabel.text = @"正在刷新数据...";
    self.headerLabel.backgroundColor = [UIColor orangeColor];
    
    self.headerRefreshing = YES;
    
    // 增加内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.header.vtc_height;
        self.tableView.contentInset = inset;
        
        // 修改偏移量
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, - inset.top);
    }];
    
    // 发送请求给服务器，下拉刷新数据
    [self loadNewTopics];

}

- (void)headerEndRefreshing {

    self.headerRefreshing = NO;
    // 减少内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.header.vtc_height;
        self.tableView.contentInset = inset;
    }];
}

#pragma mark - footerRefresh
- (void)footerBeginRefreshing {

//    // 如果正在下拉刷新，直接返回
//    if (self.isHeaderRefreshing) return;
    
    // 如果正在上拉刷新，直接返回
    if (self.isFooterRefreshing) return;
    
    // 进入刷新状态
    self.footerRefreshing = YES;
    
    self.footerLabel.text = @"正在加载更多数据...";
    
    self.footerLabel.backgroundColor = [UIColor orangeColor];
    
    // 发送请求给服务器，上拉加载更多数据
    [self loadMoreTopics];
}

- (void)footerEndRefreshing {

    self.footerRefreshing = NO;
    self.footerLabel.text = @"上拉刷新更多...";
    self.footerLabel.backgroundColor = [UIColor redColor];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //监听上拉footerView隐藏  根据数据量显示隐藏footer
    self.footer.hidden = self.topics.count == 0;
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VtcTopicItem *topic = self.topics[indexPath.row];
    
//    VtcTopicCell *cell = nil;
    
    // 方法一：
//    if (topic.type == 10) { //图片
//        
//        cell = [tableView dequeueReusableCellWithIdentifier:@"VtcPictureCell"];
//        if (cell == nil) {
//            cell = [[VtcPictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VtcPictureCell"];
//        }
//        
//    }else if (topic.type == 29) {   // 段子
//        
//        cell = [tableView dequeueReusableCellWithIdentifier:@"VtcWordCell"];
//        if (cell == nil) {
//            cell = [[VtcWordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VtcWordCell"];
//        }
//    }else if (topic.type == 31) {   // 声音
//        
//        cell = [tableView dequeueReusableCellWithIdentifier:@"VtcVoiceCell"];
//        
//        if (cell == nil) {
//            cell = [[VtcVoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VtcVoiceCell"];
//        }
//    }else if (topic.type == 41) {   // 视频
//        
//        cell = [tableView dequeueReusableCellWithIdentifier:@"VtcVideoCell"];
//        if (cell == nil) {
//            cell = [[VtcVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VtcVideoCell"];
//        }
//    }
    
    // 方法二：先注册。然后再通过重用标识去取
//    if (topic.type == VtcTopicTypePicture) {     //  图片
//        cell = [tableView dequeueReusableCellWithIdentifier:VtcPictureCellID];
//    } else if (topic.type == VtcTopicTypeWord) {    // 段子
//        cell = [tableView dequeueReusableCellWithIdentifier:VtcWordCellID];
//    } else if (topic.type == VtcTopicTypeVoice) {      // 声音
//        cell = [tableView dequeueReusableCellWithIdentifier:VtcVoiceCellID];
//    } else if (topic.type == VtcTopicTypeVideo) {      // 视频
//        cell = [tableView dequeueReusableCellWithIdentifier:VtcVideoCellID];
//    }
    
    VtcTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:VtcTopicCellID];
    
    // control + command + 空格 -> 弹出emoji表情键盘
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
// 所有cell的高度 -> cotentSize.height -> 滚动条长度

// 估算高度使用
// self.tableView.estimatedRowHeight * 总数量 -> contentSize.height -> 滚动条长度

/**
 使用estimatedRowHeight的优缺点
 1.优点
    1> 可以降低tableView：heightForRowAtIndexPath方法的调用频率
    2> 将【计算cell高度的操作】延迟执行了（相当于cell高度的计算是懒加载的）
 2.缺点
    1> 滚动条长度不准确、不稳定，甚至有卡顿效果（如果不使用estimatedRowHeight，滚动条的长度就是准确的）
 
 */

/**
 这个方法的特点：
 1.默认情况下（没有设置estimatedRowHeight的情况下）
    1>每次刷新表格的时候，有多少数据，这个方法就一次性调用多少次（如果有100条数据，每次reloadData,这个方法就会一次性调用100次）
    2>每当有cell进入屏幕范围内，就会调用一次这个方法
 
 2.设置estimatedRowHeight的情况下
    1> 用到了（显示）哪个cell，才会调用这个方法去计算那个cell的高度（方法调用频率降低了）
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VtcTopicItem *topic = self.topics[indexPath.row];
    
    
    // *********************************** 第一种方法 *********************************** //
//    // topic ->@"0xff43445434" -> @(cellHeight)
//    // topic ->@"0x3543445434" -> @(cellHeight)
////    NSString *key = [NSString stringWithFormat:@"%p", topic];
//    NSString *key = topic.description;
//    
//    
//    CGFloat cellHeight = [self.cellHeightDict[key] doubleValue];
////    CGFloat cellHeight = 0;
//    
//    if (cellHeight == 0) {  // 这个模型对应的cell高度还没有计算过
//        
//        // 文字的Y值
//        cellHeight += 55;
//        
//        //文字的高度
//        CGSize textMaxSize = CGSizeMake(VtcScreenWidth - 2 * VtcMargin, MAXFLOAT);
//        //    cellHeight += [topic.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:textMaxSize].height + VtcMargin;
//        cellHeight += [topic.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + VtcMargin;
//        
//        //工具条
//        cellHeight += 35 + 2 * VtcMargin;
//        
//        // 存储高度
//        self.cellHeightDict[key] = @(cellHeight);   //此代码与下面代码等价
////        [self.cellHeightDict setObject:@(cellHeight) forKey:key];
//        
//        VtcLog(@"%zd %f", indexPath.row, cellHeight);
//    }
    
    
    // 这两个方法都只适合计算单行文字的宽高
//    [topic.text sizeWithFont:[UIFont systemFontOfSize:15]].width;
//    [UIFont systemFontOfSize:15].lineHeight;
    
    // *********************************** 第二种方法 *********************************** //
//    return topic.cellHeight;
    
    return self.topics[indexPath.row].cellHeight;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 处理header
    [self dealHeader];
    
    // 处理footer
    [self dealFooter];
    
}


@end
