//
//  VtcTopicCell.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/4/7.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcTopicCell.h"

#import "VtcTopicItem.h"

#import <UIImageView+WebCache.h>

#import "UIImage+VtcImage.h"

@interface VtcTopicCell()
/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

/** 用户名字 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/** 发布时间 */
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;

/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;

@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *repostButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end
@implementation VtcTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 增加顶部的控件，并且设置约束
        
        
        // 增加递补的控件，并且设置约束
    }
    return self;
}

/*
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置顶部和底部的控件的frame
}
*/

- (void)awakeFromNib {
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
    [super awakeFromNib];
}

- (void)setTopic:(VtcTopicItem *)topic {
    
    _topic = topic;
    
    // 设置顶部和底部控件的具体数据
    UIImage *placeholder = [UIImage vtc_circleImageWithImage:@"defaultUserIcon"];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:placeholder options:SDWebImageCacheMemoryOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        // ------ 特殊处理，如果图片下载失败，直接返回，按照她的默认做法，显示占位图片 -------
        if (!image) return;
        
//        /******************** 设置圆角图片（方法二） **********************/
//        //1.开启图形上下文
//        //比例因子：0自适应
//        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
//        
//        //2.描述裁剪区域
//        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//        
//        //3.设置裁剪区域
//        [path addClip];
//        
//        //4.画图片
//        [image drawAtPoint:CGPointZero];
//        
//        //5.取出图片
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        
//        //6.关闭上下文
//        UIGraphicsEndImageContext();
//        
//        self.profileImageView.image = image;
        
        // 由于圆角图片经常会用到，所以考虑封装方法
        self.profileImageView.image = [image vtc_circleImage];
        
//        self.profileImageView.image = [UIImage vtc_circleImageWithImage:image];
        
    }];
    
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    
    // 底部按钮的文字
    [self setupBottomBtnTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupBottomBtnTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupBottomBtnTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupBottomBtnTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    
    
}


/**
 设置底部按钮文字

 @param button 按钮
 @param number 按钮的数字
 @param placeholder 数字为零时显示的文字
 */
- (void)setupBottomBtnTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder {

    if (number >= 10000) {
        
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
        
    }else if(number > 0) {
        
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    }else {
        
        [button setTitle:[NSString stringWithFormat:@"顶"] forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= VtcMargin;
    
//    frame.origin.x += 10;
//    frame.size.width -= 20;
    
    [super setFrame:frame];
}

@end
