//
//  VtcFileCacheTool.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/5.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcFileTool.h"

@implementation VtcFileTool

/**
 业务类：以后开发中用来专门处理某件事情，网络处理，缓存处理
 */

#pragma mark - 自己做SDWebImage做的缓存大小
+ (void) getFileCacheSize:(NSString *)directoryPath completion:(void(^)(NSInteger id))completion {
    
    //NSFileManager
    //attributesOfItemAtPath:制定文件的路径，就能获得文件属性
    //把所有的文件尺寸叠加起来
    
    //
    
    //获得文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    //判断是否是文件夹
    BOOL isDirectory;
    BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExists || !isDirectory) {
        //抛出异常
        //name：异常名称
        //reason：报错原因
        NSException *exception = [NSException exceptionWithName:@"pathError" reason:@"！！！需文件夹路径，并且文件存在" userInfo:nil];
        
        [exception raise];
    }
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 获取文件夹下的所有文件 包含子路径的子路径（二层路径）
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        
        //遍历文件夹所有文件，一个个叠加起来
        NSInteger totalSize = 0;
        
        for (NSString *subPath in subPaths) {
            
            //拼接子文件的全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            //判断是否是隐藏文件
            if ([filePath containsString:@".DS"]) continue;   //切记此处不能用return，会整个跳出循环
            
            //判断是否是文件夹
            BOOL isDirectory;
            BOOL isExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            
            if (!isExists || isDirectory) continue;
            
            //获取文件属性
            //attributesOfItemAtPath:获取文件夹不对，
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            
            //default尺寸
            NSInteger fileSize = [attr fileSize];
            
            totalSize += fileSize;
        }
        
        //计算完成回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
        
    });
    
//    VtcLog(@"%ld", totalSize);
    
}

+ (void)removeOfDirectoryAtPath:(NSString *)directoryPath {

    //创建文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    //判断是否是文件夹
    BOOL isDirectory;
    BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExists || !isDirectory) {
        //抛出异常
        //name：异常名称
        //reason：报错原因
        NSException *exception = [NSException exceptionWithName:@"pathError" reason:@"！！！需传入文件夹路径，并且该文件存在" userInfo:nil];
        
        [exception raise];
    }
    
    
    // 获取cache文件夹下的所有文件 不包含子路径的子路径（二层路径）
    NSArray *directoryContentsAtPaths =  [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    
    VtcLog(@"%@", directoryContentsAtPaths);
    
    for (NSString *directoryContentsAtPath in directoryContentsAtPaths) {
        //拼接完整的子路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:directoryContentsAtPath];
        
        //删除路径
        [mgr removeItemAtPath:filePath error:nil];
    }
    
}


@end
