//
//  UIView+FrankPlaceHolderView.m
//  FrankPlaceHolderView
//
//  Created by Frank on 2017/5/13.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "UIView+FrankPlaceHolderView.h"
#import <objc/runtime.h>

@interface UIView ()

/**
 占位图
 */
@property (nonatomic,strong)FrankPlaceHolderView * holderView;
/**
 如果存在 tableview 时 ，处理
 */
@property (nonatomic,assign)UITableViewCellSeparatorStyle tableViewSepStyle;

@end

@implementation UIView (FrankPlaceHolderView)

-(void)setHolderView:(FrankPlaceHolderView *)holderView{
    
    objc_setAssociatedObject(self, @selector(holderView), holderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(FrankPlaceHolderView *)holderView{
    
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setTableViewSepStyle:(UITableViewCellSeparatorStyle)tableViewSepStyle{
    
    
    objc_setAssociatedObject(self, @selector(tableViewSepStyle), nil, OBJC_ASSOCIATION_ASSIGN);
}
-(UITableViewCellSeparatorStyle)tableViewSepStyle{
    
    return (UITableViewCellSeparatorStyle)objc_getAssociatedObject(self, @selector(tableViewSepStyle));
}
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
                            completeReloadBtnClick:(void(^)())reloadButtonClickBlock{
    
    if (!self.holderView) {
        
        showImage = showImage?:[UIImage imageNamed:@"FrankPlaceHolder.bundle/暂无数据.png"];
        showDescribe = showDescribe ?:@"暂无数据";
        showReloadBtnTitle = showReloadBtnTitle ?:@"重新加载";
        
        if ([self isKindOfClass:[UIScrollView class]]) {

            [(UIScrollView *)self setScrollEnabled:NO];
            
            if ([self isKindOfClass:[UITableView class]]) {
                
                self.tableViewSepStyle = [(UITableView *)self separatorStyle];
                [(UITableView *)self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            }
            
        }
        
        FrankPlaceHolderView * holderView = [[FrankPlaceHolderView alloc] initWithFrame:(CGRect){0,0,self.frame.size.width,self.frame.size.height}];
        holderView.backgroundColor = [UIColor whiteColor];
        NSNumber * pos = @(position);

        
        // kvc 设置制度属性值
        [holderView setValue:showImage forKey:@"showImage"];
        [holderView setValue:showDescribe forKey:@"showDescribe"];
        [holderView setValue:showReloadBtnTitle forKey:@"showReloadBtnTitle"];
        [holderView setValue:reloadButtonClickBlock forKey:@"reloadButtonClickBlock"];
        [holderView setValue:pos forKey:@"btnPosition"];
        
        [self addSubview:holderView];
        [self bringSubviewToFront:holderView];
        self.holderView = holderView;
        
    }
}

/**
 隐藏占位视图
 */
-(void)hiddenPlaceHolderView{
    
    if (self.holderView) {
        [self.holderView removeFromSuperview];
        
        if ([self isKindOfClass:[UIScrollView class]]) {
            
            [(UIScrollView *)self setScrollEnabled:YES];
            
            if ([self isKindOfClass:[UITableView class]]) {
                
                [(UITableView *)self setSeparatorStyle:self.tableViewSepStyle];
            }
            
        }
        self.holderView = nil;
    }
}


@end


@interface FrankPlaceHolderView ()

/**
 展示图片
 */
@property (nonatomic,strong)UIImageView * imgView;
/**
 重载按钮
 */
@property (nonatomic,strong)UIButton * reloadBtn;
/**
 描述label
 */
@property (nonatomic,strong)UILabel * desLabel;

@end

@implementation FrankPlaceHolderView

/**
 KVC 监控一些不存在的键值
 */
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupViews];
    
}
/**
 配置视图
 */
-(void)setupViews{
    
    CGFloat height = self.bounds.size.height;
    
    CGFloat width = self.bounds.size.width;
    
    
    CGFloat imgWidth = width/2;
    
    if (width/height >= 1) {
        
        imgWidth = imgWidth*height*2/(width*3);
    }

    CGFloat imgHeight = self.showImage.size.height*imgWidth/self.showImage.size.width;
    
    UIImageView * imgView = [[UIImageView alloc] initWithImage:self.showImage];
    imgView.bounds = CGRectMake(0, 0, imgWidth, imgHeight);
    imgView.center = CGPointMake(self.center.x, self.center.y-CGRectGetHeight(imgView.bounds)/2);
    self.imgView = imgView;
    
    CGFloat font = 15.f*(self.bounds.size.width/[UIScreen mainScreen].bounds.size.width);
    
    CGRect r = [self.showDescribe boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds)-30,35) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    
    UILabel * desLabel = [[UILabel alloc] init];
    desLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds)-30, r.size.height);
    desLabel.center = CGPointMake(self.center.x, CGRectGetMaxY(imgView.frame) + CGRectGetHeight(desLabel.bounds) + 10);
    desLabel.numberOfLines = 2;
    desLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    desLabel.font = [UIFont systemFontOfSize:font];
    desLabel.text = self.showDescribe;
    desLabel.textAlignment = NSTextAlignmentCenter;
    self.desLabel = desLabel;
    
    UIButton * showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showBtn.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds)-60, 30);
    [showBtn setTitle:self.showReloadBtnTitle forState:UIControlStateNormal];
    [showBtn setBackgroundColor:[UIColor colorWithRed:49/255.0 green:194/255.0 blue:124/255.0 alpha:0.8]];
    [showBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    showBtn.titleLabel.font = [UIFont systemFontOfSize:font];
    
    switch ([self.btnPosition integerValue]) {
            
        case ReloadButtonPosition_ImgTop:
        {
            showBtn.center = CGPointMake(self.center.x,imgView.frame.origin.y - CGRectGetHeight(showBtn.bounds) - 10);

        }
            break;
        case ReloadButtonPosition_ImgButtom:
        {
            showBtn.center = CGPointMake(self.center.x,CGRectGetMaxY(desLabel.frame) + CGRectGetHeight(desLabel.bounds) + 10);
        }
            break;
        case ReloadButtonPosition_ViewBottom:
        {
            showBtn.center = CGPointMake(self.center.x,CGRectGetHeight(self.bounds) - CGRectGetHeight(showBtn.bounds) - 10);
        }
            break;
            
        default:
            break;
    }
    [showBtn addTarget:self action:@selector(reloadBtnClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.reloadBtn = showBtn;
    
    if ([self.btnPosition integerValue] != ReloadButtonPosition_None) {
        
        [showBtn.layer setCornerRadius:8.f];
        showBtn.layer.masksToBounds = YES;
        showBtn.layer.borderWidth = 0;
        UIColor *borderColor = [UIColor whiteColor];
        showBtn.layer.borderColor = borderColor.CGColor;
        
        [self addSubview:self.reloadBtn];
    }
    
    [self addSubview:self.imgView];
    [self addSubview:self.desLabel];
    
    
}
-(void)reloadBtnClickMethod:(UIButton *)btn{
    
    if (self.reloadButtonClickBlock) {
        self.reloadButtonClickBlock();
    }
    
}


@end
