//
//  TextHelper.m
//  mashangjia
//
//  Created by mac on 14-12-14.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "RSTextHelper.h"

@implementation RSTextHelper
+(CGSize)getSizeFromFont:(UIFont *)font AndText:(NSString *)content AndViewSize:(CGSize )viewSize{
    int version=   [[[UIDevice currentDevice] systemVersion] intValue];
    if(version==6)
    {
    
       CGSize size =  [content sizeWithFont:font constrainedToSize:CGSizeMake(viewSize.width, 20000.0f)  lineBreakMode:NSLineBreakByCharWrapping];
        return size;
    }
    else
    {
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = [content boundingRectWithSize:CGSizeMake(viewSize.width, 20000.0f) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        return size;
    }
    
}
+(CGSize)getSizeFromFont:(UIFont *)font AndText:(NSString *)content{
    return [self getSizeFromFont:font AndText:content AndViewSize:CGSizeMake(20000.0f, 20000.0f)];
}
+(CGSize)getSizeFromFont:(UIFont *)font AndText:(NSString *)content AndMakeSizeBig:(float)big{
    CGSize size = [self getSizeFromFont:font AndText:content AndViewSize:CGSizeMake(20000.0f, 20000.0f)];
    size.width += big;
    size.height +=big;
    return size;
}


+(void)changeLabel:(UILabel *)label SizeBecomeBig:(float)big WithPosition:(float)position{
    //记录开始的x,y位置
    float left = label.frame.origin.x +label.frame.size.width;//label的右端距离左边位置
    CGSize size = [self getSizeFromFont:label.font AndText:label.text AndMakeSizeBig:big];
    //修改label的x
    CGRect frame = label.frame;
    frame.origin.x = left - size.width;
    frame.size = size;
    label.frame = frame;
}
+(void)changeLabel:(UILabel *)label SizeBecomeBig:(float)big WithPosition:(float)position WithBackColor:(UIColor *)backcolor{
    [self changeLabel:label SizeBecomeBig:big WithPosition:position];
    label.backgroundColor = [UIColor clearColor];
    label.layer.backgroundColor=[backcolor CGColor];
}
+(void)labelHandleWithModeWordWrap:(UILabel *)label{
    [label setNumberOfLines:0];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    //设置自动行数与字符换行
    CGRect frame = label.frame;
    frame.size = [self getSizeFromFont:label.font AndText:label.text AndViewSize:label.frame.size ];
    label.frame = frame;
}
+(void)labelHandleWithModeWordWrap:(UILabel *)label WithWidth:(float)width{
    [label setNumberOfLines:0];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    //设置自动行数与字符换行
    CGRect frame = label.frame;
    frame.size = CGSizeMake(width, frame.size.height);
    frame.size = [self getSizeFromFont:label.font AndText:label.text AndViewSize:frame.size];
    label.frame = frame;
    label.backgroundColor = [UIColor clearColor];
    label.layer.borderWidth = 0;
}
+(CGFloat)getFloatFromLabel:(UILabel *)label{
    CGFloat height = label.frame.size.height;
    [self labelHandleWithModeWordWrap:label];
    return label.frame.size.height - height;
}
@end
