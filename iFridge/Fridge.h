//
//  Fridge.h
//  iFridge
//
//  Created by Alexey Pelekh on 5/12/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipes;

@interface Fridge : NSManagedObject

@property (nonatomic, retain) NSString * listOfProducts;
@property (nonatomic, retain) NSDate * dateOfExp;
@property (nonatomic, retain) Recipes *fromWhatToMake;

@end
