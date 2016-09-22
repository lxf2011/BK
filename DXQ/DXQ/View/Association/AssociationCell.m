//
//  AssociationCell.m
//  DXQ
//
//  Created by 做功课 on 15/7/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "AssociationCell.h"
#import "UIImageView+WebCache.h"
#import "DXPreferenceTool.h"
#import "DXLoginHelp.h"
#import "DXUserPreferenceStatus.h"
#import "NSString+DateHelper.h"
#import "UIImageView+DXWebCache.h"
@implementation AssociationCell

- (void)awakeFromNib {
    [self.viewBackground shashowGrayDarkStyle];
    [self.imageViewDetail roundStyle10];
    
    [self.viewBackground adaptSubViews];
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

//- (void)setModel:(DXGetOrgMsgsItemModel *)model cat:(NSString *)cat{
//    
//    if ([cat isEqualToString:@"活动"]) {
//        [self setAct:model.Act];
//    }
//    else{
//        [self setMsg:model.Msg];
//        [self.buttonLocation setTitle:model.OrgInfo.LOID.LSCHOOL forState:UIControlStateNormal];
//        self.labelTime.text = [model.OrgInfo.LTIME substringToIndex:10];
//    }
//    self.labelAssociation.text = model.OrgInfo.LOID.LORGNAME;
//    
//    [self updatePreferenceView];
//}
- (void)setModel:(NSObject *)model orgInfo:(DXGetOrgMsgsItemInfoModel *)orgInfo{
    self.modelMark = model;
    if ([model isKindOfClass:[DXGetOrgMsgsActModel class]]) {
        [self setAct:(DXGetOrgMsgsActModel *)model];
    }
    else if ([model isKindOfClass:[DXGetOrgMsgsMsgModel class]]) {
        
        [self setMsg:(DXGetOrgMsgsMsgModel *)model];
        
    }
    [self.buttonLocation setTitle:orgInfo.LOID.LSCHOOL forState:UIControlStateNormal];
    self.labelTime.text = [orgInfo.LTIME substringToIndex:10];
    self.labelAssociation.text = orgInfo.LOID.LORGNAME;
    
    [self updatePreferenceView];
}
-(void)updatePreferenceView{
    [self updateStatus];
    NSArray *array;
    if ([self.modelMark isKindOfClass:[DXGetOrgMsgsActModel class]]) {
        array= @[@"L_ACTIVITY", @"USR_ACT_PRAISE", self.Id];
    }
    else{
        array= @[@"L_MESSAGE", @"USR_MSG_PRAISE", self.Id];
    }
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
-(void)setAct:(DXGetOrgMsgsActModel *)act{
    _modelAct = act;
    self.Id = [NSString stringWithFormat:@"%ld",(long)act.Id];
    self.labelTitle.text = act.LTITLE;
    // 两个时间不知如何应对，待调
    self.labelTime.text = [act.LTIME substringToIndex:10];
    NSString *startTime = [act.LSTARTTIME stringWithBeforeFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'" afterFormat:@"MM-dd  HH:mm"];
    NSString *endTime = [act.LENDTIME stringWithBeforeFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'" afterFormat:@"MM-dd  HH:mm"];
    [self.buttonTime setTitle:[NSString stringWithFormat:@"%@ -- %@",startTime,endTime] forState:UIControlStateNormal];
    [self.imageViewDetail sd_setImageWithURL_dx:act.LPIC placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
    
    
    NSArray *array = @[@"L_ACTIVITY", @"USR_ACT_PRAISE", self.Id];
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
    [self.buttonLike setTitle:[NSString stringWithFormat:@"%ld",(long)act.LSUMPRAISE] forState:UIControlStateNormal];
    
    [self.buttonLook setTitle:[NSString stringWithFormat:@"%zd", act.LCLICK] forState:UIControlStateNormal];
}
-(void)setMsg:(DXGetOrgMsgsMsgModel *)msg{
    _modelMsg = msg;
    self.Id = [NSString stringWithFormat:@"%ld",(long)msg.Id];
    self.labelTitle.text = msg.LTITLE;
    // 两个时间不知如何应对，待调
     NSString *tempTime = [msg.LTIME stringWithBeforeFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'" afterFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    [self.buttonTime setTitle:tempTime forState:UIControlStateNormal];
    [self.imageViewDetail sd_setImageWithURL_dx:msg.LPIC placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
    
    NSArray *array = @[@"L_MESSAGE", @"USR_MSG_PRAISE", self.Id];
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
    [self.buttonLike setTitle:[NSString stringWithFormat:@"%ld",(long)msg.LSUMPRAISE] forState:UIControlStateNormal];
    [self.buttonLook setTitle:[NSString stringWithFormat:@"%zd", msg.LCLICK] forState:UIControlStateNormal];
}
- (IBAction)like:(UIButton *)sender {
    [self changeLikeView];
}

-(void)changeLikeView{
    NSArray *array;
    if ([self.modelMark isKindOfClass:[DXGetOrgMsgsActModel class]]) {
     array= @[@"L_ACTIVITY", @"USR_ACT_PRAISE", self.Id];
    }
    else{
        array= @[@"L_MESSAGE", @"USR_MSG_PRAISE", self.Id];
    }
    if (self.isLike) {
        DXDelPreferenceParam *param = [[DXDelPreferenceParam alloc]init];
        param.LTARGET = array[0];
        param.LTYPE = array[1];
        param.LTARID = self.Id.intValue;
        [DXPreferenceTool postDelPreferenceWithParams:param success:^(DXDelPreferenceModel *result) {
            self.isLike = NO;
            if ([self.modelMark isKindOfClass:[DXGetOrgMsgsActModel class]]) {
                _modelAct.LSUMPRAISE = _modelAct.LSUMPRAISE-1;
                [self.buttonLike setTitle:[NSString stringWithFormat:@"%zd", _modelAct.LSUMPRAISE] forState:UIControlStateNormal];
            }
            else{
                _modelMsg.LSUMPRAISE = _modelMsg.LSUMPRAISE-1;
                [self.buttonLike setTitle:[NSString stringWithFormat:@"%zd", _modelMsg.LSUMPRAISE] forState:UIControlStateNormal];
            }
            [self.buttonLike setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
            [self.buttonLike setTitleColor:DXColorGrayLight forState:UIControlStateNormal];
            
            
            [DXUserPreferenceStatus delPraiseStatus:array];
        } failure:^(NSError *error) {
            [self makeToast:@"取消失败，请检查网络"];
        }];
        
    }
    else{
        DXAddPreferenceParam *param = [[DXAddPreferenceParam alloc]init];
        param.LTARGET = array[0];
        param.LTYPE = array[1];
        param.LTARID = self.Id.intValue;
        [DXPreferenceTool postAddPreferenceWithParams:param success:^(DXAddPreferenceModel *result) {
            self.isLike = YES;
            if ([self.modelMark isKindOfClass:[DXGetOrgMsgsActModel class]]) {
                _modelAct.LSUMPRAISE = _modelAct.LSUMPRAISE+1;
                [self.buttonLike setTitle:[NSString stringWithFormat:@"%zd", _modelAct.LSUMPRAISE] forState:UIControlStateNormal];
            }
            else{
                _modelMsg.LSUMPRAISE = _modelMsg.LSUMPRAISE+1;
                [self.buttonLike setTitle:[NSString stringWithFormat:@"%zd", _modelMsg.LSUMPRAISE] forState:UIControlStateNormal];
            }
            [self.buttonLike setImage:[UIImage imageNamed:@"zan_pressed"] forState:UIControlStateNormal];
            [self.buttonLike setTitleColor:DXColorPink forState:UIControlStateNormal];
            
            [DXUserPreferenceStatus addPraiseStatus:array];
        } failure:^(NSError *error) {
            [self makeToast:@"点赞失败，请检查网络"];
        }];
    }
}
@end
