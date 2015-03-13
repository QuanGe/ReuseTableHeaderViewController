//
//  ReuseTableHeaderViewController.m
//  CoderPlus
//
//  Created by zhangruquan on 15/3/13.
//  Copyright (c) 2015年 net.csdn. All rights reserved.
//

#import "ReuseTableHeaderViewController.h"

@interface ReuseTableHeaderViewController ()

@end

@implementation ReuseTableHeaderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.m_pReusableHeaders = [NSMutableDictionary  dictionary];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)registerTableHeader:(id)view forReuseIdentifier:(NSString *)reuseIdentifier
{
    NSMutableArray *arrayForIdentifier = [self.m_pReusableHeaders objectForKey:reuseIdentifier];
    if (arrayForIdentifier == nil)
    {
        arrayForIdentifier = [[NSMutableArray alloc] init]; //creates an array to store views sharing a reuse identifier if one does not exist
        [self.m_pReusableHeaders  setObject:arrayForIdentifier forKey:reuseIdentifier];
    }
    
    [arrayForIdentifier addObject:view];
    
}


-   (id)reusableHeadersForReuseIdentifier:(NSString *)reuseIdentifier
{
    NSArray *arrayOfViewsForIdentifier = [self.m_pReusableHeaders  objectForKey:reuseIdentifier];
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
    
    return nil;
    
}

@end
