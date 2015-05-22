//
//  RecipeWithImage.m
//  iFridge
//
//  Created by Alexey Pelekh on 5/15/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import "RecipeWithImage.h"
#import "RecipesTVC.h"
#import "Recipe+Cat.h"
#import "UIViewController+Context.h"
#import "AppDelegate.h"


@interface RecipeWithImage ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation RecipeWithImage



- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.recipeSaved) {
        self.saveButton.title = @"Delete";
    }else self.saveButton.title = @"Save";
    
    self.textViewForRecipe.text = [NSString stringWithFormat:@"%@", self.ingredientsLines];
    
    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:self.imageLink] options:SDWebImageDownloaderLowPriority
                                                        progress:nil
                                                       completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                           
                                                           [self.imageForDish setBackgroundColor:[UIColor colorWithPatternImage:image]];
                                                       }];
    
}

- (IBAction)saveRecipeToCoreData:(UIBarButtonItem *)sender {
    
    if (self.recipeDict) {
        if (!self.recipeSaved){
            [Recipe createRecipeWithInfo:self.recipeDict inManagedObiectContext:self.currentContext];
            self.recipeSaved = YES;
            sender.title = @"Delete";
        }else{
            [Recipe deleteRecipeWithInfo:self.recipeDict from:self.currentContext];
            self.recipeSaved = NO;
            sender.title = @"Save";
        }
    }else{
        if (!self.recipeSaved) {
            [Recipe saveRecipe:self.recipe inManagedObjectContext:self.currentContext];
            self.recipeSaved = YES;
            sender.title = @"Delete";
        }else{
            [Recipe deleteRecipe:self.recipe fromManagedObjectContext:self.currentContext];
            self.recipeSaved = NO;
            sender.title = @"Save";
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
