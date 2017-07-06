//
//  SignUpViewController.m
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/4/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "SignUpViewController.h"
@import Firebase;
@import FirebaseDatabase;


@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dbRef = [[FIRDatabase database] reference];
    _emailId.becomeFirstResponder;
    // Do any additional setup after loading the view.
    
    
    
}
// Create user with Email  

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    // create user with emaild and password
    
    if([identifier isEqualToString:@"unwindToSignIn"])
    {
    
    if([self.emailId.text length] == 0 || [self.password.text length] == 0 || [self.phoneNumber.text length] == 0)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter value in all fields" message:@"Warning!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    

    // Validation for email ID and Password
    else
    {
     [[FIRAuth auth]
     createUserWithEmail:self.emailId.text
     password:self.password.text
     completion:^(FIRUser *_Nullable user,
                  NSError *_Nullable error) {
         
         if (error) {                                                                                    _errorTxtField.hidden = NO;
             _errorTxtField.text = [[error userInfo] objectForKey:@"NSLocalizedDescription"];
             NSLog(@"%zd",error.code);
             NSLog(@"%zd",[[error userInfo] objectForKey:@"NSLocalizedDescription"]);
         }
         else
         {
             [user sendEmailVerificationWithCompletion:^(NSError *_Nullable error){
                 
             }];
             NSLog(@"Successfully created account for the user  :::::: ");
             NSDictionary *registeredUser = @{@"emailId":user.email,
                                              @"password":self.password.text,
                                              @"phoneNumber":self.phoneNumber.text,
                                              @"role":@"user"};
             [[[self.dbRef child:@"users"] child:user.uid] updateChildValues:registeredUser];
             
             [self performSegueWithIdentifier:@"unwindToSignIn" sender:self];
        }
         
     }];

    }
    }
    
    return NO;
}


- (IBAction)createUserWithEmail:(id)sender {
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
}


@end
