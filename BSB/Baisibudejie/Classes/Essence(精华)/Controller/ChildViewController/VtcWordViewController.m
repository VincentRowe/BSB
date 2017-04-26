//
//  VtcWordViewController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/6.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcWordViewController.h"

@interface VtcWordViewController ()

@end

@implementation VtcWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = VtcRandomColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(VtcNavMaxY + VtcTitlesViewH, 0, VtcTabBarH, 0);
    
    VtcLog(@"%@", self.view);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:VtcTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(titleButtonDidRepeatClick) name:VtcTitleButtonDidRepeatClickNotification object:nil];
    
    [self setupRefresh];
}

- (void)setupRefresh {

    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, self.tableView.vtc_width, 35);
    
    UILabel *footerLabel = [[UILabel alloc] init];
    
    footerLabel.frame = footer.bounds;
    footerLabel.backgroundColor = [UIColor redColor];
    footerLabel.text = @"上拉刷新更多...";
    footerLabel.textAlignment = NSTextAlignmentCenter;
    
    [footer addSubview:footerLabel];
    
    
    self.tableView.tableFooterView = footer;
}

#pragma mark - tabBatButton重复点击调用
- (void)tabBarButtonDidRepeatClick {
    
    //    if (重复点击的不是精华控制器) return
    if (self.view.window == nil) return;
    
    //    if (先是在正中间的不是AllViewController) return;
    if (self.tableView.scrollsToTop == NO) return;
    
    VtcFunc;
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

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ ------ %zd", self.class, indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    //当scrollView的偏移量y值 >= offsetY时，代表footer已经完全出现
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.vtc_height;
    
    VtcLog(@"%f ----- %f ------- %f", self.tableView.contentSize.height, self.tableView.contentInset.bottom, self.tableView.vtc_height);
    if (self.tableView.contentOffset.y >= offsetY) {
        VtcLog(@"footer已经完全出现");
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
