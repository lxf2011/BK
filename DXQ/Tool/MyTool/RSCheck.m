//
//  RSCheck.m
//  DXQ
//
//  Created by rason on 8/13/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "RSCheck.h"
#import "RegexKitLite.h"

@implementation RSCheck
+(BOOL)checkPSWWithTextField:(UITextField *)textfield comfirmTextfield:(UITextField *)comfirmTextfield{
    
    if (![textfield.text isMatchedByRegex:@"^[0-9a-zA-Z]{6,12}$"]){
        [[UIApplication sharedApplication].keyWindow makeToast:@"密码需为6-12位数字或字母"];
        return NO;
    }
    if (textfield.text.length==0||comfirmTextfield.text.length==0) {
        [[UIApplication sharedApplication].keyWindow makeToast:@"密码不能为空"];
        return NO;
    }
    if (![textfield.text isEqualToString:comfirmTextfield.text]) {
        [[UIApplication sharedApplication].keyWindow makeToast:@"两次密码不一致"];
        return NO;
    }
    return YES;
}
+(BOOL) checkPhone:(UITextField *)phone{
    if (phone.text.length==0) {
        [[UIApplication sharedApplication].keyWindow makeToast:@"手机号码不能为空"];
        return NO;
    }
    if (phone.text.length != 11) {
       [[UIApplication sharedApplication].keyWindow makeToast:@"请输入正确的手机号码"];
        return NO;
    }
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (![regextestmobile evaluateWithObject:phone.text]
        && ![regextestcm evaluateWithObject:phone.text]
        && ![regextestct evaluateWithObject:phone.text]
        && ![regextestcu evaluateWithObject:phone.text])
    {
        return NO;
    }
    return YES;
    
}
+(BOOL) checkIsNilForTextField:(UITextField *)textField tip:(NSString *)tip{
    if (textField.text.length==0) {
        [[UIApplication sharedApplication].keyWindow makeToast:[NSString stringWithFormat:@"%@不能为空",tip]];
        return NO;
    }
    return YES;
}

+ (BOOL)checkStringCount:(NSUInteger)count inTextView:(UITextView *)textView tip:(NSString *)tip{
    if (textView.text.length < count) {
        [[UIApplication sharedApplication].keyWindow makeToast:[NSString stringWithFormat:@"%@字数少于%zd",tip, count]];
        return NO;
    }
    return YES;
}

+ (BOOL)checkIsNilForTextView:(UITextView *)textView tip:(NSString *)tip{
    if (textView.text.length==0) {
        [[UIApplication sharedApplication].keyWindow makeToast:[NSString stringWithFormat:@"%@不能为空",tip]];
        return NO;
    }
    return YES;
}
@end
