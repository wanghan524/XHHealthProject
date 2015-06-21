//
//  Define.h
//  YRProject
//
//  Created by art_kernel_zyc on 14/12/16.
//  Copyright (c) 2014年 豆豆豆. All rights reserved.
//

#ifndef YRProject_Define_h
#define YRProject_Define_h



//MsgId 定义
#define MSGID(dic) ([[(dic) objectForKey:@"MsgId"] isEqualToString:@"1"] && ([(dic) objectForKey:@"MsgId"] != nil))

//版本
#define CD(x) ([[UIDevice currentDevice].systemVersion floatValue] >= (x))
#define CD_X(z) ([[UIDevice currentDevice].systemVersion floatValue] == (z))
// Dlog
#if DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(fmt, ...)
#endif



//定义屏幕宽高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


//定义Nav高度
#define NAVIGATIONHEIGHT ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7?20:0)


//定义checkoutcell高度
#define CheckOutCellHeight 70.0f

//定义颜色
#define COLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define NAVColor COLOR(107.f, 180.f, 109.f, 1.f)


#define MAX_WIDTH(A,B) (((A)>(B))?(A):(B))
#define MIN_WIDTH(A,B) (((A)>(B))?(B):(A))


#endif
