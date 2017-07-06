//
//  AddExpensesViewController.m
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/17/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "AddExpensesViewController.h"

@interface AddExpensesViewController ()
@property BOOL createNo;
@property NSMutableArray *expensesCat;
@property NSString *oldAmnt;
@end

@implementation AddExpensesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _datePicker.hidden = YES;
    [_datePicker setMaximumDate:[NSDate new]];
    _expDate.delegate = self;
    _expAmount.delegate = self;
    
    _expenseCategory.delegate=self;
    _expSubCategory.delegate=self;
    
    //Firebase Database
    self.dbRef = [[FIRDatabase database] reference];
    _userID = [[[FIRAuth auth] currentUser] uid];
    
    
    
    NSDictionary *create = @{@"create":@"true" };
    
 //   [[self.dbRef child:@"expenses"] updateChildValues:create];
    
    
    NSDictionary *addSubExpense = @{@"Shopping":@"0",
                                    @"Gas":@"0",
                                    @"Groceries":@"0",
                                    @"Entertainment":@"0",
                                    @"Other":@"0"
                                    };
    
    NSDictionary *addSubBusExpense = @{@"Travel":@"0",
                                       @"Food":@"0",
                                       @"Hotel":@"0",
                                       @"Other":@"0",
                                       @"Other":@"0"
                                       };
    [[_dbRef child:@"expenses"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * snapshot){
        if([snapshot hasChild:@"create"])
        {
  //          self.createNo =  YES;
        }
    }];
    
 //   if(self.createNo)
  //  {
    [[self.dbRef child:@"expenses"] updateChildValues:create];
        
    [[[[self.dbRef child:@"expenses"] child:_userID ]child:@"Personal"] updateChildValues:addSubExpense];
    
    [[[[self.dbRef child:@"expenses"] child:_userID ]child:@"Business"] updateChildValues:addSubBusExpense];
    
 //   }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addExpensesButtonClicked:(id)sender {
    
    
    if([_expenseCategory.text isEmpty] || [_expSubCategory.text isEmpty] || [_expAmount.text isEmpty] || [_expDate.text isEmpty] )
    {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter valid details!!" message:@"Warning!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
        return;
    }
    
    if(![_expAmount.text isANumber])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter valid number!!" message:@"Warning!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    NSMutableDictionary *perExpDic = [NSMutableDictionary new];
    [[[[_dbRef child:@"expenses"] child:_userID ] queryOrderedByKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * snapshot){
        
        if([snapshot hasChild:@"Personal"])
        {
        FIRDataSnapshot *snapshotPersExp = [snapshot childSnapshotForPath:@"Personal"];
        }
        
        if([snapshot hasChild:@"Business"])
        {
            FIRDataSnapshot *snapshotBusExp = [snapshot childSnapshotForPath:@"Business"];
        }
        
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        
        
        if([_expenseCategory.text isEqualToString:@"Personal"])
        {
            if([snapshot hasChild:@"Personal"])
            {
                FIRDataSnapshot *snapshotPersExp = [snapshot childSnapshotForPath:@"Personal"];
                
                if([snapshotPersExp hasChild:_expSubCategory.text])
                {
               //      NSMutableDictionary *tempDic = [NSMutableDictionary new];
                //   [tempDic setValue:snapshotPersExp.value[_expSubCategory.text] forKey:_expSubCategory.text];
                    
                    NSNumber *old = [f numberFromString:snapshotPersExp.value[_expSubCategory.text]];
                    NSNumber *new = [f numberFromString:_expAmount.text];
                    
                    NSNumber *sum = [NSNumber numberWithFloat:([old floatValue] + [new floatValue])];
                    NSString *newAmnt = [sum stringValue];
                    NSDictionary *addExpense = @{_expSubCategory.text:newAmnt};
                    

                    NSLog(@"Updated Expense in firebase DB for Personal Category");
            //         NSLog(@"Updated Expense in firebase DB for Personal Category %@", tempDic.allValues);
                    
                    [[[[self.dbRef child:@"expenses"] child:_userID] child:@"Personal"]updateChildValues:addExpense];
                    
                }
            }
        }
        else if([_expenseCategory.text isEqualToString:@"Business"])
        {
             if([snapshot hasChild:@"Business"])
            {
                FIRDataSnapshot *snapshotBus = [snapshot childSnapshotForPath:@"Business"];
               
                if([snapshotBus hasChild:_expSubCategory.text])
                {
             //       NSMutableDictionary *tempDic = [NSMutableDictionary new];
              //      [tempDic setValue:snapshotBus.value[_expSubCategory.text] forKey:_expSubCategory.text];
               //     NSLog(@"Updated Expense in firebase DB for Business Category %@", tempDic.allValues);
                    
                    NSNumber *old = [f numberFromString:snapshotBus.value[_expSubCategory.text]];
                    NSNumber *new = [f numberFromString:_expAmount.text];
                    
                    NSNumber *sum = [NSNumber numberWithFloat:([old floatValue] + [new floatValue])];
                    NSString *newAmnt = [sum stringValue];
                    NSDictionary *addExpense = @{_expSubCategory.text:newAmnt};
                    
                    
                       [[[[self.dbRef child:@"expenses"] child:_userID] child:@"Business"]updateChildValues:addExpense];
                }
            }
        }
    }];
    
  
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Expense Added Successfully!!" message:@"Success!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _expDate) {
        return NO;
    }
    return YES;
}

- (IBAction)dobTextFieldTouched:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    //    [dateFormatter setDateFormat:@"MM-dd-yy hh:mm a"];
    _expDate.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datePicker.date]];
    _datePicker.hidden = NO;
    [sender endEditing:YES];
    [sender resignFirstResponder];
    
}

- (IBAction)dismissDatePicker:(id)sender {
    _datePicker.hidden = YES;
    }

- (IBAction)datePickerChanged:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    _expDate.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datePicker.date]];
}


- (IBAction)showActionSheetToDisplayExpenseType:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Expense Types"
                                                                   message:@"Select expense type below"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *personalExpAction = [UIAlertAction actionWithTitle:@"Personal"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                             _expenseCategory.text = @"Personal";
                                                          }];
    UIAlertAction *busExpAction = [UIAlertAction actionWithTitle:@"Business"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               _expenseCategory.text = @"Business";
                                                           }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                              
                                                          }];
    
    [alert addAction:personalExpAction];
    [alert addAction:busExpAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)showActionSheetSubCategoryExpenseType:(id)sender {
    
    if([_expenseCategory.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please select expense type!" message:@"Warning!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Expense Sub Categories"
                                                                   message:@"Select expense type below"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    if([_expenseCategory.text isEqualToString:@"Personal"])
    {
    UIAlertAction *sub1 = [UIAlertAction actionWithTitle:@"Shopping"
                                                                style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                    _expSubCategory.text = @"Shopping";
                                                                }];
    UIAlertAction *sub2 = [UIAlertAction actionWithTitle:@"Gas"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               _expSubCategory.text = @"Gas";
                                                           }];
        UIAlertAction *sub3 = [UIAlertAction actionWithTitle:@"Groceries"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                           _expSubCategory.text = @"Groceries";
                                                       }];
        UIAlertAction *sub4 = [UIAlertAction actionWithTitle:@"Entertainment"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                           _expSubCategory.text = @"Entertainment";
                                                       }];
        UIAlertAction *sub5 = [UIAlertAction actionWithTitle:@"Other"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                           _expSubCategory.text = @"Other";
                                                       }];
    UIAlertAction *sub6 = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                               
                                                           }];
        
        [alert addAction:sub1];
        [alert addAction:sub2];
        [alert addAction:sub3];
        [alert addAction:sub4];
        [alert addAction:sub5];
        [alert addAction:sub6];
       
        
    }
    else if([_expenseCategory.text isEqualToString:@"Business"])
    {
        UIAlertAction *sub1 = [UIAlertAction actionWithTitle:@"Travel"
                                                                    style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                        _expSubCategory.text = @"Travel";
                                                                    }];
        UIAlertAction *sub2 = [UIAlertAction actionWithTitle:@"Food"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                   _expSubCategory.text = @"Food";
                                                               }];
        
        UIAlertAction *sub3 = [UIAlertAction actionWithTitle:@"Hotel"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                           _expSubCategory.text = @"Hotel";
                                                       }];
        UIAlertAction *sub4 = [UIAlertAction actionWithTitle:@"Other"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                           _expSubCategory.text = @"Other";
                                                       }];
   
        
        UIAlertAction *sub5 = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                               }];
                                                                   [alert addAction:sub1];
                                                                   [alert addAction:sub2];
                                                                   [alert addAction:sub3];
                                                                   [alert addAction:sub4];
                                                                   [alert addAction:sub5];
    }
  
                               
    [self presentViewController:alert animated:YES completion:nil];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
