//
//  ActivityCell.m
//  DXQ
//
//  Created by 做功课 on 15/7/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "ActivityCell.h"
#import "UIImageView+WebCache.h"
#import "DXPreferenceTool.h"
#import "DXLoginHelp.h"
#import "DXUserPreferenceStatus.h"
#import "UIImageView+DXWebCache.h"
@implementation ActivityCell

- (void)awakeFromNib {
    [self.viewBackground shashowGrayDarkStyle];
    //适配
    [self.viewBackground adaptSubViews];
    [self.imageViewDetail setWidth:150*ScreenRatio];
    [self.imageViewDetail setHeight:150];
    [self.imageViewDetail setAlignLeft:8*ScreenRatio];
    [self.imageViewDetail setAlignTop:8];
    self.imageViewDetail.layer.masksToBounds = YES;
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

- (void)setModel:(DXGetActivityItemModel *)model{
    [self.buttonLocation setTitle:model.L_PATH forState:UIControlStateNormal];
    self.L_ID = model.L_ID;
    self.labelTitle.text = model.L_TITLE;
    if (model.L_START_TIME==nil||[[model.L_START_TIME substringToIndex:4] isEqualToString:@"0001"]) {
        
        self.buttonTime.titleLabel.text = @"时间不限\n\n";
        [self.buttonTime setTitle:@"时间不限\n\n" forState:UIControlStateNormal];
    }
    else{
        
        self.buttonTime.titleLabel.text = [NSString stringWithFormat:@"%@\n%@\n", model.L_START_TIME, model.L_END_TIME];
        [self.buttonTime setTitle:[NSString stringWithFormat:@"%@\n%@\n", model.L_START_TIME, model.L_END_TIME] forState:UIControlStateNormal];
    }
    
    [self.buttonLook setTitle:model.L_CLICK forState:UIControlStateNormal];
    [self.buttonLike setTitle:model.L_SUM_PRAISE forState:UIControlStateNormal];
    [self.buttonLocation setTitle:model.L_PATH forState:UIControlStateNormal];
    [self.imageViewDetail sd_setImageWithURL_dx:model.L_PIC placeholderImage:[UIImage imageNamed:@"loading"]];
    
    [self updateStatus];
    NSArray *array = @[@"L_ACTIVITY", @"USR_ACT_PRAISE", self.L_ID];
    if ([DXLoginHelp sharedInstance].loginUser!=nil &&[DXUserPreferenceStatus isPraise:array]) {
        self.isLike = YES;
        [self.buttonLike setImage:[UIImage imageNamed:@"zan_pressed"] forState:UIControlStateNormal];
        [self.buttonLike setTitleColor:DXColorPink forState:UIControlStateNormal];
    }
    else{
        self.isLike = NO;
        [self.buttonLike setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [self.buttonLike setTitleColor:DXColorGrayLight forState:UIControlStateNormal];
    }
    
}

- (IBAction)like:(UIButton *)sender {
    [self changeLikeView];
}

-(void)changeLikeView{
    NSArray *array = @[@"L_ACTIVITY", @"USR_ACT_PRAISE", self.L_ID];
    if (self.isLike) {
        DXDelPreferenceParam *param = [[DXDelPreferenceParam alloc]init];
        param.LTARGET = @"L_ACTIVITY";
        param.LTYPE = @"USR_ACT_PRAISE";
        param.LTARID = self.L_ID.intValue;
        [DXPreferenceTool postDelPreferenceWithParams:param success:^(DXDelPreferenceModel *result) {
            self.isLike = NO;
            [self.buttonLike setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
            [self.buttonLike setTitleColor:DXColorGrayLight forState:UIControlStateNormal];
            [self.buttonLike setTitle:[NSString stringWithFormat:@"%zd", self.buttonLike.currentTitle.integerValue - 1] forState:UIControlStateNormal];
            
            [DXUserPreferenceStatus delPraiseStatus:array];
        } failure:^(NSError *error) {
            [self makeToast:@"取消失败，请检查网络"];
        }];
        
    }
    else{
        DXAddPreferenceParam *param = [[DXAddPreferenceParam alloc]init];
        param.LTARGET = @"L_ACTIVITY";
        param.LTYPE = @"USR_ACT_PRAISE";
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
