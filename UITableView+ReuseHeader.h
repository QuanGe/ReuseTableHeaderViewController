//
//  UITableView+ReuseHeader.h
//  CoderPlus
//
//  Created by zhangruquan on 15/3/15.
//  Copyright (c) 2015年 net.csdn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ReuseHeader)
@property(nonatomic,strong) NSMutableDictionary * reusableHeaders;
@property(nonatomic,strong) NSMutableDictionary * headersNibDic;
- (id)dequeueReusableHeaderOrFooterViewWithIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forHeaderOrFooterViewReuseIdentifier:(NSString *)identifier;
@end
