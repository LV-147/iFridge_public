//
//  RecipesTableViewController.h
//  iFridge
//
//  Created by Alexey Pelekh on 5/14/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipesCell.h"
#import <AFNetworking/AFNetworking.h>


@interface RecipesTableViewController : UITableViewController
@property (strong, nonatomic) NSString *myLink;
@property (strong, nonatomic) NSDictionary *allRecipes;
@property (strong, nonatomic) NSArray *recipes;


@end
