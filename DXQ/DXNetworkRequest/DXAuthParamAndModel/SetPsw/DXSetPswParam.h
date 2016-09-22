//
//  DXSetPswParam.h
//  DXQ
//
//  Created by rason on 15/12/1.
//  Copyright © 2015年 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXSetPswParam : NSObject
// 用户名
@property (nonatomic, strong) NSString *usr;
// 密码
@property (nonatomic, strong, getter=theNewPsw) NSString *newPsw;
// 密码
@property (nonatomic, strong) NSString *oldPsw;

@end
