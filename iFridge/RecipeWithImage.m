//
//  RecipeWithImage.m
//  iFridge
//
//  Created by Alexey Pelekh on 5/15/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import "RecipeWithImage.h"
#import "RecipesTableViewController.h"
#import "Recipe+Cat.h"
#import "UIViewController+Context.h"
#import "AppDelegate.h"


@interface RecipeWithImage ()

@end

@implementation RecipeWithImage

- (IBAction)saveRecipeToCoreData:(UIBarButtonItem *)sender {
    
    [Recipe createRecipeWithInfo:self.recipeDict inManagedObiectContext:self.currentContext];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    NSLog(@"JSON: %@", self.imageLink);
    //    NSLog(@"JSON: %@", self.ingredientsLines);
    
    self.textViewForRecipe.text = [NSString stringWithFormat:@"%@", self.ingredientsLines];
    
    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:self.imageLink] options:SDWebImageDownloaderLowPriority
                                                        progress:nil
                                                       completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                           
                                                           [self.imageForDish setBackgroundColor:[UIColor colorWithPatternImage:image]];
                                                       }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
