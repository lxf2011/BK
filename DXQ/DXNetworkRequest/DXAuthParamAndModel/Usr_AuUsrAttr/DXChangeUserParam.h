//
//  DXChangeUserParam.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXChangeUserParam : NSObject
//LKEY：键值head：头像 school：学校  sex：性别 nickName：昵称
//LSVAL：对应对值
@property (nonatomic, copy) NSString *LID;//用户的ID

@property (nonatomic, copy) NSString *LKEY;

@property (nonatomic, copy) NSString *LSVALUE;

@property (nonatomic, copy) NSString *LOTYPE;

@property (nonatomic, copy) NSString *LTYPE;
@end
