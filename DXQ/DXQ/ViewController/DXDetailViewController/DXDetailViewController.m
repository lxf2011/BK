//
//  InformationDetailViewController.m
//  DXQ
//
//  Created by 做功课 on 15/7/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "DXDetailViewController.h"
#import "DXOptionView.h"
#import "DXCommentViewController.h"
#import "DXPreferenceTool.h"
#import "DXPreferenceTool.h"
#import "RSProgressHUD.h"
@interface DXDetailViewController () <DXOptionViewDelegate,UIWebViewDelegate>
@property (nonatomic, strong) DXOptionView *optionView;
@end

@implementation DXDetailViewController

- (DXOptionView *)optionView{
    if(!_optionView){
        DXOptionView *optionView = [DXOptionView create];
        if (optionView.dicShareInfo ==nil) {
            optionView.dicShareInfo = [NSMutableDictionary dictionary];
        }
        @try {
            [optionView.dicShareInfo setObject:self.hTitle forKey:@"title"];
        }
        @catch (NSException *exception) {
            [optionView.dicShareInfo setObject:@"" forKey:@"title"];
        }
        @finally {
            
        }
        
        @try {
            [optionView.dicShareInfo setObject:self.L_INTRO forKey:@"intro"];
        }
        @catch (NSException *exception) {
            @try {
                [optionView.dicShareInfo setObject:[self.model valueForKey:@"L_SPECIAL_INTRO"] forKey:@"intro"];
            }
            @catch (NSException *exception) {
                
            }
        }
        @finally {
            
        }
        if (self.urlStr!=nil) {
            [optionView.dicShareInfo setObject:[NSString stringWithFormat:@"%@&type=app",self.urlStr] forKey:@"url"];
        }
        else{
            [optionView.dicShareInfo setObject:@"" forKey:@"url"];
        }
        
        NSString *L_PIC;
        @try {
            L_PIC= [self.model valueForKey:@"L_PIC"];
        }
        @catch (NSException *exception) {
            L_PIC= [self.model valueForKey:@"LPIC"];
        }
        @finally {
            
        }
        
        
        NSArray *arr = [L_PIC componentsSeparatedByString:@","];
        NSString *finalPic;
        if ([arr count]>=1) {
            if ([arr[0] hasPrefix:@"http://"]||[arr[0] hasPrefix:@"https://"]) {
                finalPic = arr[0];
            }
            else{
                finalPic = [NSString stringWithFormat:@"%@%@",DXNetworkAddress,arr[0]];
            }
        }
        [optionView.dicShareInfo setObject:finalPic forKey:@"pic"];
        NSLog(@"分享参数:%@",optionView.dicShareInfo);
        optionView.delegate = self;
        [optionView refreshByTarget:self.LTARGET ID:self.LTARID];
        [optionView refreshCollectByTarget:self.LTARGET ID:self.LTARID];
        
        
        optionView.opotionViewBlock = ^(NSString *PRAISE, NSString *COLLECT){
            if (![PRAISE isEqualToString:@""]) {
                @try {
                    [self.model setValue:PRAISE forKey:@"L_SUM_PRAISE"];
                }
                @catch (NSException *exception) {
                    [self.model setValue:PRAISE forKey:@"LSUMPRAISE"];
                }
                @finally {
                    
                }
            }
            if (![COLLECT isEqualToString:@""]) {
                @try {
                    [self.model setValue:COLLECT forKey:@"L_SUM_COLLECT"];
                }
                @catch (NSException *exception) {
                    [self.model setValue:COLLECT forKey:@"LSUMCOLLECT"];
                }
                @finally {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCollectStatusChange object:nil];
                }
            }
            
        };
        self.optionView = optionView;
        [self.viewBottom addSubview:optionView];
        [self.optionView setWidth:self.viewBottom.width];
        
    }
    return _optionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initView];
    [self.view adaptSubViews];
    self.webView.delegate = self;
    if(self.urlStr){
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
        [self.webView loadRequest:request];
    }else{
        [self.webView loadHTMLString:self.html baseURL:nil];
    }

}

- (void)refreshOptionViewWithCollect:(NSString *)collect comment:(NSString *)comment praise:(NSString *)praise  share:(NSString *)share{
    [self.optionView.buttonLike setTitle:praise forState:UIControlStateNormal];
    [self.optionView.buttonCommet setTitle:comment forState:UIControlStateNormal];
    [self.optionView.buttonCollect setTitle:collect forState:UIControlStateNormal];
    [self.optionView.buttonShare setTitle:share forState:UIControlStateNormal];
}

- (void)refreshOptionViewWithComment:(NSString *)comment{
    [self.optionView.buttonCommet setTitle:comment forState:UIControlStateNormal];    
}

//- (void)initView{
//    DXOptionView *optionView = [DXOptionView create];
//    optionView.delegate = self;
//    self.optionView = optionView;
//    [self.viewBottom addSubview:optionView];
//    
//}

#pragma mark -DXOptionViewDelegate
- (void)optionView:(DXOptionView *)optionView didClickButton:(DXOptionViewButtonType)buttonType{
    switch (buttonType) {
        case DXOptionViewButtonTypeComment:
        {
            DXCommentViewController *commentVc = [[DXCommentViewController alloc]initWithNibName:@"DXCommentViewController" bundle:nil];
            commentVc.LTRAID = self.LTARID;
            commentVc.LTARGET = self.LTARGET;
            [self.navigationController pushViewController:commentVc animated:YES];
            break;
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadWebPageWithString:(NSString*)urlString
{
    [RSProgressHUD show];
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [RSProgressHUD dismiss];
    //图片自定适配宽度
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@%.f",@"var tempWidth=",ScreenWidth-20]];
    [self.webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = tempWidth;" // UIWebView中显示的图片宽度
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "var ratio = 1.0*myimg.width/myimg.height;"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.width/ratio;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}
-(void)viewDidDisappear:(BOOL)animated{
    [RSProgressHUD dismiss];
}
@end
