//
//  UIImageView+DXWebCache.m
//  DXQ
//
//  Created by rason on 15/9/19.
//  Copyright © 2015年 rason. All rights reserved.
//

#import "UIImageView+DXWebCache.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (DXWebCache)
- (void)sd_setImageWithURL_dx:(NSString *)urlStr placeholderImage:(UIImage *)placeholder{
    NSURL *url;
    NSArray *arr = [urlStr componentsSeparatedByString:@","];
    if ([arr count]>=1) {
        if ([arr[0] hasPrefix:@"http://"]||[arr[0] hasPrefix:@"https://"]) {
            url = [NSURL URLWithString:arr[0]];
        }
        else{
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DXNetworkAddress,arr[0]]];
        }
    }
    self.backgroundColor = [UIColor colorWithString:@"#e5e5e5"];
    [self sd_setImageWithURL:url placeholderImage:placeholder];
}
@end
