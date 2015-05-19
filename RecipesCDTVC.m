//
//  RecipesTableViewController.m
//  iFridge
//
//  Created by Vladius on 5/15/15.
//  Copyright (c) 2015 Vladius. All rights reserved.
//

#import "RecipesCell.h"
#import "RecipesCDTVC.h"
#import "RecipeWithImage.h"
#import "Recipe+Cat.h"
#import "UIViewController+Context.h"
#import "Ingredient.h"

@interface RecipesCDTVC ()

@property (strong, nonatomic)NSArray *recipes;

@end

@implementation RecipesCDTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
        self.recipes = [[NSArray alloc] init];
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
        request.predicate = nil;
        NSError *error;
        
        self.recipes = [self.currentContext executeFetchRequest:request error:&error];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.recipes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecipesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    
    Recipe *recipe = self.recipes[indexPath.row];
    cell.nameOfDish.text = recipe.label;
    cell.cookingTime.text = [NSString stringWithFormat:@"Cooking time: %@ s", recipe.cookingTime];
    cell.caloriesTotal.text = [NSString stringWithFormat:@"Total calories %@", recipe.calories];
    cell.weightTotal.text = [NSString stringWithFormat:@"Total weight: %@ g", recipe.weight];
    cell.fatTotal.text = [NSString stringWithFormat:@"Total fat: %@ g", recipe.fat];
    cell.sugarsTotal.text = [NSString stringWithFormat:@"Total sugar %@ g", recipe.sugars];
    cell.cookingLevel.text = [NSString stringWithFormat:@"Cooking level: %@", recipe.cookingLevel];

    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RecipesCell *cell = (RecipesCell *)sender;
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    Recipe *recipe = self.recipes[path.row];
    
    RecipeWithImage *newController = segue.destinationViewController;
    newController.imageLink = recipe.imageUrl;
    
    NSMutableDictionary *ingredienteLines = [[NSMutableDictionary alloc] init];
    NSNumber *numb = [[NSNumber alloc] initWithInt:0];
    for (Ingredient *ingredient in recipe.ingredients) {
        [ingredienteLines setObject:ingredient.label forKey:numb];
        int value = [numb intValue];
        numb = [NSNumber numberWithInt:value + 1];
    }
    
    newController.ingredientsLines = ingredienteLines;
    
}


@end
