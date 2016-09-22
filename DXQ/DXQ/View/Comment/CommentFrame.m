//
//  CommentFrame.m
//  DXQ
//
//  Created by 做功课 on 15/8/17.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "CommentFrame.h"

@implementation CommentFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

- (void)setComment:(Comment *)comment{
    _comment = comment;
    
    
    /** 头像 */
    CGFloat iconWH = 35;
    CGFloat iconX = cellBorderW;
    CGFloat iconY = cellBorderW;
    self.headIconF = CGRectMake(iconX, iconY, iconWH, iconWH);
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.headIconF) + cellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:comment.userName font:userNameFont];
    self.userNameF = (CGRect){{nameX, nameY}, nameSize};
    /** 时间 */
    CGFloat timeY = cellBorderW;
    CGSize timeSize = [self sizeWithText:comment.time font:timeFont];
    CGFloat timeX = ScreenWidth - timeSize.width - cellBorderW;;
    self.timeF = (CGRect){{timeX, timeY}, timeSize};
    /** 内容 */
    CGFloat contentX = nameX;
    CGFloat contentY = CGRectGetMaxY(self.userNameF) + cellBorderW;
    CGFloat maxW = ScreenWidth - contentX - cellBorderW;
    CGSize contentSize = [self sizeWithText:comment.content font:contentFont];
    self.contentF = (CGRect){{contentX, contentY}, contentSize};
    
    /** 回复用户头像 */
    CGFloat replayIconWH = 20;
    CGFloat replyHeadIconX = nameX + cellBorderW;
    CGFloat replyHeadIconY = CGRectGetMaxY(self.contentF);
    self.replyHeadIconF = CGRectMake(replyHeadIconX, replyHeadIconY, replayIconWH, replayIconWH);
    /** 回复用户名 */
    CGFloat replayUserNameX = CGRectGetMaxX(self.replyUserNameF);
    CGFloat replayUserNameY = replyHeadIconY;
    CGSize replayUserNameSize = [self sizeWithText:comment.replyUserName font:replyUserNameFont];
    self.replyUserNameF = (CGRect){{replayUserNameX, replayUserNameY}, replayUserNameSize};
    /** 回复内容 */
    CGFloat replayContentY = MAX(CGRectGetMaxY(self.replyHeadIconF), CGRectGetMaxY(self.replyUserNameF));
    CGFloat replayContentX = replyHeadIconX;
    CGSize replayContentSize = [self sizeWithText:comment.replayContent font:replyContentFont];
    self.replayContentF = (CGRect){{replayContentX, replayContentY}, replayContentSize};
    
    /** cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.replayContentF) + cellBorderW;
    
}

@end
