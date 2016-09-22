//
//  SYShareCollectionCell.h
//  Rason-简单分享
//
//  Created by mac on 4/27/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYShareCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
-(void)setContentWithName:(NSString *)name AndImageName:(NSString *)imageName;
@end
