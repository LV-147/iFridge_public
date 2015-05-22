//
//  UIButton+DatesBlock.h
//  iFridge
//
//  Created by Pavlo Bardar on 5/21/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DatesButtonActionBlock)(UIButton *sender);

@interface UIButton (DatesBlock)

- (void)addActionblock:(DatesButtonActionBlock)actionBlock forControlEvents:(UIControlEvents)events;


- (DatesButtonActionBlock)actionBlock;


@end
