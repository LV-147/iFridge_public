//
//  UIButton+FridgeBlock.h
//  iFridge
//
//  Created by Pavlo Bardar on 5/23/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^FridgeButtonActionBlock)(UIButton *sender);


@interface UIButton (FridgeBlock)

- (void)addActionblock:(FridgeButtonActionBlock)actionBlock forControlEvents:(UIControlEvents)events;
- (FridgeButtonActionBlock)actionBlock;

@end
