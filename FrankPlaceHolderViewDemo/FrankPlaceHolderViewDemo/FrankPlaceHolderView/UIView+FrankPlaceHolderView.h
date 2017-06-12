//
//  UIView+FrankPlaceHolderView.h
//  FrankPlaceHolderView
//
//  Created by Frank on 2017/5/13.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 刷新按钮位置样式

 - ReloadButtonPosition_None: 不显示重载按钮
 - ReloadButtonPosition_ImgTop: 重载按钮在图片上方
 - ReloadButtonPosition_ImgButtom: 重载按钮在图片下方
 - ReloadButtonPosition_ViewBottom: 重载按钮在视图底部
 */
typedef NS_ENUM(NSInteger,ReloadButtonPosition) {
    
    ReloadButtonPosition_None = 0,
    ReloadButtonPosition_ImgTop,
    ReloadButtonPosition_ImgButtom,
    ReloadButtonPosition_ViewBottom,

};



@interface UIView (FrankPlaceHolderView)

/**
 添加占位视图

 @param position 重载按钮位置
 @param showImage 展示占位图片
 @param showDescribe 展示占位提示文字
 @param showReloadBtnTitle 重载按钮提示文字
 @param reloadButtonClickBlock 重载按钮点击之后回调
 */
-(void)showPlaceHolderViewWithReloadButtonPosition:(ReloadButtonPosition)position
                                         showImage:(UIImage *)showImage
                                      showDescribe:(NSString *)showDescribe
                                showReloadBtnTitle:(NSString *)showReloadBtnTitle
                            completeReloadBtnClick:(void(^)())reloadButtonClickBlock;

/**
 隐藏占位视图
 */
-(void)hiddenPlaceHolderView;

@end

#pragma mark --------- 占位图具体元素

@interface FrankPlaceHolderView : UIView

/**
 按钮展示位置
 */
@property (nonatomic,assign,readonly)NSNumber * btnPosition;
/**
 重载按钮点击之后的回调
 */
@property (nonatomic,copy,readonly)void(^reloadButtonClickBlock)();

/**
 展示的展位图片
 */
@property (nonatomic,strong,readonly)UIImage * showImage;
/**
 展示的提示文字
 */
@property (nonatomic,copy,readonly)NSString * showDescribe;
/**
 展示的按钮提示文字
 */
@property (nonatomic,copy,readonly)NSString * showReloadBtnTitle;


@end
