//
//  VtcTopicItem.h
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/4/7.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VtcTopicItem : NSObject

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;

/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;

/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;

/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

// -----------------------------------------------------------

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;

/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;

/** 转发／分享数量 */
@property (nonatomic, assign) NSInteger repost;

/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

// -----------------------------------------------------------

/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) NSInteger type;

@end
