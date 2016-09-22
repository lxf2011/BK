//
//  GetOrgMsgsItemModel.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXGetOrgMsgsItemInfoModel.h"
#import "DXGetOrgMsgsMsgModel.h"
#import "DXGetOrgMsgsActModel.h"
@interface DXGetOrgMsgsItemModel : NSObject

@property (nonatomic, strong) DXGetOrgMsgsItemInfoModel *OrgInfo;
// 消息
@property (nonatomic, strong) DXGetOrgMsgsMsgModel *Msg;
// 活动
@property (nonatomic, strong) DXGetOrgMsgsActModel *Act;

@end
