//
//  ViewExpensesController.h
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/17/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseDatabase;
@import FirebaseAuth;

@interface ViewExpensesController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *perExpTotal;
@property (weak, nonatomic) IBOutlet UITextField *busExpTotal;

@property NSString *userID;
@property (strong, nonatomic) FIRDatabaseReference *dbRef;

@end
