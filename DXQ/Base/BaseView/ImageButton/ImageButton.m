//
//  ImageButton.m
//  NanYueTong
//
//  Created by Mac on 15-7-4.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ImageButton.h"

@implementation ImageButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame withButtonType :(buttonType) type withImage:(UIImage*)image withTitle :(NSString *)title
{
    self = [super initWithFrame:frame];
    float width = frame.size.width;
    float height = frame.size.height;
    if(type == leftImage)
    {
        self.buttonImage = [[UIImageView alloc]init];
        self.buttonLabel = [[UILabel alloc]init];
        self.buttonImage.frame = CGRectMake(0, height*0.35, height*0.4, height*0.3);
        [self.buttonImage setImage:image];
        self.buttonLabel.frame = CGRectMake(height *0.5, height*0.2, width*0.6, height*0.6);
        self.buttonLabel.text = title;
        self.buttonLabel.font = DXNavFont;
        self.buttonLabel.textColor = [UIColor whiteColor];
        [self addSubview:_buttonImage];
        [self addSubview:_buttonLabel];
    }
    return self;

}

@end
