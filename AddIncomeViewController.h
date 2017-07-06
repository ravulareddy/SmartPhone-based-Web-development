//
//  AddIncomeViewController.h
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/15/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseDatabase;
#import "NSString+Validations.h"
@import FirebaseAuth;

@interface AddIncomeViewController : UIViewController<UITextFieldDelegate>


@property NSString *userID;
@property (strong, nonatomic) FIRDatabaseReference *dbRef;
@property (weak, nonatomic) IBOutlet UITextField *incomeSrcTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property NSString *incomeSrcText;




@end
