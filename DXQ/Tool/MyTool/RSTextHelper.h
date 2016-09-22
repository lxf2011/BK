//
//  TextHelper.h
//  mashangjia
//
//  Created by mac on 14-12-14.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#define TextHelperLeft 0
#define TextHelperRight 1
#define TextHelperUp 2
#define TextHelperDown 3
@interface RSTextHelper : NSObject
//获取文本在指定范围内的最小长宽
//[TextHelper getSizeFromFont:[UIFont fontWithName:@"helvetica neue" size:15] AndText:model1.title  AndViewSize:CGSizeMake(280, 0)]
+(CGSize)getSizeFromFont:(UIFont *)font AndText:(NSString *)content AndViewSize:(CGSize )viewSize;
+(CGSize)getSizeFromFont:(UIFont *)font AndText:(NSString *)content;//一行的计算方法
+(CGSize)getSizeFromFont:(UIFont *)font AndText:(NSString *)content AndMakeSizeBig:(float)big;//一行计算方法，在最小的Size上增大一点。背景看起来会好看些。
+(void)changeLabel:(UILabel *)label SizeBecomeBig:(float)big WithPosition:(float)position;
+(void)changeLabel:(UILabel *)label SizeBecomeBig:(float)big WithPosition:(float)position WithBackColor:(UIColor *)backcolor;
//使UILabel自动换行
+(void)labelHandleWithModeWordWrap:(UILabel *)label;
//使UILabel自动换行,根据固定的宽度
+(void)labelHandleWithModeWordWrap:(UILabel *)label WithWidth:(float)width;
//处理换行，并且计算增加的高度
+(CGFloat)getFloatFromLabel:(UILabel *)label;
@end
