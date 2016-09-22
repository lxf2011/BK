//
//  DXLoginUserReallyModel.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXRegisterUserReallyModel : NSObject

@property (nonatomic, assign) NSInteger LSTATUS;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *LUSR;

@property (nonatomic, copy) NSString *ADD1;

@property (nonatomic, copy) NSString *LTIME;
//用户角色
@property (nonatomic, copy) NSString *LIDENTIFY;

@property (nonatomic, copy) NSString *ADD2;

@property (nonatomic, copy) NSString *LSOCIALTYPE;

@property (nonatomic, copy) NSString *LPSW;

@end
