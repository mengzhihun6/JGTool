//
//  JGNavigationController.m
//  JGTool
//
//  Created by 郭军 on 2019/6/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JGNavigationController.h"
#import "JGBaseViewController.h"

@interface JGNavigationController() <UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@end


@implementation JGNavigationController


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //    JGLog(@"------>%@",otherGestureRecognizer.delegate);
    
    if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"UICollectionView")]) {
        UICollectionView *cv = (UICollectionView *)otherGestureRecognizer.delegate;
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)cv.collectionViewLayout;
        if (flowLayout.scrollDirection==UICollectionViewScrollDirectionHorizontal) {
            if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan &&cv.contentOffset.x>0) {
                return NO;
            }else if(otherGestureRecognizer.state == UIGestureRecognizerStateBegan &&cv.contentOffset.x<=0){
                return YES;
            }
        }else{
            if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan &&cv.contentOffset.x>0) {
                return YES;
            }else if(otherGestureRecognizer.state == UIGestureRecognizerStateBegan &&cv.contentOffset.x<=0){
                return NO;
            }
        }
        return YES;
    }else if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]){
        return YES;
    }else if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]){
        return YES;
    }
    return NO;
}

//  防止导航控制器只有一个rootViewcontroller时触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    //解决与左滑手势冲突
    CGPoint translation = [self.panGesture translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    if (self.childViewControllers.count > 1) {
        BOOL shouldBeginGesture = NO;
        
        if ([self.topViewController isKindOfClass:[JGBaseViewController class]]) {
            JGBaseViewController *currentVC = (JGBaseViewController *)self.topViewController;
            
            if (currentVC.isHideBackItem == YES) {
                return NO;
            }else {
                if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin)]) {
                    shouldBeginGesture = [currentVC gestureRecognizerShouldBegin];
                    return shouldBeginGesture;
                }
            }
        }else{
            return YES;
        }
    }
    return self.childViewControllers.count == 1 ? NO : YES;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor colorWithHexCode:@"#333333"]}];
    
    //    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexCode:@"#333333"]];
    
    //处理全屏返回
    UIGestureRecognizer *systemGes = self.interactivePopGestureRecognizer;
    id target =  systemGes.delegate;
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.panGesture];
    self.panGesture.delegate = self;
    systemGes.enabled = NO;


}



-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;//处理隐藏tabbar
        
        
        if ([viewController isKindOfClass:[JGBaseViewController class]]) {
            JGBaseViewController *vc = (JGBaseViewController *)viewController;
            if (vc.isHideBackItem == YES) {
                vc.navigationItem.hidesBackButton = YES;
            }else{
                //给push的每个VC加返回按钮
                NSString *imageName = [vc backItemImageName];
                vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:imageName highIcon:@"no" target:self action:@selector(back:)];
            }
        } else{
            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigator_btn_back" highIcon:@"no" target:self action:@selector(back:)];
        }
        
    }else{
        
        
    }
    [super pushViewController:viewController animated:animated];
    
}
-(void)back:(UIBarButtonItem *)sender{
    [self.view endEditing:YES];
    
    UIViewController * currentVC = self.topViewController;
    if (currentVC.popBlock) {
        currentVC.popBlock(sender);
    }else{
        [self popViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
