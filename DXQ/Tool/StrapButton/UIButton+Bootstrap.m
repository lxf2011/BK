//
//  UIButton+Bootstrap.m
//  UIButton+Bootstrap
//
//  Created by Oskur on 2013-09-29.
//  Copyright (c) 2013 Oskar Groth. All rights reserved.
//
#import "UIButton+Bootstrap.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIButton (Bootstrap)

-(void)bootstrapStyle{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
}

-(void)defaultStyle{
    [self bootstrapStyle];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)primaryStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:66/255.0 green:139/255.0 blue:202/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:53/255.0 green:126/255.0 blue:189/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:51/255.0 green:119/255.0 blue:172/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)successStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:92/255.0 green:184/255.0 blue:92/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:76/255.0 green:174/255.0 blue:76/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:69/255.0 green:164/255.0 blue:84/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)infoStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:91/255.0 green:192/255.0 blue:222/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:70/255.0 green:184/255.0 blue:218/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:57/255.0 green:180/255.0 blue:211/255.0 alpha:1]] forState:UIControlStateHighlighted];
}
//75 139 216   25 89 166
-(void)blueStyle{
    [self bootstrapStyle];
    self.layer.borderWidth = 0;
    self.layer.cornerRadius = 3.0;
    UIColor* blue = [UIColor colorWithRed:0.31 green:0.55 blue:0.84 alpha:1];
    self.layer.borderColor = [blue CGColor];
    self.backgroundColor = blue;

    [self setBackgroundImage:[self buttonImageFromColor:blue] forState:UIControlStateNormal];
        [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:0 green:0.36 blue:0.64 alpha:140/255.0]] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:143/255.0 green:143/255.0 blue:143/255.0 alpha:255/255.0]] forState:UIControlStateDisabled];
}


-(void)grayHighLightedStyle{
    [self bootstrapStyle];
    self.layer.borderWidth = 0;
    self.layer.cornerRadius = 0;

    
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:100/255.0] ] forState:UIControlStateHighlighted];
    
    
}
//默认的#ffF35859
//按下去的color="#ffbd2424"
//背景的="#ffF35859"
-(void)pinkRedStyle{
    [self bootstrapStyle];
    self.layer.borderWidth = 0;
    self.layer.cornerRadius = 3.0;
    self.backgroundColor = [UIColor colorWithRed:243/255.0 green:89/255.0 blue:115/255.0 alpha:1];
   self.layer.borderColor = [[UIColor colorWithRed:243/255.0 green:89/255.0 blue:115/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:189/255.0 green:36/255.0 blue:36/255.0 alpha:1]] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:243/255.0 green:89/255.0 blue:115/255.0 alpha:1]] forState:UIControlStateNormal];

}
-(void)lightRedStyle{
    [self bootstrapStyle];
    self.layer.borderWidth =0;
    self.layer.cornerRadius = 2.5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:237/255.0 green:96/255.0 blue:89/255.0 alpha:173/255.0];
    self.layer.borderColor = [[UIColor colorWithRed:237/255.0 green:96/255.0 blue:89/255.0 alpha:173/255.0] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:237/255.0 green:96/255.0 blue:89/255.0 alpha:173/255.0]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:237/255.0 green:96/255.0 blue:89/255.0 alpha:173/255.0]] forState:UIControlStateDisabled];
}

-(void)redStyle{
    [self bootstrapStyle];
    self.layer.borderWidth =0;
    self.layer.cornerRadius = 2.5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:0.9 green:0.18 blue:0.23 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:0.9 green:0.18 blue:0.23 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:0.9 green:0.18 blue:0.23 alpha:1]] forState:UIControlStateNormal];
    
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:0.76 green:0.23 blue:0.27 alpha:1]] forState:UIControlStateHighlighted];
    
}


-(void)grayStyle{
    [self bootstrapStyle];
    self.layer.borderWidth =0;
    self.layer.cornerRadius = 2.5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:221/255.0];
    self.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:221/255.0] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:221/255.0]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:221/255.0]] forState:UIControlStateDisabled];
    
}
-(void)blackTransparentStyle{
   
    self.layer.borderWidth =0;
    self.layer.cornerRadius = 0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:92/255.0 green:97/255.0 blue:100/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:92/255.0 green:97/255.0 blue:100/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:92/255.0 green:97/255.0 blue:100/255.0 alpha:1]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:79/255.0 green:83/255.0 blue:85/255.0 alpha:1]] forState:UIControlStateHighlighted];
    
}
-(void)greenStyle{
    [self bootstrapStyle];
    self.layer.borderWidth =0;
    self.layer.cornerRadius = 2.5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:40/255.0 green:172/255.0 blue:51/255.0 alpha:173/255.0];
    self.layer.borderColor = [[UIColor colorWithRed:40/255.0 green:172/255.0 blue:51/255.0 alpha:173/255.0] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:40/255.0 green:172/255.0 blue:51/255.0 alpha:1]] forState:UIControlStateNormal];
        [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:0/255.0 green:132/255.0 blue:11/255.0 alpha:1]] forState:UIControlStateHighlighted];
    
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:40/255.0 green:172/255.0 blue:51/255.0 alpha:1]] forState:UIControlStateDisabled];
    
    
    
}

-(void)solidStyle
{
    [self setAdjustsImageWhenHighlighted:NO];
    
    self.layer.borderWidth =0;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.masksToBounds = YES;
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:50/255.0]] forState:UIControlStateHighlighted];


}






-(void)warningStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:173/255.0 blue:78/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:238/255.0 green:162/255.0 blue:54/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:237/255.0 green:155/255.0 blue:67/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)dangerStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:217/255.0 green:83/255.0 blue:79/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:212/255.0 green:63/255.0 blue:58/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:210/255.0 green:48/255.0 blue:51/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

- (void)addAwesomeIcon:(FAIcon)icon beforeTitle:(BOOL)before
{
    NSString *iconString = [NSString stringFromAwesomeIcon:icon];
    self.titleLabel.font = [UIFont fontWithName:@"FontAwesome"
                                           size:self.titleLabel.font.pointSize];
    
    NSString *title = [NSString stringWithFormat:@"%@", iconString];
    
    if(self.titleLabel.text) {
        if(before)
            title = [title stringByAppendingFormat:@" %@", self.titleLabel.text];
        else
            title = [NSString stringWithFormat:@"%@  %@", self.titleLabel.text, iconString];
    }
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
