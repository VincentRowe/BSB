//
//  VtcSubTagCell.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/2/25.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcSubTagCell.h"

#import "VtcSubTagItem.h"

#import <UIImageView+WebCache.h>

@interface VtcSubTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numberView;



@end

@implementation VtcSubTagCell

/**
 头像变成圆角 1.设置头像圆角 2.裁剪图片（生成新的图片 -> 图形上下文才能生成新的图片）
 处理数字，当订阅人数超过10000，自动转化为1.0万
 */

- (void)setItem:(VtcSubTagItem *)item {

    _item = item;
    
    //设置内容
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageCacheMemoryOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        /******************** 设置圆角图片（方法二） **********************/
        //1.开启图形上下文
        //比例因子：0自适应
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        
        //2.描述裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        
        //3.设置裁剪区域
        [path addClip];
        
        //4.画图片
        [image drawAtPoint:CGPointZero];
        
        //5.取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        //6.关闭上下文
        UIGraphicsEndImageContext();
        
        self.iconView.image = image;
        
    }];
    
    
    
    
    [self resolveNumber];
    
    self.nameView.text = item.theme_name;
    
    
}

#pragma mark - setFrame 
- (void)setFrame:(CGRect)frame {

    frame.size.height -= 10;
    
    frame.origin.x += 10;
    
    frame.size.width = VtcScreenWidth - 20;
    
    //如下方法才是真正给cell赋值
    [super setFrame:frame];
}

#pragma mark - 解决订阅数字问题
- (void)resolveNumber {
    
    //判断下有没有 > 10000
    NSString *numStr = [NSString stringWithFormat:@"%@万人订阅", self.item.sub_number];
    NSInteger num = self.item.sub_number.integerValue;
    if (num > 10000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅", numF];
        
        //当订阅人数刚好是x.0万，自定显示为x万
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    self.numberView.text = numStr;


    
}

//从xib加载就会调用一次
- (void)awakeFromNib {
    [super awakeFromNib];
    
    //设置头像的圆角（方法一）
//    self.iconView.layer.cornerRadius = 30;
//    self.iconView.layer.masksToBounds = YES;
    
//    // 设置间隔线
//    self.layoutMargins = UIEdgeInsetsZero;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
