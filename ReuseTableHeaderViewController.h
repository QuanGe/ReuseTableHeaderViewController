//
//  ReuseTableHeaderViewController.h
//  CoderPlus
//
//  Created by zhangruquan on 15/3/13.
//  Copyright (c) 2015年 net.csdn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReuseTableHeaderViewController : UIViewController
@property(nonatomic,strong) NSMutableDictionary * m_pReusableHeaders;

-(void)registerTableHeader:(id)view forReuseIdentifier:(NSString *)reuseIdentifier;
-   (id)reusableHeadersForReuseIdentifier:(NSString *)reuseIdentifier;
@end
