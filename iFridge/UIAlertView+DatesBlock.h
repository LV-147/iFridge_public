//
//  UIAlertView+DatesBlock.h
//  iFridge
//
//  Created by Pavlo Bardar on 5/21/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DatesAlertViewCompletionBlock)(UIAlertView *alertView, NSInteger buttonIndex);

@interface UIAlertView (DatesBlock) <UIAlertViewDelegate>

- (void)setCompletionBlock:(DatesAlertViewCompletionBlock)completionBlock;
- (DatesAlertViewCompletionBlock)completionBlock;

@end
