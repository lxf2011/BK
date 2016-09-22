//
//  PrintObject.m
//  DXQ
//
//  Created by rason on 8/11/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "PrintObject.h"
#import <objc/runtime.h>
@implementation PrintObject

/**
 *  将对象的属性名和属性值转换为字典
 */
+(NSDictionary*)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil)
        {
            value = [NSNull null];
        }
         else
        {
            value = [self getObjectInternal:value];
            
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}



+
(void)print:(id)obj

{
    
    NSLog(@"%@",
          [self getObjectData:obj]);
    
}





+
(NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error

{
    
    return
    
    [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
    
}



+
(id)getObjectInternal:(id)obj

{
    
    if([obj
        isKindOfClass:[NSString class]]
       
       ||
       [obj isKindOfClass:[NSNumber class]]
       
       ||
       [obj isKindOfClass:[NSNull class]])
        
    {
        
        return
        
        obj;
        
    }
    
    
    
    if([obj
        isKindOfClass:[NSArray class]])
        
    {
        
        NSArray
        *objarr = obj;
        
        NSMutableArray
        *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int
            i = 0;i < objarr.count; i++)
            
        {
            
            [arr
             setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
            
        }
        
        return
        
        arr;
        
    }
    
    
    
    if([obj
        isKindOfClass:[NSDictionary class]])
        
    {
        
        NSDictionary
        *objdic = obj;
        
        NSMutableDictionary
        *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString
            *key in
            
            objdic.allKeys)
            
        {
            
            [dic
             setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
            
        }     
        
        return
        
        dic;
        
    } 
    
    return
    
    [self getObjectData:obj];
    
}
@end