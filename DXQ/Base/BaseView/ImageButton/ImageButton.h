//
//  ImageButton.h
//  NanYueTong
//
//  Created by Mac on 15-7-4.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    leftImage = 0 ,
    rightImage ,
    topImage,
    bottomImage,
    
} buttonType;
@interface ImageButton : UIButton

@property (strong,nonatomic) UIImageView *buttonImage;
@property (strong,nonatomic) UILabel *buttonLabel;
-(instancetype)initWithFrame:(CGRect)frame withButtonType :(buttonType) type withImage:(UIImage*)image withTitle :(NSString *)title;
@end
