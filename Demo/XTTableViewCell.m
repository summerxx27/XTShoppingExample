//
//  XTTableViewCell.m
//  Demo
//
//  Created by Mac on 16/5/21.
//

#import "XTTableViewCell.h"
#import <Masonry.h>
@implementation XTTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews
{
    [self.contentView addSubview:self.foodImage];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.btnMinus];
    [self.contentView addSubview:self.btnPlus];
    [self.contentView addSubview:self.orderCount];
}

- (UIImageView *)foodImage
{
    if (!_foodImage) {
        _foodImage = [[UIImageView alloc] init];
    }
    return _foodImage;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}
- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
    }
    return _priceLabel;
}
- (UIButton *)btnMinus
{
    if (!_btnMinus) {
        _btnMinus = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btnMinus;
}
- (UIButton *)btnPlus
{
    if (!_btnPlus) {
        _btnPlus = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btnPlus;
}
- (UILabel *)orderCount
{
    if (!_orderCount) {
        _orderCount = [[UILabel alloc] init];
    }
    return _orderCount;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_foodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(5.0);
        make.left.equalTo(self.contentView.mas_left).with.offset(5.0);
        make.width.equalTo(@88.0);
        make.height.equalTo(@88.0);
    }];
    self.foodImage.backgroundColor = [UIColor cyanColor];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.foodImage.mas_right).with.offset(5.0);
        make.top.equalTo(self.contentView.mas_top).with.offset(5.0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-5.0);
        make.height.equalTo(@30);
    }];
    self.nameLabel.backgroundColor = [UIColor orangeColor];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.width.equalTo(@50.0);
        make.height.equalTo(@30);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5.0);
    }];
    self.priceLabel.backgroundColor = [UIColor lightGrayColor];
    
    [_btnMinus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nameLabel);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(CGSizeMake(25, 25));
    }];
    self.btnMinus.backgroundColor = [UIColor blackColor];
    
    [_orderCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_btnMinus.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(CGSizeMake(35, 25));
    }];
    self.orderCount.backgroundColor = [UIColor redColor];
    
    [self.btnPlus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderCount.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(CGSizeMake(25, 25));
    }];
    self.btnPlus.backgroundColor = [UIColor blackColor];
    
    [_btnMinus setTitle:@"减" forState:UIControlStateNormal];
    [_btnMinus addTarget:self action:@selector(clickMin:) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnPlus setTitle:@"加" forState:UIControlStateNormal];
    [_btnPlus addTarget:self action:@selector(clickPuls:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickPuls:(UIButton *)btn
{
    self.numCount += 1;
    self.block(self.numCount, YES);
    
}
- (void)clickMin:(UIButton *)btn
{
    self.numCount -= 1;
    self.block(self.numCount, NO);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
