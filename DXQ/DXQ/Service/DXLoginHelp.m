//
//  DXLoginHelp.m
//  DXQ
//
//  Created by rason on 8/14/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXLoginHelp.h"
#import "DXAuthTool.h"
#import "SFHFKeychainUtils.h"
#import "RFHttpTool.h"
@implementation DXLoginHelp
+(void)restoreState:(void(^)())sucess :(void(^)())fail
{
    NSString *userName = [[NSUserDefaults standardUserDefaults]stringForKey:@"userName"];
    if(userName.length>0)
    {
        DXLoginHelp *dXLoginHelp = [self sharedInstance];
        dXLoginHelp.userName = userName;
        dXLoginHelp.passWord = [SFHFKeychainUtils getPasswordForUsername:userName andServiceName:ServiceName error:nil];
        [DXUserParam sharedInstance].LUSR = dXLoginHelp.userName;
        [DXUserParam sharedInstance].LPSW = dXLoginHelp.passWord;
        [self  login:^{
            sucess();
        } :^{
            fail();
        }];
    }
}
-(NSString *)head{
    if (_head==nil) {
        _head = @"";
    }
    return _head;
}
+(BOOL)canRestoreState{
    NSString *userName = [[NSUserDefaults standardUserDefaults]stringForKey:@"userName"];
    if(userName.length>0)
    {
        return YES;
    }
    else{
        return YES
        ;
    }
}
-(void)saveWithPassWord:(NSString *)passwordNew{
    /*****此处代码不能取出*****/
    //从NSUserDefaults中获取用户名
    NSString *userName = [[NSUserDefaults standardUserDefaults]stringForKey:@"userName"];
    if(userName.length>0)
    {
        //删除用户
        [SFHFKeychainUtils deleteItemForUsername:userName andServiceName:ServiceName error:nil];
        
        /*****登录成功则存储账户密码*****/
        [SFHFKeychainUtils storeUsername:userName andPassword:passwordNew forServiceName:ServiceName updateExisting:YES  error:nil];
    }else
    {
        [SFHFKeychainUtils storeUsername:userName andPassword:passwordNew forServiceName:ServiceName updateExisting:YES  error:nil];
    }
}

+(void)login:(void(^)())sucess :(void(^)())fail{
    [DXAuthTool postLoginWithParams:[DXUserParam sharedInstance] success:^(DXLoginUserModel *result){
        [self sharedInstance].loginUser = result.data;
        //保存用户名到NSUserDefaults
        [[NSUserDefaults standardUserDefaults]setValue:[DXUserParam sharedInstance].LUSR forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[self sharedInstance] saveWithPassWord:[DXUserParam sharedInstance].LPSW];
        
        //获取用户属性
        DXLoginUserReallyModel *model = [self sharedInstance].loginUser;
        if (model!=nil) {
            NSArray *addr = model.ATTR;
            for (DXLoginUserDetailModel *model in addr) {
                if ([model.LKEY isEqualToString:@"nickName"]) {
                    [self sharedInstance].nickName = model.LSVALUE;                }
                if ([model.LKEY isEqualToString:@"school"]) {
                    [self sharedInstance].school = model.LSVALUE;
                }
                if ([model.LKEY isEqualToString:@"sex"]) {
                    [self sharedInstance].sex = model.LSVALUE;
                }
                if ([model.LKEY isEqualToString:@"head"]) {
                    [self sharedInstance].head = model.LSVALUE;
                }
                if ([model.LKEY isEqualToString:@"phone"]) {
                    [self sharedInstance].phone = model.LSVALUE;
                }
                // 第三方
                if ([model.LKEY isEqualToString:@"score"]) {
                   [self sharedInstance].nickName =  [DXUserParam sharedInstance].LUSR;
                    [self sharedInstance].head = [[NSUserDefaults standardUserDefaults] objectForKey:@"iconUrl"];
                    [self sharedInstance].sex = [[NSUserDefaults standardUserDefaults] objectForKey:@"sex"];
                }
            }
        }
        
        // 发送通知，改变点赞等按钮的状态
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPreferenceStatusChange object:nil];
        //发送通知，更新左边界面
//        [[self sharedInstance] postNotificationName:kNotificationLeftViewController];
        sucess();
    } failure:^(NSError *error) {
        fail();
        NSLog(@"自动登录失败");
    }];
}
+(void)cancelLogin:(void(^)())sucess :(void(^)())fail{
    
    [RFHttpTool get:[NSString stringWithFormat:@"%@/%@", DXNetworkAddress, @"appLogout"] params:nil success:^(id success) {
        [self sharedInstance].loginUser = nil;
        [self sharedInstance].nickName = nil;
        [self sharedInstance].school = nil;
        [self sharedInstance].sex = nil;
        [self sharedInstance].head = nil;
        
        NSString *userName = [[NSUserDefaults standardUserDefaults]stringForKey:@"userName"];
        if(userName.length>0)
        {
            //删除用户
            [SFHFKeychainUtils deleteItemForUsername:userName andServiceName:ServiceName error:nil];
        }
        [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"userName"];
        sucess();
    } failure:^(NSError *error) {
        fail();
    }];

    //发送通知，更新左边界面
//    [[self sharedInstance] postNotificationName:kNotificationLeftViewController];
}
+ (DXLoginHelp *)sharedInstance {
    static DXLoginHelp *sharedInstance = nil;
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}
-(void)postNotificationName:(NSString *)name{
    [[NSNotificationCenter defaultCenter]postNotificationName:name object:nil];
}
@end
