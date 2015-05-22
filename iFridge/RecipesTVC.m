//
//  RecipesTableViewController.m
//  iFridge
//
//  Created by Alexey Pelekh on 5/14/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import "RecipesTVC.h"
#import "RecipeWithImage.h"
#import "Recipe.h"
#import "Ingredient.h"
#import "UIViewController+Context.h"
#import "DataDownloader.h"

@interface RecipesTVC ()


@property (strong, nonatomic)NSArray *coreDataRecipes;
@end

@implementation RecipesTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *myRequest = [[NSString alloc] initWithFormat:@"%@%@%@", @"https://api.edamam.com/search?q=",self.query,@"&app_id=4e8543af&app_key=e1309c8e747bdd4d7363587a4435f5ee&from=0&to=100"];
    NSLog(@"myLink: %@", myRequest);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:myRequest parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.allRecipes = (NSDictionary *) responseObject;
        self.recipes = self.allRecipes[@"hits"];
        //NSLog(@"JSON: %@", self.recipes);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    self.coreDataRecipes = [[NSArray alloc] init];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
    request.predicate = nil;
    NSError *error;
    
    self.coreDataRecipes = [self.currentContext executeFetchRequest:request error:&error];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectDataSource:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.dataSource = @"Search results";
            [self.tableView reloadData];
            break;
        case 1:
            self.dataSource = @"My recipes";
            [self.tableView reloadData];
            break;
        default:
            break;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource isEqualToString:@"Search results"]) {
        return self.recipes.count;
    }else
        return self.coreDataRecipes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    if ([self.dataSource isEqualToString:@"Search results"]) {
        cell.nameOfDish.text = self.recipes[indexPath.row][@"recipe"][@"label"];
        
        cell.cookingLevel.text = self.recipes[indexPath.row][@"recipe"][@"level"];
        
        cell.cookingTime.text = [NSString stringWithFormat:@"cookingTime: %@", self.recipes[indexPath.row][@"recipe"][@"cookingTime"]];
        
        double str1 = [self.recipes[indexPath.row][@"recipe"][@"calories"] doubleValue];
        NSString *caloriesTotal = [NSString stringWithFormat:@"calories: %2.3f", str1];
        cell.caloriesTotal.text = [NSString stringWithString:caloriesTotal];
        
        double str4 = [self.recipes[indexPath.row][@"recipe"][@"totalNutrients"][@"SUGAR"][@"quantity"] doubleValue];
        NSString *sugarsTotal = [NSString stringWithFormat:@"sugar: %2.3f", str4];
        cell.sugarsTotal.text = [NSString stringWithString:sugarsTotal];
        
        
        double str3 = [self.recipes[indexPath.row][@"recipe"][@"totalWeight"] doubleValue];
        NSString *weightTotal = [NSString stringWithFormat:@"weight: %2.3f", str3];
        cell.weightTotal.text = [NSString stringWithString:weightTotal];
        
        double str2 = [self.recipes[indexPath.row][@"recipe"][@"totalNutrients"][@"FAT"][@"quantity"] doubleValue];
        NSString *fatTotal = [NSString stringWithFormat:@"fat: %2.3f", str2];
        cell.fatTotal.text = [NSString stringWithString:fatTotal];
        
        return cell;
        
    }else{
        
        Recipe *recipe = self.coreDataRecipes[indexPath.row];
        cell.nameOfDish.text = recipe.label;
        cell.cookingTime.text = [NSString stringWithFormat:@"Cooking time: %@ s", recipe.cookingTime];
        cell.caloriesTotal.text = [NSString stringWithFormat:@"Total calories %@", recipe.calories];
        cell.weightTotal.text = [NSString stringWithFormat:@"Total weight: %@ g", recipe.weight];
        cell.fatTotal.text = [NSString stringWithFormat:@"Total fat: %@ g", recipe.fat];
        cell.sugarsTotal.text = [NSString stringWithFormat:@"Total sugar %@ g", recipe.sugars];
        cell.cookingLevel.text = [NSString stringWithFormat:@"Cooking level: %@", recipe.cookingLevel];
        
        return cell;
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RecipesCell *cell = (RecipesCell *)sender;
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    
    RecipeWithImage *newController = segue.destinationViewController;
    if ([self.dataSource isEqualToString:@"Search results"]) {
        newController.imageLink = self.recipes[path.row][@"recipe"][@"image"];
        newController.ingredientsLines = self.recipes[path.row][@"recipe"][@"ingredientLines"];
        newController.recipeDict = [[self.recipes objectAtIndex:path.row] valueForKey:@"recipe"];
    }else{
        Recipe *recipe = self.coreDataRecipes[path.row];
        newController.imageLink = recipe.imageUrl;
        newController.recipeSaved = YES;
        newController.recipe = recipe;
        
        NSMutableDictionary *ingredienteLines = [[NSMutableDictionary alloc] init];
        NSNumber *numb = [[NSNumber alloc] initWithInt:0];
        for (Ingredient *ingredient in recipe.ingredients) {
            [ingredienteLines setObject:ingredient.label forKey:numb];
            int value = [numb intValue];
            numb = [NSNumber numberWithInt:value + 1];
        }
        
        newController.ingredientsLines = ingredienteLines;
    }
}

@end
