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


@interface RecipesTableViewController : UITableViewController{
    IBOutlet UIActivityIndicatorView *activityIndicator;
    NSTimer *timer;
    
}
@property (strong, nonatomic) NSString *myLink;
@property (strong, nonatomic) NSDictionary *allRecipes;
@property (strong, nonatomic) NSMutableArray *recipes;
@property (strong, nonatomic) NSMutableDictionary *name;
@property (strong, nonatomic) NSMutableDictionary *cookingTime;
@property (strong, nonatomic) NSMutableDictionary *calories;
@property (strong, nonatomic) NSMutableDictionary *totalWeight;
@property (strong, nonatomic) NSMutableDictionary *fat;
@property (strong, nonatomic) NSMutableDictionary *sugars;
@property (strong, nonatomic) NSMutableDictionary *cookingLevel;



@end
