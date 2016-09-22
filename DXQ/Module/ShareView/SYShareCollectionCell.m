//
//  SYShareCollectionCell.m
//  Rason-简单分享
//
//  Created by mac on 4/27/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "SYShareCollectionCell.h"

@implementation SYShareCollectionCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setContentWithName:(NSString *)name AndImageName:(NSString *)imageName{
    self.labelName.text = name;
    
    if([imageName rangeOfString:@"/"].location!=NSNotFound){
        UIImage *image2 = [UIImage imageWithContentsOfFile:imageName];
        self.imageView.image = image2;
    }
    self.imageView.image = [UIImage imageNamed:imageName];
}
@end
