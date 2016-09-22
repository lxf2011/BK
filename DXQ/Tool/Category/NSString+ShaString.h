//
//  NSString+ShaString.h
//  NanYueTong
//
//  Created by rason on 7/3/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ShaString)
- (NSString *)getSha1String:(NSString *)srcString;

//sha256加密方式
- (NSString *)getSha256String:(NSString *)srcString;

//sha384加密方式
- (NSString *)getSha384String:(NSString *)srcString;

//sha512加密方式
- (NSString*) getSha512String:(NSString*)srcString;

@end
