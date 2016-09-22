//
//  DXCfg.h
//  DXQ
//
//  Created by rason on 15/9/19.
//  Copyright © 2015年 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXCfg : NSObject
+(void)saveStringWithKey:(NSString *)key value:(NSString *)value;
+(void)saveObjectWithKey:(NSString *)key value:(NSObject *)value;
+(NSString *)readStringForKey:(NSString *)key;
+(NSString *)readObjectForKey:(NSString *)key;
@end
