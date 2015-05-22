//
//  DataDownloader.m
//  iFridge
//
//  Created by Vladius on 5/21/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import "DataDownloader.h"
#import "RecipesTVC.h"

@implementation DataDownloader

+ (void)getData
{
    RecipesTVC *rtvc = [[RecipesTVC alloc] init];
    NSString *myRequest = [[NSString alloc] initWithFormat:@"%@%@%@", @"https://api.edamam.com/search?q=",rtvc.query,@"&app_id=4e8543af&app_key=e1309c8e747bdd4d7363587a4435f5ee&from=0&to=100"];
    NSLog(@"myLink: %@", myRequest);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:myRequest parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        rtvc.allRecipes = (NSDictionary *) responseObject;
        rtvc.recipes = rtvc.allRecipes[@"hits"];
        //NSLog(@"JSON: %@", self.recipes);
        dispatch_async(dispatch_get_main_queue(), ^{
            [rtvc.tableView reloadData];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
