//
//  SignUpViewController.h
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/4/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
#import "NSString+Validations.h"


@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailId;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *errorTxtField;

@property FIRDatabaseReference *dbRef;



@end
