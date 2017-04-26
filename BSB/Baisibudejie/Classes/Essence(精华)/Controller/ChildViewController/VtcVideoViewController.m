//
//  VtcVideoViewController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/6.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcVideoViewController.h"

@interface VtcVideoViewController ()

@end

@implementation VtcVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = VtcRandomColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(VtcNavMaxY + VtcTitlesViewH, 0, VtcTabBarH, 0);
    
    VtcLog(@"%@", self.view);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:VtcTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(titleButtonDidRepeatClick) name:VtcTitleButtonDidRepeatClickNotification object:nil];
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
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
