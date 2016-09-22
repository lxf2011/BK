//
//  DXUploadReallyModel.h
//  DXQ
//
//  Created by rason on 9/2/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXPublicModel.h"

@interface DXUploadReallyModel : DXPublicModel
@property (nonatomic, copy) NSString *LFNAME;

@property (nonatomic, copy) NSString *LFSIZE;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *LMD5;

@property (nonatomic, assign) NSInteger LUID;

@property (nonatomic, copy) NSString *ADD1;

@property (nonatomic, copy) NSString *LTIME;

@property (nonatomic, copy) NSString *ADD2;

@property (nonatomic, copy) NSString *LEXT;
@end
