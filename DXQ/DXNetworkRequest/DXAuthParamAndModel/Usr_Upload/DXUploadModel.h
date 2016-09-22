//
//  DXUploadModel.h
//  DXQ
//
//  Created by rason on 9/2/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXPublicModel.h"
#import "DXUploadReallyModel.h"
@interface DXUploadModel : DXPublicModel
@property (nonatomic, strong) DXUploadReallyModel *data;
@end
