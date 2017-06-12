# FrankPlaceHolderView


在开发过程中，或遇到一些特殊情况：比如网络异常、服务器异常或者没有数据时，就需要在视图界面上进行配置空白占位页处理，为了便于使用，所以本Demo是对这个小功能进行了一个封装：

#####功能点说明：

######（1）功能实用：

占位图中封装了 UIImage、UILabel、UIButton三种控件，比较符合用户的常用习惯，并且可以根据枚举类型，配置按钮的位置样式，并且支持按钮block回调操作

######（2）调用简单

结合`runtime`将该功能封装成 UIView 的一个分类，使用调用时只需要导入头文件` #import "UIView+FrankPlaceHolderView.h"`,UIView或其子类对象就可以直接调用方法

######（3）支持页面元素配置

方法调用的时候，可以直接配置图片、文字、按钮等占位元素，并且元素的大小会通过页面进行自适应缩放

#####代码如下：

```
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

```
