//
//  JGTabBarController.m
//  JGTool
//
//  Created by 郭军 on 2019/6/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JGTabBarController.h"

#import "JGNavigationController.h"
#import "JGHomeController.h"
#import "JGMineController.h"


@interface JGTabBarController()

//记录上一次点击tabbar，使用时，记得先在init或viewDidLoad里 初始化 = 0
@property (nonatomic, assign) NSInteger indexFlag;

@end


@implementation JGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [UITabBar appearance].translucent = NO;
    
        self.indexFlag = 0;
    
    //创建子控制器
    [self setUpChildViewControllers];
    
}


/**
 *  创建子控制器
 */
- (void)setUpChildViewControllers {
    
    [self setupChildVc:[[JGHomeController alloc] init] title:@"首页" image:@"tabbar_home_nor"  selectedImage:@"tabbar_home_sel"];
    
    
    [self setupChildVc:[[JGMineController alloc] init] title:@"我的" image:@"tabbar_mine_nor" selectedImage:@"tabbar_mine_sel"];
}


/**
 *  初始化控制器
 *
 *  @param vc            控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    //    vc.tabBarItem.title = title;
    vc.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JGHexColor(@"#e54b4b")} forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    //包装一个导航控制器
    JGNavigationController *nav = [[JGNavigationController alloc] initWithRootViewController:vc];
    //隐藏tabbar
    [self addChildViewController:nav];
}



- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    
    /** 给 tabBarButton 加动画 */
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        //执行动画
        NSMutableArray *arry = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [arry addObject:btn];
            }
        }
        //添加动画
        [self addScaleAnimtaionWithArr:arry index:index];
        
        self.indexFlag = index;
    }
    
}



#pragma mark - More Animation

/// 先放大，再缩小
- (void)addScaleAnimtaionWithArr:(NSMutableArray *)arry index:(NSInteger)index
{
    //放大效果，并回到原位
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.3];     //结束伸缩倍数
    [[arry[index] layer] addAnimation:animation forKey:nil];
}





@end
