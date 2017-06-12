//
//  ViewController.m
//  FrankPlaceHolderViewDemo
//
//  Created by Frank on 2017/6/12.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "ViewController.h"
#import "UIView+FrankPlaceHolderView.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *smallView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
    

}
- (IBAction)smallViewBtnClick:(id)sender {
    
    [self.smallView showPlaceHolderViewWithReloadButtonPosition:ReloadButtonPosition_ImgButtom
                                                      showImage:nil
                                                   showDescribe:@"这是提示文字"
                                             showReloadBtnTitle:@"这是按钮标题"
                                         completeReloadBtnClick:^{
        
        [self.smallView hiddenPlaceHolderView];
        
    }];
    
}
- (IBAction)bigBtnClickMethod:(id)sender {
    
    [self.view showPlaceHolderViewWithReloadButtonPosition:ReloadButtonPosition_ImgButtom
                                                 showImage:nil
                                              showDescribe:nil
                                        showReloadBtnTitle:nil
                                    completeReloadBtnClick:^{
        
        [self.view hiddenPlaceHolderView];
        
    }];
}






@end
