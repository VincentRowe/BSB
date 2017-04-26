//
//  VtcSettingViewController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/23.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcSettingViewController.h"

#import <SDImageCache.h>

#import "VtcFileTool.h"

#import <SVProgressHUD/SVProgressHUD.h>

/*
 获取文件夹尺寸 => 遍历文件夹所有文件，把文件尺寸累加
 
 1.创建文件管理者
 2.获取文件夹路径
 3.获取文件夹里面所有子路径
 4.遍历所有子路径
 5.拼接 文件全路径
 6.attributesOfItemAtPath: 指定文件全路径，就能获取文件属性
 7.获取文件尺寸
 8.累加
 */

/*
 1.NSFileManager分类
 
 2.抽取一个业务类，专门处理某项业务逻辑
 
 为什么搞框架思想（MVC,MVCS,MVVM,MVP,VIPER）
 1.是代码业务逻辑比较清晰
 2.一个类中代码不要太多
 
 MVCS:
 S:service服务，业务，工具类，专门处理某项业务逻辑
 使用场景：1.处理文件 2.网络业务类，专门去加载网络 3.离线缓存业务类 4.App配置业务类
 */


#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
static NSString * const ID = @"cell";

@interface VtcSettingViewController ()

@property (nonatomic, assign) NSInteger totalSize;

@end

@implementation VtcSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存大小..."];
    
    //获取文件尺寸
    [VtcFileTool getFileCacheSize:CachePath completion:^(NSInteger totalSize) {
        
        _totalSize = totalSize;
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //计算缓存数据，计算整个应用程序的缓存数据 => 沙盒（Cache）=> 获取Cache文件尺寸
    // SDWebImage帮我们做了缓存
//    NSInteger size = [SDImageCache sharedImageCache].getSize;
//    VtcLog(@"%ld", size);

    cell.textLabel.text = [self sizeStr];
    
    return cell;
}

#pragma mark - 点击tableViewCell调用(清除缓存)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // 清空缓存
    
    // 删除文件夹中所有文件
    [VtcFileTool removeOfDirectoryAtPath:CachePath];
    
    _totalSize = 0;
    
    [self.tableView reloadData];
}

- (NSString *)sizeStr {
    
    //拼接defaultPath
    //    NSString *defaultPath = [cachePath stringByAppendingPathComponent:@"default"];

    NSInteger totalSize = _totalSize;
    
    //MB KB B
    NSString *sizeStr = @"清除缓存";
    
    if (totalSize > 1000 * 1000) {
        
        //MB
        CGFloat sizeFloat = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr, sizeFloat];
        
    }else if (totalSize > 1000) {
        
        //KB
        CGFloat sizeFloat = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)", sizeStr, sizeFloat];
        
    }else if (totalSize > 0) {
        
        //B
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)", sizeStr, totalSize];
    }
    
    sizeStr = [sizeStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    
    return sizeStr;
    
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
