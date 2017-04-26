//
//  VtcEssenceViewController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/20.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcEssenceViewController.h"

#import "VtcTitleButton.h"

#import "VtcAllViewController.h"
#import "VtcVideoViewController.h"
#import "VtcPictureViewController.h"
#import "VtcVoiceViewController.h"
#import "VtcWordViewController.h"

@interface VtcEssenceViewController ()<UIScrollViewDelegate>

/** 用来存放所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;


/** 标题栏 */
@property (nonatomic, weak) UIView *titleView;

/** 下划线 */
@property (nonatomic, weak) UIView *titleUnderline;

/** 记录上一次点击标题按钮 */
@property (nonatomic, weak) VtcTitleButton *previousClickedTitleButton;

@end

@implementation VtcEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor redColor];
    
    //初始化所有子控制器
    [self setupAllChildVCs];
    
    // 设置导航条
    [self setupNavItemContent];
    
    // scrollView
    [self setupScrollView];
    
    // 标题栏
    [self setupTitlesView];
    
    [self addChildVCViewIntoScrollView:0];
}

#pragma mark - 初始化所有子控制器
- (void)setupAllChildVCs {

    [self addChildViewController:[[VtcAllViewController alloc] init]];
    [self addChildViewController:[[VtcVideoViewController alloc] init]];
    [self addChildViewController:[[VtcVoiceViewController alloc] init]];
    [self addChildViewController:[[VtcPictureViewController alloc] init]];
    [self addChildViewController:[[VtcWordViewController alloc] init]];
}

#pragma mark - 添加scrollView
- (void) setupScrollView {

    
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.frame = self.view.bounds;
    
    scrollView.delegate = self;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    scrollView.scrollsToTop = NO;   //点击状态栏的时候，这个scrollView不回滚动到最顶部
    
    [self.view addSubview:scrollView];
    
    self.scrollView = scrollView;
    
//    for (int i = 0; i < 5; i++) {
//        UITableView *tableView = [[UITableView alloc] init];
//        tableView.vtc_width = scrollView.vtc_width;
//        tableView.vtc_height = scrollView.vtc_height;
//        tableView.vtc_y = 0;
//        tableView.vtc_x = i *scrollView.vtc_width;
//        
//        tableView.backgroundColor = VtcRandomColor;
//        
//        [scrollView addSubview:tableView];
//    }
    
    NSInteger count = self.childViewControllers.count;
//    VtcLog(@"count ========= %ld", self.childViewControllers.count);
    CGFloat scrollViewW = scrollView.vtc_width;
    CGFloat scrollViewH = scrollView.vtc_height;
    
//    for (NSInteger i = 0; i < count; i++) {
//        //取出i位置子控制器的view
//        UIView *childVCView = self.childViewControllers[i].view;
//        
//        childVCView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
//        
//        [scrollView addSubview:childVCView];
//    }

    
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
}

#pragma mark - 添加titlesView
- (void) setupTitlesView {

    UIView *titleView = [[UIView alloc] init];
    
    // 设置半透明背景色
    titleView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    // 设置alpha会导致里面的所有子控件也都透明
//    titleView.alpha = 0.5
    
    titleView.frame = CGRectMake(0, VtcNavMaxY, self.view.vtc_width, VtcTitlesViewH);
    [self.view addSubview:titleView];
    
    self.titleView = titleView;
    
    // 标题蓝按钮
    [self setupTitleButtons];
    
    // 标题下划线
    [self setupTitleUnderline];
    
}

- (void)setupTitleButtons {

    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSInteger count = titles.count;
    
    CGFloat titleBtnW = self.titleView.vtc_width / count;
    CGFloat titleBtnH = self.titleView.vtc_height;
    for (int i = 0; i < 5; i++) {
        VtcTitleButton *titleBtn = [[VtcTitleButton alloc] init];
        
        titleBtn.tag = i;
        
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.titleView addSubview:titleBtn];
        
        // frame
        titleBtn.frame = CGRectMake(i * titleBtnW, 0, titleBtnW, titleBtnH);
        
        // 背景色
//        titleBtn.backgroundColor = VtcRandomColor;
        
        // 文字
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];

        
    }
}

/**
 一、按钮的状态
    1.UIControlStateNormal
        1> 除去UIControlStateHighlighted UIControlStateDisabled UIControlStateSelected以外的其他情况，都是Normal状态
        2> 这种状态下的按钮【可以】接收点击事件
 
    2.UIControlStateHighlighted
        1> 【当按住按钮不松开】或者【highlighted = YES;】就会达到这种状态
        2> 这种状态下的按钮【可以】接收点击事件
 
    3.UIControlStateDisabled
        1> 【button.enabled = NO;】 //进入UIControlStateDisabled状态
        2> 这种状态下的按钮【无法】接收点击事件
 
    4.UIControlStateSelected
        1> 【button.selected = YES;】   //进入UIControlStateSelected状态
        2> 这种状态下的按钮【可以】接收点击事件
 
 二、让按钮无法点击的2中方法
    1.button.enabled = NO; 
        *【会】进入UIControlStateDisabled状态
    2.button.userInteractionEnabled = NO; 
        *【不会】进入UIControlStateDisabled状态，继续把持当前状态
 */
#pragma mark - 监听标题按钮点击
- (IBAction)titleBtnClick:(VtcTitleButton *)titleBtn {
 
    // 重复点击标题按钮
    if (self.previousClickedTitleButton == titleBtn) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:VtcTitleButtonDidRepeatClickNotification object:nil];
    }
    
    // 处理标题按钮点击
    [self dealTitleButtonClick:titleBtn];
}

- (void)dealTitleButtonClick:(VtcTitleButton *)titleBtn {
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleBtn.selected = YES;
    self.previousClickedTitleButton = titleBtn;
    
    
    NSInteger index = titleBtn.tag;
    // 下划线动画
    [UIView animateWithDuration:0.25 animations:^{
        
        //处理下划线
        
        /**
         名字叫attributes并且是NSDictionary * 类型的参数，它的key一般都有如下规律
         iOS·7开始
         1> 所有的key都来源于：NSAttributedString.h
         2> 基本格式都是：NS***AttributeName
         
         iOS·7之前
         1> 所有的key都来源于：UIStringDrawing.h
         2> 基本格式都是：UITextAttribute***
         */
        //        self.titleUnderline.vtc_width = [titleBtn.currentTitle sizeWithFont:titleBtn.titleLabel.font].width;
        //        NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
        //        attribute[NSFontAttributeName] = titleBtn.titleLabel.font;
        //        self.titleUnderline.vtc_width = [titleBtn.currentTitle sizeWithAttributes:attribute].width;
        //
        
        self.titleUnderline.vtc_width = titleBtn.titleLabel.vtc_width + 10;
        self.titleUnderline.vtc_centerX = titleBtn.vtc_centerX;
        
        //滚动scrollView到【标题】对应的控制器
        //        NSInteger index = [self.titleView.subviews indexOfObject:titleBtn];
        //        CGFloat offsetX = self.scrollView.vtc_width * index;
        CGFloat offsetX = self.scrollView.vtc_width * titleBtn.tag;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
        
    } completion:^(BOOL finished) {
        //添加子控制器的View
        [self addChildVCViewIntoScrollView:index];
    }];
    
    // 设置index位置对应的tableView.scrollsToTop = YES，其他都设置为NO
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        
        UIViewController *childVC = self.childViewControllers[index];
        
        //如果View还没有背创建，就不用去处理
        if (!childVC.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVC.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        if (i == index) {   //是标签按钮对应的子控制器
            scrollView.scrollsToTop = YES;
        }else {
            
            scrollView.scrollsToTop = NO;
        }
    }
}

#pragma mark - 设置标题选中下划线
- (void)setupTitleUnderline {

    //标题按钮
    VtcTitleButton *firstTitleButton = self.titleView.subviews.firstObject;
    
    //下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.vtc_height = 2;
    titleUnderline.vtc_y = self.titleView.vtc_height - titleUnderline.vtc_height;
//    titleUnderline.vtc_width = 70;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    
    [self.titleView addSubview:titleUnderline];
    
    self.titleUnderline = titleUnderline;
    
    //默认点击最前面的按钮
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    // 处理下划线位置
    [firstTitleButton.titleLabel sizeToFit];
    self.titleUnderline.vtc_width = firstTitleButton.titleLabel.vtc_width + 10;
    self.titleUnderline.vtc_centerX = firstTitleButton.vtc_centerX;
}

#pragma mark - 添加第index个子控制器的view到scrollView中
- (void)addChildVCViewIntoScrollView:(NSInteger)index {

    CGFloat scrollViewW = self.scrollView.vtc_width;
    
    UIViewController *childVC = self.childViewControllers[index];
    
    //如果view之前已经被加载过，那就直接返回
    if (childVC.isViewLoaded) return;
    
    //取出index位置对应的子控制器
    UIView *childVCView = childVC.view;
    
    //设置子控制器的frame
    childVCView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.scrollView.vtc_height);
    
    //添加子控制的view到scrollView中
    [self.scrollView addSubview:childVCView];
}

- (void)addChildVCViewIntoScrollView {

    CGFloat scrollViewW = self.scrollView.vtc_width;
    NSInteger index = self.scrollView.contentOffset.x / scrollViewW;
    
    UIView *childVCView = self.childViewControllers[index].view;
    
    childVCView.frame = self.scrollView.bounds;
//    childVCView.frame = CGRectMake(self.scrollView.bounds.origin.x, self.scrollView.bounds.origin.y, scrollViewW, self.scrollView.vtc_height);
//    childVCView.frame = CGRectMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
//    childVCView.frame = CGRectMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y, scrollViewW, self.scrollView.vtc_height);
    
}


#pragma mark - 设置导航条
- (void)setupNavItemContent {
    
    /**
     tabBarItem: 设置tabBat上按钮内容（tabBarButton）—— 底部条内容
     
     UINavigationItem: 设置导航条上内容（左边leftBarButtonItem; 右边rightBarButtonItem; 中间）—— 顶部条内容
     UIBarbuttonItem: 描述按钮具体的内容 —— 顶部导航条按钮内容
     
     */
    //设置左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:[UIImage imageNamed:@"nav_item_game_icon"] highlightedImageName:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    //设置右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNormalImageName:[UIImage imageNamed:@"navigationButtonRandom"] highlightedImageName:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:nil];
    
    //设置titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}

- (void)game {

//    VtcLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - UIScrollViewDelegate
/**
 * 当用户松开scrollView滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    //切换按钮状态
    NSInteger index = scrollView.contentOffset.x / scrollView.vtc_width;
    
    //点击对应的标题按钮
    VtcTitleButton *titleButton = self.titleView.subviews[index];
//    VtcTitleButton *titleButton = [self.titleView viewWithTag:index]; //该方法会递归查找tag值，包括自己（主控件）
//    [self titleBtnClick:titleButton];
    
    [self dealTitleButtonClick:titleButton];
}


#warning 
/**
 
 reason: '-[UIView setSelected:]: unrecognized selector sent to instance 0x7fbef7f10170'
 
 reason: '-[VtcPerson count:]: unrecognized selector sent to instance 0x7fbef7f10170'
 将VtcPerson当作NSArray或者NSDictionary来使用
 
 reason: '-[VtcPerson setObject:forKeyedSubscript:]: unrecognized selector sent to instance 0x7fbef7f10170'
 名字中带有Subscript的方法，一般都是集合的方法，比如NSMtableDictionary、NSMtableArray的方法
 将VtcPerson当作NSMutableDictionary来使用
 */


/**
 加载bundle中图片的方法：
 */
//// ****** 方法一
//UIImage *image = [UIImage imageNamed:@"Mytest.bundle/Test"];
//
//// ****** 方法二
//NSString *file1 = [[NSBundle mainBundle] pathForResource:@"Mytest.bundle/Test" ofType:@"png"];
//UIImage *image1 = [UIImage imageWithContentsOfFile:file1];
//
//// ****** 方法三
//NSString *path = [[NSBundle mainBundle] pathForResource:@"Mytest" ofType:@"bundle"];
//NSBundle *bundle = [NSBundle bundleWithPath:path];
//NSString *file2 = [bundle pathForResource:@"Test" ofType:@"png"];
//UIImage *image2 = [UIImage imageWithContentsOfFile:file2];


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
