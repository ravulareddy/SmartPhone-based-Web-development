//
//  SignInViewController.m
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/4/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // google sign in
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    self.dbRef = [[FIRDatabase database] reference];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"userLogin"]){
        [[FIRAuth auth]
         signInWithEmail:_emailId.text
         password:_password.text
         completion:^(FIRUser *user, NSError *error) {
             if (error) {
                 _errorTxtField.hidden = NO;
                 _errorTxtField.text = [[error userInfo] objectForKey:@"NSLocalizedDescription"];
                 NSLog(@"%zd",error.code);
                 NSLog(@"%zd",[[error userInfo] objectForKey:@"NSLocalizedDescription"]);
             }else{
                 [self performSegueWithIdentifier:@"userLogin" sender:self];
                 NSLog(@"user logged in Successfully :: %@", user.email);
                 NSLog(@"user logged in Successfully :: %@", user.uid);
             }
             
         }];
    }
    else{
        [self performSegueWithIdentifier:@"registerUser" sender:self];
    }
    
 
    return NO;
}

// google sign in
- (IBAction)googleSignInButtonClicked:(id)sender {
    
    [[GIDSignIn sharedInstance] signIn];
    
}
// google sign in

- (IBAction)GsignInButtonClicked:(id)sender {
    
  //  [[GIDSignIn sharedInstance] signIn];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error == nil) {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential =
        [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                         accessToken:authentication.accessToken];
        // ...
        
        
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
                                      // ...
                                      if (error) {                                                                                    _errorTxtField.hidden = NO;
                                          _errorTxtField.text = [[error userInfo] objectForKey:@"NSLocalizedDescription"];
                                          NSLog(@"%zd",error.code);
                                          NSLog(@"%zd",[[error userInfo] objectForKey:@"NSLocalizedDescription"]);
                                      }else{
                                          NSLog(@" user is logging in %@",user.uid);
                                          
                                          
                                         //     NSLog(@"Successfully created account for the user  :::::: ");
                                              NSDictionary *registeredUser = @{@"emailId":user.email,
                                                                                @"role":@"user"};
                                              [[[self.dbRef child:@"users"] child:user.uid] updateChildValues:registeredUser];
                                          

                                          
                                          [self performSegueWithIdentifier:@"userHome" sender:self];
                                          
                                      }
                                  }];
        
    } else{
        NSLog(@" Google sign in error %@",error.localizedDescription);
        // ...
    }
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}


/*
-(void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error{
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
                 self.googleSignInButton.enabled = false;
           //      _signOutButton.enabled =  true;
             }
         }];
    }
    
    else{
        
        NSLog(@"%@", error.localizedDescription);
    }
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)unwindToLoginPage:(UIStoryboardSegue *)unwindSeque{
    
}

@end
