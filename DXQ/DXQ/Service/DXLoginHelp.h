//
//  DXLoginHelp.h
//  DXQ
//
//  Created by rason on 8/14/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXLoginUserModel.h"
@interface DXLoginHelp : NSObject
@property (nonatomic, strong) DXLoginUserReallyModel *loginUser;
@property (nonatomic,strong)NSString  *userName;
@property (nonatomic,strong)NSString  *passWord;
@property (nonatomic,strong)NSString  *nickName;
@property (nonatomic,strong)NSString  *sex;
@property (nonatomic,strong)NSString  *school;
@property (nonatomic,strong)NSString  *head;
@property (nonatomic,strong)NSString  *phone;
+(void)restoreState:(void(^)())sucess :(void(^)())fail;//恢复登陆状态
+(BOOL)canRestoreState;//判断是否可以恢复登陆
+(void)login:(void(^)())sucess :(void(^)())fail;//登陆
+(void)cancelLogin:(void(^)())sucess :(void(^)())fail;//取消登录
+ (DXLoginHelp *)sharedInstance;
-(void)postNotificationName:(NSString *)name;
@end
