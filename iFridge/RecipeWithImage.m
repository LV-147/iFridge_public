//
//  RecipeWithImage.m
//  iFridge
//
//  Created by Alexey Pelekh on 5/15/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import "RecipeWithImage.h"


@interface RecipeWithImage ()
@property (nonatomic, assign) NSInteger recipeRow;
@end

@implementation RecipeWithImage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recipeRow = self.recipeIndex.row;
    [self setRecipeWithImageContents:self.recipeRow];
}

- (void) setRecipeWithImageContents:(NSInteger)recipeIndexPath
{
    _imageLink = self.avaivableRecipes[recipeIndexPath][@"recipe"][@"image"];
    _ingredientsLines = self.avaivableRecipes[recipeIndexPath][@"recipe"][@"ingredientLines"];
    self.textViewForRecipe.text = [NSString stringWithFormat:@"%@", _ingredientsLines];
    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:_imageLink] options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        [self.imageForDish setBackgroundColor:[UIColor colorWithPatternImage:image]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (IBAction)goToNextCell:(id)sender {

    ++self.recipeRow;
    //костиль, треба зробити універсальний (!self.recipeRow) i td
    if(self.recipeRow == self.avaivableRecipes.count){
        self.recipeRow = 0;
        [self setRecipeWithImageContents:self.recipeRow];
    }else{
        [self setRecipeWithImageContents:self.recipeRow];
    }

    
}

- (IBAction)goToPreviousCell:(id)sender {
    --self.recipeRow;
    if (self.recipeRow == -1){
        self.recipeRow = self.avaivableRecipes.count - 1;
        [self setRecipeWithImageContents:self.recipeRow];
    }else{
        [self setRecipeWithImageContents:self.recipeRow];
    }

}

@end
