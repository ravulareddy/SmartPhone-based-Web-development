//
//  ViewController.m
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/4/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
 //   [GIDSignIn sharedInstance].uiDelegate = self;
  //  [GIDSignIn sharedInstance].signInSilently;
   

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error{
    if(error == nil)
    {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential =
        [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                         accessToken:authentication.accessToken];
        
        [[FIRAuth auth]
         signInWithCredential:credential completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
             if(user)
             {
                 NSString * successMsg = [NSString stringWithFormat:@"Welcome to Earnings and Expenses !!, %@", user.displayName];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Firebase" message:successMsg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                 [alert show];
                 _SignInButtonGid.enabled = false;
                 _signOutButton.enabled =  true;
            }
         }];
    }
    
    else{
        
        NSLog(@"%@", error.localizedDescription);
    }
}
- (IBAction)signOutButtonClicked:(id)sender {
    
    FIRAuth *firebaseAuth = [FIRAuth auth];
    NSError *signOutError;
    BOOL status = [firebaseAuth signOut:&signOutError];
    if(!status)
    {
        NSLog(@" Error Signing out : %@", signOutError);
        return;
    }
    
    _SignInButtonGid.enabled = true;
    _signOutButton.enabled= false;
    
}
 

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    // ...
    
    if(error == nil)
    {
        NSString * successMsg = [NSString stringWithFormat:@"Welcome to Earnings and Expenses !!, %@", user.userID];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Firebase" message:successMsg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        _SignInButtonGid.enabled = false;
        _signOutButton.enabled =  true;
    }
    else{
        
        NSLog(@"%@", error.localizedDescription);
    }
}
*/

- (IBAction)signOutButtonClicked:(id)sender {
  //  [GIDSignIn sharedInstance].signOut;
    
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
    }

@end
