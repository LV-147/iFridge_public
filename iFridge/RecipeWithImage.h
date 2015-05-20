//
//  RecipeWithImage.h
//  iFridge
//
//  Created by Alexey Pelekh on 5/15/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//


#import <SDWebImage/SDWebImageDownloader.h>
#import <SDWebImage/SDWebImageManager.h>

@interface RecipeWithImage : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageForDish;
@property (strong, nonatomic) IBOutlet UITextView *textViewForRecipe;
@property (strong, nonatomic) NSString * imageLink;
@property (strong, nonatomic) NSMutableDictionary * ingredientsLines;
@property (strong, nonatomic) NSMutableArray *avaivableRecipes;
@property (strong, nonatomic) NSIndexPath *recipeIndex;

- (void) setRecipeWithImageContents:(NSInteger)recipeIndexPath;

@end
