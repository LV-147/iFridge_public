//
//  Recipes.h
//  iFridge
//
//  Created by Alexey Pelekh on 5/12/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Recipes : NSManagedObject

@property (nonatomic, retain) NSString * imageOfProduct;
@property (nonatomic, retain) NSString * instructutionOfUsage;
@property (nonatomic, retain) NSString * listOfProducts;
@property (nonatomic, retain) NSSet *howToMake;
@end

@interface Recipes (CoreDataGeneratedAccessors)

- (void)addHowToMakeObject:(NSManagedObject *)value;
- (void)removeHowToMakeObject:(NSManagedObject *)value;
- (void)addHowToMake:(NSSet *)values;
- (void)removeHowToMake:(NSSet *)values;

@end
