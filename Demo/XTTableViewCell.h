//
//  XTTableViewCell.h
//  Demo
//
//  Created by Mac on 16/5/21.
//  Copyright © 2016年 summerxx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**< typedef block >*/
typedef void(^btnPulsBlock)(NSInteger count, BOOL animated);

@interface XTTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *foodImage;   // cyan
@property (nonatomic, strong) UILabel *nameLabel;       // orange
@property (nonatomic, strong) UILabel *priceLabel;      // gray
@property (nonatomic, strong) UIButton *btnMinus;       // black
@property (nonatomic, strong) UIButton *btnPlus;        // black
@property (nonatomic, strong) UILabel *orderCount;      // red
@property (nonatomic, copy)   btnPulsBlock block;       // block
@property (nonatomic, strong) UIImageView *animateView; // 购物车图标
@property (nonatomic, assign) NSInteger numCount;       // 计数器
@end
