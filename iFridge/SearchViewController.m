//
//  SearchViewController.m
//  iFridge
//
//  Created by Alexey Pelekh on 5/15/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import "SearchViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "VKSdk.h"
#import <GoogleOpenSource/GTLPlusConstants.h>
#import <GooglePlus/GPPSignInButton.h>

static NSString * const vkAppID = @"4921324";
static NSString * const kClientID = @"479226462698-nuoqkaoi6c79be4ghh4he3ov05bb1kpc.apps.googleusercontent.com";



@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize signInButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.clientID = kClientID;
    signIn.scopes = [NSArray arrayWithObjects:
                     kGTLAuthScopePlusLogin,nil];
    signIn.delegate = self;
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    
    loginButton.frame = CGRectMake(34, 611, 306, 46);
    
    [self.view addSubview:loginButton];
    [signIn trySilentAuthentication];
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Обработка ошибок
    } else {
        [self refreshInterfaceBasedOnSignIn];
    }
}

-(void) vkSdkReceivedNewToken:(VKAccessToken*) newToken{
    
}

-(void) vkSdkUserDeniedAccess:(VKError*) authorizationError {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)signOut {
    [[GPPSignIn sharedInstance] signOut];
}

- (void)disconnect {
    [[GPPSignIn sharedInstance] disconnect];
}

- (void)didDisconnectWithError:(NSError *)error {
    if (error) {
        NSLog(@"Received error %@", error);
    } else {
        // Пользователь вышел и отключился.
        // Удалим данные пользователя в соответствии с Условиями использования Google+.
    }
}

- (IBAction)searchButton:(id)sender {
    UIAlertView *noText = [[UIAlertView alloc] initWithTitle:@"Table is empty because no text was detected!" message:@"Please, enter some text in Search field!" delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
    
   if([self.searchTextField.text  isEqual: @""]) [noText show];
    
}

-(void)refreshInterfaceBasedOnSignIn
{
    if ([[GPPSignIn sharedInstance] authentication]) {
        // Пользователь вошел.
        self.signInButton.hidden = YES;
        // Прочие действия, например отображение кнопки выхода
    } else {
        self.signInButton.hidden = NO;
        // Прочие действия
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:@"SegueToRecipesTVC"]){
       
        RecipesTVC *newController = segue.destinationViewController;
        newController.query = [NSString stringWithString: self.searchTextField.text];
        newController.dataSource = @"Search results";
    }
    if ([segue.identifier isEqualToString:@"SegueToMyRecipes"]){
        RecipesTVC *newController = segue.destinationViewController;
        newController.query = [NSString stringWithString: self.searchTextField.text];
        newController.dataSource = @"My recipes";
        newController.selectDataSourceButton.selectedSegmentIndex = 1;
    }
}

@end