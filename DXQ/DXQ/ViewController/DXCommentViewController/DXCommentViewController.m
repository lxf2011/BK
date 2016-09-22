//
//  DXCommentViewController.m
//  DXQ
//
//  Created by 做功课 on 15/8/6.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "DXCommentViewController.h"
#import "DXCommentMainCell.h"
#import "MJRefresh.h"
#import "DXCommetTool.h"
#import "DXLoginHelp.h"
#import "RSTextHelper.h"
#import "IQKeyboardManager.h"
#import "DXOptionView.h"
#import "DXDetailViewController.h"
#import "DXLoginHelp.h"

#define fontText [UIFont systemFontOfSize:14] // 文字大小
#define margin 6 // 输入框和线的间距
static int heightText = 17; // 文字高度

@interface DXCommentViewController(){
    int count;
    float currentLineNum; // 当前行高
    NSInteger currentReplay;//当前回复的ID
    NSMutableDictionary *dicReplay;//{评论ID:评论回复ID}
    NSMutableDictionary *dicReplayModel;//{评论ID:评论ID对应的model}
//    NSArray *arrayComment;
}
@property (nonatomic, strong) NSMutableArray *arrayComment;
@end

@implementation DXCommentViewController

- (NSMutableArray *)arrayComment{
    if (!_arrayComment) {
        self.arrayComment = [NSMutableArray array];
    }
    return _arrayComment;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
    [self refresh];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh];
        
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}
- (void)refresh{
    DXGetCommetsParam *param = [[DXGetCommetsParam alloc]init];
    param.type = self.LTARGET;
    param.limit = 10;
    param.offset = 0;
    param.id = self.LTRAID.integerValue;
    [DXCommetTool getCommentsWithParams:param success:^(DXGetCommetsModel *result) {
        [self.tableView.header endRefreshing];
        
        self.arrayComment = (NSMutableArray *)result.data;
        if (self.arrayComment.count == 0) {
            self.tableView.hidden = YES;
            self.imageViewBackground.hidden = NO;
        } else{
            self.tableView.hidden = NO;
            self.imageViewBackground.hidden = YES;
            [self.tableView reloadData];
        }
        //生成回复对应模型
        dicReplay = [NSMutableDictionary dictionary];
        dicReplayModel = [NSMutableDictionary dictionary];
        for (DXGetCommetsItemModel *model in self.arrayComment) {
            [dicReplay addEntriesFromDictionary:@{model.L_ID:model.L_REPLY}];
            [dicReplayModel addEntriesFromDictionary:@{model.L_ID:model}];
        }
        
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)setupUI{
    // 导航栏
    [self setLeftBarButtonItem:@"查看评论"];
    
    // textView边框
    self.textViewInput.layer.borderColor = DXColorGrayLight.CGColor;
    self.textViewInput.layer.borderWidth = 0.5;
    self.textViewInput.layer.cornerRadius = 2;
    
    //键盘处理

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
//    self.buttonSend.enabled = NO;
}

#pragma mark - 键盘处理
- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.constraintBottomSpace.constant = keyboardF.size.height;

}


- (void)keyboardWillHide:(NSNotification *)notification{
    self.constraintBottomSpace.constant = 0;

}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
}

/**
 *  自动增高
 */
- (void)textViewDidChange:(UITextView *)textView{
    
//    if ([DXLoginHelp canRestoreState]) {
//        self.buttonSend.enabled = textView.hasText;
//    }
    
    int marginTopAndBottom = 16;
    int bottom = 0;
    if (textView.contentSize.height<=16+heightText) {//小于等于一行，就是一行
        self.constraintHeightSendView.constant = marginTopAndBottom + 16+heightText +bottom;
    }
    else if(textView.contentSize.height<16+heightText*3){//小于等于三行，自动增长
        self.constraintHeightSendView.constant = marginTopAndBottom+textView.contentSize.height+bottom;
    }
    else{//大于三行，最高也是三行
        self.constraintHeightSendView.constant = marginTopAndBottom+16+heightText*3+bottom;
    }
}

/** 发送内容 */
- (IBAction)send:(UIButton *)sender {
    DXAddCommetParam *param = [[DXAddCommetParam alloc]init];
    param.LTARGETTYPE = self.LTARGET;
    param.LTARGET = self.LTRAID.integerValue;
    param.LCONTENT = self.textViewInput.text ;
    param.LOWNER = [DXLoginHelp sharedInstance].loginUser.Id;
    if(currentReplay==0){
        param.LTYPE = 0;
    }
    else{
        param.LTYPE = 1;
    }
    param.LREPLY = currentReplay;
    
    [DXCommetTool postAddCommentWithParams:param success:^(DXAddCommetModel *result){
//        DXLog(@"评论成功");
        self.textViewInput.text = nil;
        self.textViewInput.placeholder = @"";
        currentReplay = 0;
        
        self.buttonAddComment.hidden = YES;
        self.tableView.hidden = NO;
        DXAddCommetReallyModel *addmodel = result.data;
        DXGetCommetsItemModel *model = [[DXGetCommetsItemModel alloc]init];
        model.L_REPLY = [NSString stringWithFormat:@"%ld",(long)addmodel.LREPLY];
        model.L_OWNER = [NSString stringWithFormat:@"%ld",(long)addmodel.LOWNER];
        model.L_ID = [NSString stringWithFormat:@"%ld",(long)addmodel.Id];
        model.L_TYPE = [NSString stringWithFormat:@"%ld",(long)addmodel.LTYPE];
        model.ADD1 = addmodel.ADD1;
        model.L_TARGET_TYPE = addmodel.LTARGETTYPE;
        model.L_CONTENT = addmodel.LCONTENT;
        model.L_TIME = addmodel.LTIME;
        model.L_TARGET = [NSString stringWithFormat:@"%ld",(long)addmodel.LTARGET];
        model.L_SUM_PRAISE = [NSString stringWithFormat:@"%ld",(long)addmodel.LSUMPRAISE];
        model.HEAD = [DXLoginHelp sharedInstance].head;
        model.ADD2 = addmodel.ADD2;
        if (self.arrayComment !=nil) {
            [self.arrayComment insertObject:model atIndex:0];
        }
        
        DXLog(@"%@", self.arrayComment);
        [self.tableView reloadData];
        if (self.tableView.contentSize.height -self.tableView.bounds.size.height>0) {
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height -self.tableView.bounds.size.height) animated:YES];
        }
        
        // 刷新点赞条
        DXDetailViewController *detailVc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
        [detailVc refreshOptionViewWithComment:[NSString stringWithFormat:@"%zd", self.arrayComment.count]];
    } failure:^(NSError *error) {
        DXLog(@"评论失败 %@", error);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayComment.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DXGetCommetsItemModel *model = self.arrayComment[self.arrayComment.count-1-indexPath.row];
    
    NSMutableArray *commetsItemModels = [NSMutableArray array];
    DXGetCommetsItemModel *startModel = model;
    while ([startModel.L_TYPE isEqualToString:@"1"]&&![startModel.L_REPLY isEqualToString:@"0"]) {
        DXGetCommetsItemModel *addModel = dicReplayModel[startModel.L_REPLY];
        if (addModel!=nil) {
            [commetsItemModels addObject:addModel];
            startModel = addModel;
        }
        else{
            break;
        }
    }
    
    return [self calculateCellHeight:startModel replayedArray:commetsItemModels]+10;
}
-(CGFloat)calculateCellHeight:(DXGetCommetsItemModel *)startModel replayedArray:(NSMutableArray *)commetsItemModels{
    
    CGFloat outHeight = [RSTextHelper getSizeFromFont:[UIFont fontWithName:@"helvetica neue" size:14] AndText:startModel.L_CONTENT  AndViewSize:CGSizeMake(ScreenWidth-72, 0)].height+80-22;
    
    CGFloat inHeight = 0;
    for (DXGetCommetsItemModel *model in commetsItemModels) {
        inHeight += 5+16+ 5+[RSTextHelper getSizeFromFont:[UIFont fontWithName:@"helvetica neue" size:13] AndText:model.L_CONTENT  AndViewSize:CGSizeMake(ScreenWidth-90, 0)].height+5+1;
    }
    return outHeight + inHeight+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DXCommentMainCell *cell = (DXCommentMainCell *)[tableView dequeueReusableCellWithIdentifier:@"DXCommentMainCell" owner:self];
    cell.replay = ^(){
        [self.textViewInput becomeFirstResponder];
        DXGetCommetsItemModel *model = self.arrayComment[self.arrayComment.count-1-indexPath.row];
        if (currentReplay !=model.L_ID.integerValue) {
            
            if (model.L_OWNER.integerValue ==[DXLoginHelp sharedInstance].loginUser.Id) {
                currentReplay =model.L_ID.integerValue;
                self.textViewInput.placeholder = @"评论 :";
                self.textViewInput.text = @"";
            }
            else{
                currentReplay =model.L_ID.integerValue;
                self.textViewInput.placeholder = [NSString stringWithFormat:@"回复 %@:",model.NICK_NAME];
                self.textViewInput.text = @"";
            }
            self.constraintHeightSendView.constant = 49;
        }
        
        
    };
    DXGetCommetsItemModel *model = self.arrayComment[self.arrayComment.count-1-indexPath.row];
    NSMutableArray *commetsItemModels = [NSMutableArray array];
    DXGetCommetsItemModel *startModel = model;
    while ([startModel.L_TYPE isEqualToString:@"1"]&&![startModel.L_REPLY isEqualToString:@"0"]) {
        DXGetCommetsItemModel *addModel = dicReplayModel[startModel.L_REPLY];
        if (addModel!=nil) {
            [commetsItemModels addObject:addModel];
            startModel = addModel;
        }
        else{
            break;
        }
    }
    
//    NSMutableArray *commetsItemModels = [NSMutableArray array];
//    DXGetCommetsItemModel *startModel = model;
//    while ([startModel.L_TYPE isEqualToString:@"1"]&&![startModel.L_REPLY isEqualToString:@"0"]) {
//        [commetsItemModels addObject:dicReplayModel[startModel.L_REPLY]];
//        startModel = dicReplayModel[startModel.L_REPLY];
//    }
    
//    NSLog(@"%@", NSStringFromClass([model class]));
//    if ([model isKindOfClass:[DXAddCommetReallyModel class]]) {
//        [cell setAddCommnetModel:(DXAddCommetReallyModel *)model];
//    }else if([model isKindOfClass:[DXGetCommetsItemModel class]]){
    [cell setModel:(DXGetCommetsItemModel *)model commetsItemModels:commetsItemModels];
//    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (IBAction)addComment:(UIButton *)sender {
   
}
@end
