//
//  NSString+Encoding.m
//  QWeiboSDK4iOS
//
//  Created on 11-1-12.
//  
//

#import "NSString+QEncoding.h"


@implementation NSString (QOAEncoding)

- (NSString *)URLEncodedString 
{
    NSNumber *n;
    [n stringValue];
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
																		   CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8));
	return result;
}

- (NSString*)URLDecodedString
{
	NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8));
	return result;	
}


@end
