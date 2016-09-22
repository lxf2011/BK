//
//  DXQHeader.h
//  DXQ
//
//  Created by rason on 7/21/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#ifndef DXQ_DXQHeader_h
#define DXQ_DXQHeader_h

//定义屏幕比例
#define ScreenRatio [UIScreen mainScreen].bounds.size.width/320
//定义屏幕宽度,高度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//分割线颜色
#define DXColorSeparator [UIColor colorWithString:@"#e2e2e2"]
//输入框横线
#define DXColorLine [UIColor colorWithString:@"#cccccc"]
//深蓝
#define DXColorBlueDark [UIColor colorWithString:@"#4B89DC"]
//白色
#define DXColorWhite [UIColor whiteColor]
//亮蓝
#define DXColorBlueLight [UIColor colorWithString:@"#66AFFF"]
//粉红
#define DXColorPink [UIColor colorWithString:@"#FF4D63"]
//深灰
#define DXColorGrayDark [UIColor colorWithString:@"#4D4D4D"]
//中灰
#define DXColorGrayMiddle [UIColor colorWithString:@"#808080"]
//浅灰
#define DXColorGrayLight [UIColor colorWithString:@"#B3B3B3"]
//找回密码上面的提示条
#define DXColorFindPwd [UIColor colorWithString:@"#A0C7E0"]

//导航栏字体大小
#define DXNavFont [UIFont boldSystemFontOfSize:16]

// app key
#define ShareSDKAPPkey @"5b2655c71290"
#define UMAPPKey @"55fe5f3f67e58e75980045f2"//已更新
#define QQAPPKey @"1104774317"//已更新
#define WXAPPKey @"wxc0ec2d9be2f8068f"//已更新
#define WBAPPKey @"4209985830"//已更新
// app secret
#define ShareSDKAPPSecret @"55988074b9a3faadffa6f74cd3ae7845"
#define QQAPPSecret @"Rw3yApX22aRrhx5d"//已更新
#define WXAPPSecret @"9cbfc29c024a618310e0c81a28113106"
#define WBAPPSecret @"24900875218719178a514417a3af81be"//已更新


#define ServiceName @"com.imphoton.ainibook"//已更新

//#define DXNetworkAddress @"http://120.25.126.2:9090"
//新服务器地址，上线用
#define DXNetworkAddress @"http://www.ainibook.com"

#define kNotificationLeftViewController @"NotificationLeftViewController"
// 修改个人信息
#define kNotificationModifyPersonIfno @"NotificationModifyPersonIfno"
#define kNotificationPreferenceStatusChange @"NotificationLoginStatusChange"
#define kNotificationLoginChange @"NotificationLoginChange"
#define kNotificationCollectStatusChange @"NotificationCollectStatusChange"
#define kNotificationSchoolNameChange @"NotificationSchoolNameChange"
#define kNotificationUpdateShareInfo @"NotificationUpdateShareInfo"
#ifdef DEBUG
#define DXLog(...) NSLog(__VA_ARGS__)
#else 
#define DXLog(...)
#endif

#endif
