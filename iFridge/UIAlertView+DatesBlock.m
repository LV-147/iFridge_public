//
//  UIAlertView+DatesBlock.m
//  iFridge
//
//  Created by Pavlo Bardar on 5/21/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import "UIAlertView+DatesBlock.h"
#import <objc/runtime.h>

@implementation UIAlertView (DatesBlock)

- (void)setCompletionBlock:(DatesAlertViewCompletionBlock)completionBlock {
    objc_setAssociatedObject(self, @selector(completionBlock), completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (completionBlock == NULL) {
        self.delegate = nil;
    }
    else {
        self.delegate = self;
    }
}

- (DatesAlertViewCompletionBlock)completionBlock {
    return objc_getAssociatedObject(self, @selector(completionBlock));
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (self.completionBlock) {
        self.completionBlock(self, buttonIndex);
    }
}


@end
