//
//  DXLoginUserParam.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXRegisterUserParam : NSObject
// 用户名
@property (nonatomic, copy) NSString *LUSR;
// 密码
@property (nonatomic, copy) NSString *LPSW;

@property (nonatomic, copy) NSString *LSOCIALTYPE;

@end
