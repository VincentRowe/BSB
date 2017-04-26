//
//  VtcFileCacheTool.h
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/5.
//  Copyright © 2017年 Vincent. All rights reserved.
//  处理文件缓存

#import <Foundation/Foundation.h>

@interface VtcFileTool : NSObject


/**
 获取某一个文件夹尺寸（大小）

 @param directoryPath 传文件夹路径
 @return 返回文件夹尺寸
 */
+ (void) getFileCacheSize:(NSString *)directoryPath completion:(void(^)(NSInteger id))completion;


/**
 删除某个文件夹中所有文件

 @param directoryPath 文件夹路径
 */
+ (void)removeOfDirectoryAtPath:(NSString *)directoryPath;
@end
