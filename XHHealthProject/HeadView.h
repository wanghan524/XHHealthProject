//
//  HeadView.h
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/28.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol headerImageClickDelegate <NSObject>

- (void)headerImageViewClick;

@end

@interface HeadView : UIView
@property(nonatomic,strong)UIImageView *headImgView;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *card;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIImageView *indicatorImgView;
@property (nonatomic , weak)id<headerImageClickDelegate>delegate;






@end
