//
//  NYReturnPublicParam.m
//  nanyuetongiOS
//
//  Created by RoKingsly on 15/6/29.
//  Copyright (c) 2015年 RoKingsly. All rights reserved.
//

#import "DXPublicModel.h"
#import "RSFileHelp.h"
#import "MJExtension.h"
#import "PrintObject.h"
@implementation DXPublicModel
+(DXPublicModel *)moni{
    NSString *str =  NSStringFromClass([self class]);
    NSString *fileName = [str stringByAppendingString:@".json"];
    NSString *modelStr = [RSFileHelp getStringFromFile:fileName];
    DXPublicModel *result = [[self class] objectWithKeyValues:modelStr];
    return result;
}
+(void)test{
    NSString *str = [RSFileHelp getStringFromFile:@"TestModel.json"];
    NSArray *arr = [str componentsSeparatedByString:@"\n"];
    for (NSString *className in arr) {
        NSString *str =  className;
        NSString *fileName = [str stringByAppendingString:@".json"];
        NSString *modelStr = [RSFileHelp getStringFromFile:fileName];
        DXPublicModel *result = [[NSClassFromString(str) class] objectWithKeyValues:modelStr];
        NSLog(@"%@",[PrintObject getObjectData:result]);
    }
}
@end
