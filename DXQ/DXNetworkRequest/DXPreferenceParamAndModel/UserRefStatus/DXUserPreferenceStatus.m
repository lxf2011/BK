//
//  DXUserPreferenceModel.m
//  DXQ
//
//  Created by 做功课 on 15/8/25.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "DXUserPreferenceStatus.h"
#import "ZXOperatePlist.h"
#import "PrintObject.h"

#define userName [[NSUserDefaults standardUserDefaults]stringForKey:@"userName"]
#define fileName [NSString stringWithFormat:@"/%@.plist",userName]
#define filePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:fileName]

static NSMutableArray *_praiseStatus;

@implementation DXUserPreferenceStatus

+ (void)initialize{
    if(userName.length > 0)
    {
        
        _praiseStatus = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        NSLog(@"开始地址:%@",filePath);
        if (_praiseStatus == nil) {
            _praiseStatus = [NSMutableArray array];
        }
    }
    else{
        _praiseStatus = nil;
    }
}
+ (void)addPraiseStatus:(NSArray *)array{
    if (_praiseStatus) {
        [_praiseStatus removeObject:array];
        [_praiseStatus addObject:array];
        NSLog(@"保存地址:%@",filePath);
        [NSKeyedArchiver archiveRootObject:_praiseStatus toFile:filePath];
    }
    
}

+ (void)delPraiseStatus:(NSArray *)array{
    if (_praiseStatus) {
        [_praiseStatus removeObject:array];
        NSLog(@"删除地址:%@",filePath);
        [NSKeyedArchiver archiveRootObject:_praiseStatus toFile:filePath];
    }
}

+ (BOOL)isPraise:(NSArray *)array{
    for (NSArray *arr in _praiseStatus) {
        if ([array isEqualToArray:arr]) {
            return YES;
        }
    }
    return NO;
}

+ (NSUInteger)collectCount{
    NSUInteger count = 0;
    if (_praiseStatus) {
        for (NSArray *array in _praiseStatus) {
            if ([array containsObject:@"USR_MSG_COLLECT"] || [array containsObject:@"USR_ACT_COLLECT"] || [array containsObject:@"USR_SPC_COLLECT"]) {
                count += 1;
            }
        }
    }
    return count;
}

@end
