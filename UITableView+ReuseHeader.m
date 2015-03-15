//
//  UITableView+ReuseHeader.m
//  CoderPlus
//
//  Created by zhangruquan on 15/3/15.
//  Copyright (c) 2015年 net.csdn. All rights reserved.
//

#import "UITableView+ReuseHeader.h"
#import <objc/runtime.h>

@implementation UITableView (ReuseHeader)

+ (void)load {
    [super load];
    Method registNibForHeaderFooter = class_getInstanceMethod(self, @selector(registerNib: forHeaderFooterViewReuseIdentifier:));
    Method registNibForHeaderOrFooter = class_getInstanceMethod(self, @selector(registerNib:forHeaderOrFooterViewReuseIdentifier:));
    method_exchangeImplementations(registNibForHeaderFooter, registNibForHeaderOrFooter);
    
    Method dequeueReusableHeaderFooter = class_getInstanceMethod(self, @selector(dequeueReusableHeaderFooterViewWithIdentifier:));
    Method dequeueReusableHeaderOrFooter = class_getInstanceMethod(self, @selector(dequeueReusableHeaderOrFooterViewWithIdentifier:));
    method_exchangeImplementations(dequeueReusableHeaderFooter, dequeueReusableHeaderOrFooter);
    
}

- (void)setReusableHeaders:(NSMutableDictionary*)header {
 
    objc_setAssociatedObject(self, @selector(reusableHeaders),
                             header,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
}

- (NSMutableDictionary*)reusableHeaders {
    return objc_getAssociatedObject(self, @selector(reusableHeaders));
}

- (void)setHeadersNibDic:(NSMutableDictionary *)nibs {
    
    objc_setAssociatedObject(self, @selector(headersNibDic),
                             nibs,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSMutableDictionary*)headersNibDic {
    return objc_getAssociatedObject(self, @selector(headersNibDic));
}


-(void)registerTableHeader:(id)view forReuseIdentifier:(NSString *)reuseIdentifier
{
   
    NSMutableArray *arrayForIdentifier = [self.reusableHeaders objectForKey:reuseIdentifier];
    [arrayForIdentifier addObject:view];
}


- (id)dequeueReusableHeaderOrFooterViewWithIdentifier:(NSString *)identifier

{
    NSArray *arrayOfViewsForIdentifier = [self.reusableHeaders  objectForKey:identifier];
    if (arrayOfViewsForIdentifier == nil)
    {
        return nil;
    }
    
    NSInteger indexOfAvailableController = [arrayOfViewsForIdentifier indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop)
                                            {
                                                return  [obj superview] == nil;   //If my view doesn’t have a superview, it’s not on-screen.
                                            }];
    
    if (indexOfAvailableController != NSNotFound)
    {
        id availableHeader = [arrayOfViewsForIdentifier objectAtIndex:indexOfAvailableController];
        return availableHeader;    //Success!
    }
    else
    {
        UINib * nib = [self.headersNibDic objectForKey:identifier];
        id view = [[nib instantiateWithOwner:self.delegate options:nil] objectAtIndex:0];
        NSMutableArray *arrayForIdentifier = [self.reusableHeaders objectForKey:identifier];
        [arrayForIdentifier addObject:view];
        
        return view;
            
        
    }
    
    return nil;
    
}

- (void)registerNib:(UINib *)nib forHeaderOrFooterViewReuseIdentifier:(NSString *)identifier
{
    //
    if(self.headersNibDic ==nil)
    {
        self.headersNibDic = [NSMutableDictionary dictionary];
    }
    
    [self.headersNibDic setObject:nib
                           forKey:identifier];
    
    if(self.reusableHeaders == nil)
        self.reusableHeaders = [NSMutableDictionary  dictionary];
    NSMutableArray *arrayForIdentifier = [self.reusableHeaders objectForKey:identifier];
    if (arrayForIdentifier == nil)
    {
        arrayForIdentifier = [[NSMutableArray alloc] init]; //creates an array to store views sharing a reuse identifier if one does not exist
        [self.reusableHeaders  setObject:arrayForIdentifier forKey:identifier];
    }
    
}
@end
