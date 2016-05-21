//
//  ViewController.m
//  Demo
//
//  Created by Mac on 16/5/21.
//  Copyright © 2016年 summer. All rights reserved.
//

#import "ViewController.h"

#import "XTTableViewCell.h"
#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height

#define cellIdentifier @"cellId"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGFloat endPoint_x;
@property (nonatomic, assign) CGFloat endPoint_y;
@property (nonatomic, strong) CALayer *dotLayer;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) UIButton *btn;
@end

@implementation ViewController
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height - 88) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[XTTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(15, Screen_height - 100, 80, 80);
    [self.view addSubview:_btn];
    _btn.backgroundColor = [UIColor cyanColor];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Block 回调
    __weak __typeof(&*cell) weakCell = cell;
    cell.block = ^(NSInteger nCount, BOOL boo){
        
        CGRect parentRect = [weakCell convertRect:weakCell.btnPlus.frame toView:self.view];
        
        if (boo) {
            // 这里是动画开始的方法
            [self JoinCartAnimationWithRect:parentRect];
            
        }
        else
        {
            
        }
    };
    return cell;
}
#pragma mark -加入购物车动画
-(void) JoinCartAnimationWithRect:(CGRect)rect
{
    _endPoint_x = 35;
    _endPoint_y = Screen_height - 35;
    
    CGFloat startX = rect.origin.x;
    CGFloat startY = rect.origin.y;
    
    _path= [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    
    //三点曲线
    [_path addCurveToPoint:CGPointMake(_endPoint_x, _endPoint_y)
             controlPoint1:CGPointMake(startX, startY)
             controlPoint2:CGPointMake(startX - 180, startY - 200)];
    _dotLayer = [CALayer layer];
    _dotLayer.backgroundColor = [UIColor purpleColor].CGColor;
    _dotLayer.frame = CGRectMake(0, 0, 20, 20);
    _dotLayer.cornerRadius = 5;
    [self.view.layer addSublayer:_dotLayer];
    [self groupAnimation];
}
#pragma mark - 组合动画
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.5f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.8f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [_dotLayer addAnimation:groups forKey:nil];
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.8f];
}
- (void)removeFromLayer:(CALayer *)layerAnimation{
    
    [layerAnimation removeFromSuperlayer];
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if ([[anim valueForKey:@"animationName"]isEqualToString:@"groupsAnimation"]) {
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:0.9];
        shakeAnimation.toValue = [NSNumber numberWithFloat:1];
        shakeAnimation.autoreverses = YES;
        // 这里是下方的自定义View上面 放的btn. 自己随便定义一个 0.-
//        [_shopCartView.btnBackImg.layer addAnimation:shakeAnimation forKey:nil];
    
        
        [_btn.layer addAnimation:shakeAnimation forKey:nil];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
