//
//  InformationCell.m
//  DXQ
//
//  Created by 做功课 on 15/7/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "InformationCell.h"
#import "UIImageView+WebCache.h"
#import "DXPreferenceTool.h"
#import "DXUserPreferenceStatus.h"
#import "DXLoginHelp.h"
#import "NSString+DateHelper.h"
#import "UIImageView+DXWebCache.h"
@implementation InformationCell

- (void)awakeFromNib {
    [self.viewBackground shashowGrayDarkStyle];
    
    //适配
    [self.viewBackground adaptSubViews];
    [self.imageViewDetail setWidth:120*ScreenRatio];
    [self.imageViewDetail setHeight:90];
    [self.imageViewDetail setAlignRightToSuperView:12*ScreenRatio];
    [self.imageViewDetail setAlignTop:10];
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

- (void)changeButtonTitle:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    if (dic[@"isLike"]) {
        [self.buttonLike setImage:[UIImage imageNamed:@"zan_pressed"] forState:UIControlStateNormal];
    } else {
         [self.buttonLike setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    }
    [self.buttonLike setTitle:dic[@"title"] forState:UIControlStateNormal];
}

-(void)setModel:(DXMsgItemModel *)model{
    _model = model;
    self.L_ID = model.L_ID;
    self.labelTitle.text = model.L_TITLE;
    if (model.L_TIME.length>=10) {
        self.labelTime.text = [model.L_TIME substringToIndex:10];
    }
    
    self.textViewContent.text = model.L_INTRO;
    [self.imageViewDetail sd_setImageWithURL_dx:model.L_PIC placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
    [self.buttonLike setTitle:model.L_SUM_PRAISE forState:UIControlStateNormal];
    [self.buttonCollect setTitle:model.L_CLICK forState:UIControlStateNormal];
    [self updateStatus];
    NSArray *array = @[@"L_MESSAGE", @"USR_MSG_PRAISE", self.L_ID];
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
    NSArray *array = @[@"L_MESSAGE", @"USR_MSG_PRAISE", self.L_ID];
    if (self.isLike) {
        DXDelPreferenceParam *param = [[DXDelPreferenceParam alloc]init];
        param.LTARGET = @"L_MESSAGE";
        param.LTYPE = @"USR_MSG_PRAISE";
        param.LTARID = self.L_ID.intValue;
        [DXPreferenceTool postDelPreferenceWithParams:param success:^(DXDelPreferenceModel *result) {
            self.isLike = NO;
            _model.L_SUM_PRAISE = [NSString stringWithFormat:@"%d",_model.L_SUM_PRAISE.intValue-1];
            [self.buttonLike setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
            [self.buttonLike setTitleColor:DXColorGrayLight forState:UIControlStateNormal];
            [self.buttonLike setTitle:_model.L_SUM_PRAISE forState:UIControlStateNormal];
            
            [DXUserPreferenceStatus delPraiseStatus:array];
        } failure:^(NSError *error) {
            [self makeToast:@"取消失败，请检查网络"];
         }];
    }
    else{
        DXAddPreferenceParam *param = [[DXAddPreferenceParam alloc]init];
        param.LTARGET = @"L_MESSAGE";
        param.LTYPE = @"USR_MSG_PRAISE";
        param.LTARID = self.L_ID.intValue;
        [DXPreferenceTool postAddPreferenceWithParams:param success:^(DXAddPreferenceModel *result) {
            self.isLike = YES;
            _model.L_SUM_PRAISE = [NSString stringWithFormat:@"%d",_model.L_SUM_PRAISE.intValue+1];
            [self.buttonLike setImage:[UIImage imageNamed:@"zan_pressed"] forState:UIControlStateNormal];
            [self.buttonLike setTitleColor:DXColorPink forState:UIControlStateNormal];
            [self.buttonLike setTitle:_model.L_SUM_PRAISE forState:UIControlStateNormal];
            
            [DXUserPreferenceStatus addPraiseStatus:array];
        } failure:^(NSError *error) {
            [self makeToast:@"点赞失败，请检查网络"];
        }];
    }
}

@end


