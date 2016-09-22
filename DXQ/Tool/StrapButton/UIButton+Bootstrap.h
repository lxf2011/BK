//
//  UIButton+Bootstrap.h
//  UIButton+Bootstrap
//
//  Created by Oskar Groth on 2013-09-29.
//  Copyright (c) 2013 Oskar Groth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
@interface UIButton (Bootstrap)
- (void)addAwesomeIcon:(FAIcon)icon beforeTitle:(BOOL)before;
-(void)bootstrapStyle;
-(void)defaultStyle;
-(void)primaryStyle;
-(void)successStyle;
-(void)infoStyle;
-(void)warningStyle;
-(void)dangerStyle;

-(void)blueStyle;
-(void)nYOrangeColorStyle;
-(void)nYBlueColorStyle;
-(void)nYYZMColorStyle;
-(void)blueStyleWithFont:(UIFont*)font;

-(void)pinkRedStyle;
-(void)lightRedStyle;
-(void)redStyle;


-(void)grayStyle;
-(void)blackTransparentStyle;
-(void)greenStyle;
-(void)grayHighLightedStyle;
- (UIImage *) buttonImageFromColor:(UIColor *)color;

-(void)solidStyle;
@end
