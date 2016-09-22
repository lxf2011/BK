//
//  GiftCell.m
//  DXQ
//
//  Created by 做功课 on 15/7/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "GiftCell.h"
#import "UIImageView+WebCache.h"
#import "DXPreferenceTool.h"
#import "DXLoginHelp.h"
#import "DXUserPreferenceStatus.h"
#import "UIImageView+DXWebCache.h"
@implementation GiftCell

- (void)awakeFromNib {
    // Initialization code
    //点赞图的背景
    self.buttonLike.layer.cornerRadius = self.buttonLike.height/2;
    self.buttonLike.backgroundColor = DXColorGrayDark;
    
    //阴影
    [self.viewShadow shashowGrayDarkStyle];
    [self.imgView roundStyle10];
//    //适配
//    [self.viewShadow adaptSubViews];
    [self updateStatus];
}

-(void)updateStatus{
//    self.buttonLike.enabled = [DXLoginHelp canRestoreState];
}
/**
 *  改变按钮状态
 */
- (void)changeButtonStatus{
//    self.buttonLike.enabled = [DXLoginHelp canRestoreState];
}

- (void)setModel:(DXGetGiftsItemModel *)model{
    self.L_ID = model.L_ID;
    [self.imgView sd_setImageWithURL_dx:model.L_PIC placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
    self.labelTitle.text = model.L_SPECIAL_NAME;
    [self.buttonLike setTitle:model.L_SUM_PRAISE forState:UIControlStateNormal];
    self.labelTime.text = [model.L_TIME substringToIndex:10];
    [self updateStatus];
    if ([DXLoginHelp sharedInstance].loginUser!=nil ) {
        NSArray *array = @[@"L_SPECIAL", @"USR_SPC_PRAISE", self.L_ID];
        if ([DXUserPreferenceStatus isPraise:array]) {
            self.isLike = YES;
            [self.buttonLike setImage:[UIImage imageNamed:@"zan_pressed"] forState:UIControlStateNormal];
            [self.buttonLike setTitleColor:DXColorPink forState:UIControlStateNormal];
        }
    }
    else{
        self.isLike = NO;
        [self.buttonLike setImage:[UIImage imageNamed:@"lw_-39"] forState:UIControlStateNormal];
        [self.buttonLike setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)like:(UIButton *)sender {
    [self changeLikeView];
}

-(void)changeLikeView{
    NSArray *array = @[@"L_SPECIAL", @"USR_SPC_PRAISE", self.L_ID];
    if (self.isLike) {
        DXDelPreferenceParam *param = [[DXDelPreferenceParam alloc]init];
        param.LTARGET = @"L_SPECIAL";
        param.LTYPE = @"USR_SPC_PRAISE";
        param.LTARID = self.L_ID.intValue;
        [DXPreferenceTool postDelPreferenceWithParams:param success:^(DXDelPreferenceModel *result) {
            self.isLike = NO;
            [self.buttonLike setImage:[UIImage imageNamed:@"lw_-39"] forState:UIControlStateNormal];
            [self.buttonLike setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.buttonLike setTitle:[NSString stringWithFormat:@"%zd", self.buttonLike.currentTitle.integerValue - 1] forState:UIControlStateNormal];
            
            [DXUserPreferenceStatus delPraiseStatus:array];
        } failure:^(NSError *error) {
            [self makeToast:@"取消失败，请检查网络"];
        }];
        
    }
    else{
        DXAddPreferenceParam *param = [[DXAddPreferenceParam alloc]init];
        param.LTARGET = @"L_SPECIAL";
        param.LTYPE = @"USR_SPC_PRAISE";
        param.LTARID = self.L_ID.intValue;
        [DXPreferenceTool postAddPreferenceWithParams:param success:^(DXAddPreferenceModel *result) {
            self.isLike = YES;
            [self.buttonLike setImage:[UIImage imageNamed:@"zan_pressed"] forState:UIControlStateNormal];
            [self.buttonLike setTitleColor:DXColorPink forState:UIControlStateNormal];
            [self.buttonLike setTitle:[NSString stringWithFormat:@"%zd", self.buttonLike.currentTitle.integerValue + 1] forState:UIControlStateNormal];
            
            [DXUserPreferenceStatus addPraiseStatus:array];
        } failure:^(NSError *error) {
            [self makeToast:@"点赞失败，请检查网络"];
        }];
    }
}

@end
