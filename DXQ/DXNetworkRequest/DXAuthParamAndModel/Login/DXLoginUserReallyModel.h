//
//  DXLoginUserReallyModel.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXLoginUserDetailModel.h"
@interface DXLoginUserReallyModel : NSObject

@property (nonatomic, strong) NSArray *ATTR;

@property (nonatomic, assign) NSInteger LSTATUS;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *LUSR;

@property (nonatomic, copy) NSString *ADD1;

@property (nonatomic, copy) NSString *LTIME;

@property (nonatomic, copy) NSString *LIDENTIFY;

@property (nonatomic, copy) NSString *ADD2;

@property (nonatomic, copy) NSString *LSOCIALTYPE;

@property (nonatomic, copy) NSString *LPSW;

@end
