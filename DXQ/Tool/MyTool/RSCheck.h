//
//  RSCheck.h
//  DXQ
//
//  Created by rason on 8/13/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSCheck : NSObject
+(BOOL)checkPSWWithTextField:(UITextField *)textfield comfirmTextfield:(UITextField *)comfirmTextfield;
+(BOOL) checkPhone:(UITextField *)phone;
+(BOOL) checkIsNilForTextField:(UITextField *)textField tip:(NSString *)tip;
+ (BOOL)checkStringCount:(NSUInteger)count inTextView:(UITextView *)textView tip:(NSString *)tip;
+ (BOOL)checkIsNilForTextView:(UITextView *)textView tip:(NSString *)tip;
@end
