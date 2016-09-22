//
//  DXOptionView.m
//  DXQ
//
//  Created by rason on 8/5/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXOptionView.h"
#import "DXPreferenceTool.h"
#import "DXUserPreferenceStatus.h"
#import "DXLoginHelp.h"
#import "UMSocial.h"
#import "DXOtherTool.h"
#import "SYShareCollectionView.h"
#import "LoginViewController.h"
#import "NYControllerTools.h"
@implementation DXOptionView

- (void)awakeFromNib{
    self.buttonCollect.tag = DXOptionViewButtonTypeCollect;
    self.buttonCommet.tag = DXOptionViewButtonTypeComment;
    self.buttonLike.tag = DXOptionViewButtonTypeLike;
    self.buttonShare.tag = DXOptionViewButtonTypeShare;
//    [self.viewBackground adaptSubViews];
    
//    self.buttonLike.enabled = [DXLoginHelp canRestoreState];
//    self.buttonCollect.enabled = [DXLoginHelp canRestoreState];
    
}
/**
 *  改变按钮状态
 */
- (void)changeButtonStatus{
//    self.buttonLike.enabled = [DXLoginHelp canRestoreState];
//    self.buttonCollect.enabled = [DXLoginHelp canRestoreState];
}


- (NSString *)typeByOptionStr:(NSString *)optionStr{
    NSArray *arr = @[@"L_MESSAGE", @"L_ACTIVITY", @"L_SPECIAL"];
    NSUInteger index = [arr indexOfObject:self.LTARGET];
    NSString *ltype = @"";
    switch (index) {
        case 0:
            ltype = [@"USR_MSG_" stringByAppendingString:optionStr];
            break;
        case 1:
            ltype = [@"USR_ACT_" stringByAppendingString:optionStr];
            break;
        case 2:
            ltype = [@"USR_SPC_" stringByAppendingString:optionStr];
            break;
    }
    return ltype;
}

- (NSArray *)arrayByOptionStr:(NSString *)optionStr{
    NSString *ltype = [self typeByOptionStr:optionStr];
    NSArray *array = @[self.LTARGET, ltype, self.LTARID];
    NSLog(@"....%@-----%@=====%@", self.LTARGET, self.LTARID, ltype);
    return array;
}
#pragma mark - 刷新
-(void)refresh{
    [self refreshByTarget:self.LTARGET ID:self.LTARID];
    [self refreshCollectByTarget:self.LTARGET ID:self.LTARID];
}
/* 更新收藏的状态 */
- (void)refreshCollectByTarget:(NSString *)LTARGET ID:(NSString *)LTARID{
    [self updatePreferenceStatusTarget:LTARGET ID:LTARID optionStr:@"COLLECT" finish:^{
        self.isCollected = YES;
        [self.buttonCollect setImage:[UIImage imageNamed:@"ic_-35"] forState:UIControlStateNormal];
        [self.buttonCollect setTitleColor:DXColorPink forState:UIControlStateNormal];
    }];
    
}

/* 更新点赞条的状态 */
- (void)refreshByTarget:(NSString *)LTARGET ID:(NSString *)LTARID{
    [self updatePreferenceStatusTarget:LTARGET ID:LTARID optionStr:@"PRAISE" finish:^{
        self.isLike = YES;
        [self.buttonLike setImage:[UIImage imageNamed:@"大学圈UIv1.0-47"] forState:UIControlStateNormal];
        [self.buttonLike setTitleColor:DXColorPink forState:UIControlStateNormal];
    }];
    
}
-(void)updatePreferenceStatusTarget:(NSString *)LTARGET ID:(NSString *)LTARID optionStr:(NSString *)optionStr finish:(void(^)())finish{
    self.LTARID = LTARID;
    self.LTARGET = LTARGET;
    if ([DXLoginHelp sharedInstance].loginUser!=nil ) {
        NSArray *array = [self arrayByOptionStr:optionStr];
        if ([DXUserPreferenceStatus isPraise:array]) {
            finish();
        }
    }
    
}

#pragma mark -创建
+(DXOptionView *)create{
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DXOptionView" owner:self options:nil];
    for (UIView *view in nib) {
        if ([view isKindOfClass:[self class]]) {
            DXOptionView *tempView = (DXOptionView *)view;
            [[NSNotificationCenter defaultCenter]addObserver:tempView selector:@selector(refresh) name:kNotificationPreferenceStatusChange object:nil];
            [[NSNotificationCenter defaultCenter]addObserver:tempView selector:@selector(didFinishGetUMSocialDataInViewController:) name:kNotificationUpdateShareInfo object:nil];
            
            return (DXOptionView *)view;
        }
    }
    return nil;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 点赞
- (IBAction)like:(UIButton *)sender {
    [self changeLikeView];
}
-(void)changeLikeView{
    NSArray *array = [self arrayByOptionStr:@"PRAISE"];
    NSString *ltype = [self typeByOptionStr:@"PRAISE"];
    if (self.isLike) {
        DXDelPreferenceParam *param = [[DXDelPreferenceParam alloc]init];
        param.LTARGET = self.LTARGET;
        param.LTYPE = ltype;
        param.LTARID = self.LTARID.intValue;
        [DXPreferenceTool postDelPreferenceWithParams:param success:^(DXDelPreferenceModel *result) {
            self.isLike = NO;
            [self.buttonLike setImage:[UIImage imageNamed:@"大学圈UIv1.0-48"] forState:UIControlStateNormal];
            [self.buttonLike setTitleColor:DXColorGrayMiddle forState:UIControlStateNormal];
            NSString *title = [NSString stringWithFormat:@"%zd", self.buttonLike.currentTitle.integerValue - 1];
            if (self.opotionViewBlock) {
                self.opotionViewBlock(title,@"");
            }
            [self.buttonLike setTitle:title forState:UIControlStateNormal];
            
            [DXUserPreferenceStatus delPraiseStatus:array];
        } failure:^(NSError *error) {
            [self makeToast:@"取消失败，请检查网络"];
        }];
        
    }
    else{
        DXAddPreferenceParam *param = [[DXAddPreferenceParam alloc]init];
        param.LTARGET = self.LTARGET;
        param.LTYPE = ltype;
        param.LTARID = self.LTARID.intValue;
        [DXPreferenceTool postAddPreferenceWithParams:param success:^(DXAddPreferenceModel *result) {
            self.isLike = YES;
            [self.buttonLike setImage:[UIImage imageNamed:@"大学圈UIv1.0-47"] forState:UIControlStateNormal];
            [self.buttonLike setTitleColor:DXColorPink forState:UIControlStateNormal];
            NSString *title = [NSString stringWithFormat:@"%zd", self.buttonLike.currentTitle.integerValue + 1];
            if (self.opotionViewBlock) {
                self.opotionViewBlock(title,@"");
            }
            [self.buttonLike setTitle:title forState:UIControlStateNormal];
            
            [DXUserPreferenceStatus addPraiseStatus:array];
        } failure:^(NSError *error) {
            [self makeToast:@"点赞失败，请检查网络"];
        }];
    }

}

#pragma mark - 收藏
- (IBAction)collect:(UIButton *)sender{//收藏方法
    [self changeCollectView];
}

//更新收藏的图标文字
-(void)changeCollectView{
    NSArray *array = [self arrayByOptionStr:@"COLLECT"];
    NSString *ltype = [self typeByOptionStr:@"COLLECT"];
    if (self.isCollected) {
        DXDelPreferenceParam *param = [[DXDelPreferenceParam alloc]init];
        param.LTARGET = self.LTARGET;
        param.LTYPE = ltype;
        param.LTARID = self.LTARID.intValue;
        [DXPreferenceTool postDelPreferenceWithParams:param success:^(DXDelPreferenceModel *result) {
            self.isCollected = NO;
            [self.buttonCollect setImage:[UIImage imageNamed:@"ic_pressed-35"] forState:UIControlStateNormal];
            [self.buttonCollect setTitleColor:DXColorGrayMiddle forState:UIControlStateNormal];
            NSString *title = [NSString stringWithFormat:@"%zd", self.buttonCollect.currentTitle.integerValue - 1];
            [self.buttonCollect setTitle:title forState:UIControlStateNormal];
            
            
            NSLog(@"ttttt----------%@",title);
            if (self.opotionViewBlock) {
                self.opotionViewBlock(@"",title);
            }
            [DXUserPreferenceStatus delPraiseStatus:array];
        } failure:^(NSError *error) {
            [self makeToast:@"取消失败，请检查网络"];
        }];
        
    }
    else{
        DXAddPreferenceParam *param = [[DXAddPreferenceParam alloc]init];
        param.LTARGET = self.LTARGET;
        param.LTYPE = ltype;
        param.LTARID = self.LTARID.intValue;
        [DXPreferenceTool postAddPreferenceWithParams:param success:^(DXAddPreferenceModel *result) {
            self.isCollected = YES;
            [self.buttonCollect setImage:[UIImage imageNamed:@"ic_-35"] forState:UIControlStateNormal];
            [self.buttonCollect setTitleColor:DXColorPink forState:UIControlStateNormal];
            NSString *title = [NSString stringWithFormat:@"%zd", self.buttonCollect.currentTitle.integerValue + 1];
            [self.buttonCollect setTitle:title forState:UIControlStateNormal];
            
            NSLog(@"ttttt----------%@",title);
            if (self.opotionViewBlock) {
                self.opotionViewBlock(@"",title);
            }
            [DXUserPreferenceStatus addPraiseStatus:array];
           
        } failure:^(NSError *error) {
            [self makeToast:@"收藏失败，请检查网络"];
        }];
    }

}
#pragma mark - 评论
- (IBAction)comment:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(optionView:didClickButton:)]) {
        [self.delegate optionView:self didClickButton:sender.tag];
    }
}

- (IBAction)share:(UIButton *)sender {
    if ([DXLoginHelp sharedInstance].loginUser) {
        [SYShareCollectionView showInViewController:self.delegate shareInfo:self.dicShareInfo];
    }
    else{
        LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        //            UINavigationController *navigationController = [NYControllerTools getCurrentVC].navigationController;
        //            [navigationController pushViewController:loginViewController animated:YES];
        [NYControllerTools pushViewController:loginViewController];
    }
    
}
#pragma mark - 事件
//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(NSNotification *)notification
{
    UMSocialResponseEntity *response = notification.object;
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        NSString *sufUrl = @"";
        if ([self.LTARGET isEqualToString:@"L_MESSAGE"]) {
            sufUrl = @"updateMsgShare";
        }
        if ([self.LTARGET isEqualToString:@"L_ACTIVITY"]) {
            sufUrl = @"updateActShare";
        }
        if ([self.LTARGET isEqualToString:@"L_SPECIAL"]) {
            sufUrl = @"updateSpcShare";
        }
        [DXOtherTool getUpdateShareWithUrl:sufUrl tagertId:self.LTARID withSuccess:^(NSDictionary *result) {
            NSDictionary *data = [result objectForKey:@"data"];
            int share = [[data objectForKey:@"LSHARE"]intValue];
            [self.buttonShare setTitle:[NSString stringWithFormat:@"%d",share] forState:UIControlStateNormal];
        } failure:^(NSError *error) {
            
        }];
        
        
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
@end
