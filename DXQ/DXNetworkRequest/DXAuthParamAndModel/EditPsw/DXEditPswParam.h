//
//  DXEditPswParam.h
//  DXQ
//
//  Created by rason on 9/2/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXEditPswParam : NSObject
// 用户名
@property (nonatomic, copy) NSString *LUSR;
// 密码
@property (nonatomic, copy) NSString *LPSW;
+ (DXEditPswParam *)sharedInstance;
@end
