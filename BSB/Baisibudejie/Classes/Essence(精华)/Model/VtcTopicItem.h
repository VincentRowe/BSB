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


/** 额外增加的属性（并非服务器返回的属性，仅仅是为了提高开发效率） */
/** 根据当前模型计算出来的cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;


@end
