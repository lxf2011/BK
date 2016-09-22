//
//  LeftFeedbackViewController.m
//  DXQ
//
//  Created by 做功课 on 15/8/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "LeftFeedbackViewController.h"
#import "DXCommetTool.h"
#import "RSCheck.h"

@interface LeftFeedbackViewController () <UITextViewDelegate>

@end

@implementation LeftFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];   
    
    [self setLeftBarButtonItem:@"意见反馈"];
    
    [self.textViewFeedBack roundStyle10];
    self.textViewFeedBack.placeholder = @"你肯定有什么想吐槽的";
    self.textViewFeedBack.placeholderColor = DXColorGrayDark;
    self.textViewFeedBack.placeholderBottomFont = [UIFont systemFontOfSize:12];
    self.textViewFeedBack.font = [UIFont systemFontOfSize:16];
    self.textViewFeedBack.placeholderBottom = @"4-200字";
    self.textViewFeedBack.delegate = self;
}

- (IBAction)sendText:(UIButton *)sender {
    if (![RSCheck checkStringCount:4 inTextView:self.textViewFeedBack tip:@"反馈"]) {
        return;
    }
    DXFeedBackParam *param = [[DXFeedBackParam alloc]init];
    param.LTARGETTYPE = @"FEED_BACK";
    param.LCONTENT = self.textViewFeedBack.text;
    [DXCommetTool postFeedBackWithParams:param success:^(DXAddCommetModel *result) {
        [self makeToastAtWindow:@"反馈成功，感谢您的宝贵意见"];
    } failure:^(NSError *error) {
        [self makeToastAtWindow:@"反馈失败，请检查当前网络情况"];
        DXLog(@"反馈失败");
    }];
}

/*由于联想输入的时候，函数textView:shouldChangeTextInRange:replacementText:无法判断字数，
 因此使用textViewDidChange对TextView里面的字数进行判断
 */
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 199)
    {
        textView.text = [textView.text substringToIndex:199];        
        [self makeToastAtWindow:@"不能超过200字"];
    }
}
@end
