//
//  DXCommentMainCell.m
//  DXQ
//
//  Created by 做功课 on 15/8/6.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "DXCommentMainCell.h"
#import "NSDate+Extension.h"
#import "RSTextHelper.h"
#import "DXLoginHelp.h"
#import "NSString+DateHelper.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+DXWebCache.h"
#import "DXLoginHelp.h"
#import "DXUserPreferenceStatus.h"
#import "DXPreferenceTool.h"
@implementation DXCommentMainCell

- (void)awakeFromNib {
//    [self.viewBackground adaptSubViews];
//    self.imageViewUser.layer.cornerRadius = self.imageViewUser.width / 2;
//    self.imageViewUser.clipsToBounds = YES;
//    self.imageViewReply.layer.cornerRadius = self.imageViewUser.width / 2;
//    self.imageViewReply.clipsToBounds = YES;
    self.imageViewUser.layer.masksToBounds = YES;
    self.imageViewUser.layer.cornerRadius = self.imageViewUser.width/2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)reply:(UIButton *)sender {
    if (self.replay) {
        self.replay();
    }
}
- (IBAction)like:(UIButton *)sender {
    [self changeLikeView];
}

- (void)setAddCommnetModel:(DXAddCommetReallyModel *)model{

    self.labelUserName.text = [NSString stringWithFormat:@"%zd", model.LOWNER];
    self.labelContent.text = model.LCONTENT;
    [self.buttonLike setTitle:[NSString stringWithFormat:@"%zd", model.LSUMPRAISE]forState:UIControlStateNormal];
    self.Id = model.Id;
#warning 这里只有用户id，没有用户名 用户头像。
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    [fmt setDateFormat:@"hh:mm"];
    self.labelTime.text = [NSString stringWithFormat:@"今天 %@", [fmt stringFromDate:[NSDate date]]];
    


    
//    Comment *comment = self.commentFrame.comment;
//    [comment setAddCommnetModel:model];
//    self.commentFrame.comment = comment;
}

- (void)setModel:(DXGetCommetsItemModel *)model commetsItemModels:(NSArray *)commetsItemModels{
    
    self.model = model;
    if (commetsItemModels.count==0) {
        self.viewBackGroundGray.hidden = YES;
    }
    else{
        self.viewBackGroundGray.hidden = NO;
    }
    if (model.L_OWNER.integerValue ==[DXLoginHelp sharedInstance].loginUser.Id){
        self.labelUserName.text = [DXLoginHelp sharedInstance].nickName;
        
    }
    else{
        self.labelUserName.text = model.NICK_NAME;
    }
    self.labelUserName.textColor = DXColorGrayDark;
    self.labelUserName.font = [UIFont boldSystemFontOfSize:13];
    
    self.labelTime.text = [model.L_TIME stringWithBeforeFormat:@"yyyy-MM-dd HH:mm:ss" afterFormat:@"MM月dd日 HH:mm"];
    
    
    

    CGFloat outHeight = [RSTextHelper getSizeFromFont:[UIFont fontWithName:@"helvetica neue" size:14] AndText:model.L_CONTENT  AndViewSize:CGSizeMake(self.labelContent.width, 0)].height;
    [self.labelContent setHeight:outHeight+1];
    self.labelContent.text = model.L_CONTENT;
    
    
    self.labelUserName.font = [UIFont systemFontOfSize:14];
    [self.imageViewUser sd_setImageWithURL_dx:model.HEAD placeholderImage:[UIImage imageNamed:@"nan.png"]];
    NSLog(@"头像地址:%@",model.HEAD);
    self.labelContent.textColor = DXColorGrayDark;
    [self.buttonLike setTitle:model.L_SUM_PRAISE forState:UIControlStateNormal];
    CGFloat inHeight = 0;
    
    for (long i=commetsItemModels.count-1; i>=0; i--) {
        DXGetCommetsItemModel *subModel = commetsItemModels[i];
        inHeight += 5+16+ 5+[RSTextHelper getSizeFromFont:[UIFont fontWithName:@"helvetica neue" size:13] AndText:subModel.L_CONTENT  AndViewSize:CGSizeMake(ScreenWidth-90, 0)].height+5+1;
    }
    
    [self.viewBackGroundGray setHeight:inHeight];
    [self.viewBackGroundGray setWidth:ScreenWidth-70];
    if (self.viewBackGroundGray.hidden) {
        [self.labelContent setY:self.viewBackGroundGray.originY];
    }
    else{
        [self.labelContent setY:(self.viewBackGroundGray.height+self.viewBackGroundGray.originY+5)];
    }
    
    for (UIView *view in self.viewBackGroundGray.subviews) {
        [view removeFromSuperview];
    }
    CGFloat startY = 0;
    int currentI = 0;
    for (long i=commetsItemModels.count-1; i>=0; i--) {
        DXGetCommetsItemModel *subModel = commetsItemModels[i];
        currentI ++;
        startY +=5;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, startY, 16, 16)];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = imageView.width/2;
        [imageView sd_setImageWithURL_dx:subModel.HEAD placeholderImage:[UIImage imageNamed:@"nan.png"]];
        [self.viewBackGroundGray addSubview:imageView];
        
        UILabel *subName = [[UILabel alloc]initWithFrame:CGRectMake(31, startY, ScreenWidth-70-50, 16)];
        subName.font = [UIFont boldSystemFontOfSize:12];
        subName.text = subModel.NICK_NAME;
        subName.textColor = DXColorGrayDark;
        [self.viewBackGroundGray addSubview:subName];
        
        startY += imageView.height;
        startY +=5;
        
        CGFloat actHeight = [RSTextHelper getSizeFromFont:[UIFont fontWithName:@"helvetica neue" size:13] AndText:subModel.L_CONTENT  AndViewSize:CGSizeMake(ScreenWidth-90, 0)].height;
        if (actHeight<16) {
            actHeight = 16;
        }
        UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(10, startY, ScreenWidth-90, actHeight+5)];
        content.text = subModel.L_CONTENT;
        content.textColor = DXColorGrayDark;
        content.font = [UIFont systemFontOfSize:13];
        content.numberOfLines = 0;
////        CGFloat savewidth = ScreenWidth-120-3*12-20;
////        [RSTextHelper labelHandleWithModeWordWrap:content WithWidth:savewidth];
////        [self.labelContent setWidth:savewidth];
//        
//        CGFloat outHeight = [RSTextHelper getSizeFromFont:[UIFont fontWithName:@"helvetica neue" size:13] AndText:subModel.L_CONTENT  AndViewSize:CGSizeMake(self.labelContent.width, 0)].height;
//        [self.labelContent setHeight:outHeight+1];
        
        [self.viewBackGroundGray addSubview:content];
        
        
        startY += actHeight;
        startY +=5;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, startY, self.viewBackGroundGray.width, 1)];
        lineView.backgroundColor = DXColorSeparator;
        [self.viewBackGroundGray addSubview:lineView];
        
        startY +=1;
    }
    self.viewLine.frame = CGRectMake(0,[self.viewLine superview].height-1, [self.viewLine superview].width, 1);
    [[self.viewLine superview] addSubview:self.viewLine];
    
    [self.buttonLike setTitle:model.L_SUM_PRAISE forState:UIControlStateNormal];
    NSArray *array = @[@"L_COMMENT", @"USR_COMMENT_PRAISE", model.L_ID];
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

//更新赞的图标文字

-(void)changeLikeView{
    NSArray *array = @[@"L_COMMENT", @"USR_COMMENT_PRAISE", self.model.L_ID];
    if (self.isLike) {
        [self makeToast:@"已经点赞"];
//        DXDelPreferenceParam *param = [[DXDelPreferenceParam alloc]init];
//        param.LTARGET = @"L_COMMENT";
//        param.LTYPE = @"USR_COMMENT_PRAISE";
//        param.LTARID = self.model.L_ID.intValue;
//        [DXPreferenceTool postDelPreferenceWithParams:param success:^(DXDelPreferenceModel *result) {
//            self.isLike = NO;
//            _model.L_PRAISE = [NSString stringWithFormat:@"%d",_model.L_PRAISE.intValue-1];
//            [self.buttonLike setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
//            [self.buttonLike setTitleColor:DXColorGrayLight forState:UIControlStateNormal];
//            [self.buttonLike setTitle:_model.L_PRAISE forState:UIControlStateNormal];
//            
//            [DXUserPreferenceStatus delPraiseStatus:array];
//        } failure:^(NSError *error) {
//            [self makeToast:@"取消失败，请检查网络"];
//        }];
    }
    else{
        DXAddPreferenceParam *param = [[DXAddPreferenceParam alloc]init];
        param.LTARGET = @"L_COMMENT";
        param.LTYPE = @"USR_COMMENT_PRAISE";
        param.LTARID = self.model.L_ID.intValue;
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
