//
//  DXOptionView.h
//  DXQ
//
//  Created by rason on 8/5/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DXOptionView;

typedef enum {
    DXOptionViewButtonTypeLike,
    DXOptionViewButtonTypeComment,
    DXOptionViewButtonTypeShare,
    DXOptionViewButtonTypeCollect
}DXOptionViewButtonType;
typedef void (^OpotionViewBlock)(NSString *PRAISE, NSString *COLLECT);
@protocol DXOptionViewDelegate <NSObject>
@optional
- (void)optionView:(DXOptionView *)optionView didClickButton:(DXOptionViewButtonType)buttonType;
@end

@interface DXOptionView : UIView

+(DXOptionView *)create;

@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property (nonatomic) BOOL isLike;//点赞状态
@property (nonatomic) BOOL isCollected;//收藏状态
@property (weak, nonatomic) IBOutlet UIButton *buttonLike;
@property (weak, nonatomic) IBOutlet UIButton *buttonCollect;
@property (weak, nonatomic) IBOutlet UIButton *buttonCommet;
@property (weak, nonatomic) IBOutlet UIButton *buttonShare;
@property (nonatomic, copy) OpotionViewBlock opotionViewBlock;//回调
@property (nonatomic, strong) NSMutableDictionary* dicShareInfo;//分享信息
- (IBAction)like:(UIButton *)sender;//点赞方法
- (IBAction)collect:(UIButton *)sender;//收藏方法
- (IBAction)comment:(UIButton *)sender;
- (IBAction)share:(UIButton *)sender;

@property (nonatomic, weak) id<DXOptionViewDelegate> delegate;

@property (nonatomic, copy) NSString *LTARGET;// 类型
@property (nonatomic, copy) NSString *LTARID;// id
/* 更新收藏的状态 */
- (void)refreshCollectByTarget:(NSString *)LTARGET ID:(NSString *)LTARID;
/* 更新点赞条的状态 */
- (void)refreshByTarget:(NSString *)LTARGET ID:(NSString *)LTARID;
-(void)refresh;
@end
