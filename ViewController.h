//
//  ViewController.h
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/4/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
//@import FirebaseAuth;
@import GoogleSignIn;

@interface ViewController : UIViewController<GIDSignInUIDelegate>




//@property (weak, nonatomic) IBOutlet GIDSignInButton *SignInButtonGid;

@property (weak, nonatomic) IBOutlet UIButton *signOutButton;

@end

