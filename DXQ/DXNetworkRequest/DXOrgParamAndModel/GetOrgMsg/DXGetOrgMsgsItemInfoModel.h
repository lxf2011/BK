//
//  GetOrgMsgsItemInfoModel.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXGetOrgMsgsLoidModel.h"
@interface DXGetOrgMsgsItemInfoModel : NSObject

@property (nonatomic, assign) NSInteger LTARID;

@property (nonatomic, assign) NSInteger LSTATUS;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *LTYPE;

@property (nonatomic, copy) NSString *ADD1;

@property (nonatomic, strong) DXGetOrgMsgsLoidModel *LOID;

@property (nonatomic, copy) NSString *LTIME;

@property (nonatomic, copy) NSString *ADD2;

@end
