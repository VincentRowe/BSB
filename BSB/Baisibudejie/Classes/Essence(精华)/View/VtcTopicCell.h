//
//  VtcTopicCell.h
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/4/7.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VtcTopicItem;

@interface VtcTopicCell : UITableViewCell

/** 模型数据 */
@property(nonatomic, strong)VtcTopicItem *topic;

@end
