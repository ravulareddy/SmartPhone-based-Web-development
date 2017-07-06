//
//  AddIncomeViewController.m
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/15/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "AddIncomeViewController.h"

@interface AddIncomeViewController ()

@property NSString *oldAmnt;
@property NSMutableArray *earnings;

@end

@implementation AddIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _datePicker.hidden = YES;
     [_datePicker setMaximumDate:[NSDate new]];
    _dateTextField.delegate = self;
    if([_incomeSrcText isEmpty])
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not retreive income source! Please try again!!" message:@"Warning!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    _incomeSrcTextField.text = _incomeSrcText;
    
    //Firebase Database
    self.dbRef = [[FIRDatabase database] reference];
     _userID = [[[FIRAuth auth] currentUser] uid];
    
    [[[[_dbRef child:@"categories"] child:_userID] child:@"earnings"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * snapshot){
        
        if([snapshot hasChild:_incomeSrcText])
        {
             NSLog(@"Entering observe Single event type");
            _amountTextField.text = snapshot.value[_incomeSrcText];
        }
        
        
    /*    NSMutableDictionary *catgry1 = [NSMutableDictionary new];
        
        [catgry1 setValue:snapshot.key forKey:_userID];
        FIRDataSnapshot *snapshot1 = [snapshot childSnapshotForPath:@"earnings"];
        NSLog(@"snapshot 1" );
        
        NSLog(@"Entering observe Single event type");
        
        if([snapshot1 hasChild:_incomeSrcText])
        {
            _amountTextField.text = snapshot1.value;
        }
        
        [self.earnings addObject:catgry1];
       
        NSDictionary *title = [NSDictionary new];
        
            for(NSDictionary *dic in _earnings)
            {
                NSLog(@"title :::::::: %@", dic.allKeys);
                NSLog(@"values ::: %@",[dic valueForKey:_incomeSrcText] );
                
                _amountTextField.text  = (NSString *)[dic valueForKey:_incomeSrcText];
                
            }
        
     /*       self.temp = [NSMutableArray new];
            
            for(NSString *key in title)
            {
                NSLog(@"KEyy inside cell::::::::%@", key);
                [self.temp addObject:key];
            }
            for(NSString *val in self.temp)
            {
                NSLog(@"val >> %@", val);
                //   cell.textLabel.text = val;
            }
      */
        
     //   [_amountTextField.text setValue:snapshot1.value forKey:_incomeSrcText];
       
    }];

    
}

- (IBAction)datePickerChanged:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    _dateTextField.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datePicker.date]];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _dateTextField) {
        return NO;
    }
    return YES;
}



- (IBAction)dismissDatePicker:(id)sender {
    _datePicker.hidden = YES;
   
}
- (IBAction)dateTxtFieldTouched:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    //    [dateFormatter setDateFormat:@"MM-dd-yy hh:mm a"];
    _dateTextField.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: _datePicker.date]];
    _datePicker.hidden = NO;
    [sender endEditing:YES];
    [sender resignFirstResponder];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addIncomeActionButtonClicked:(id)sender {
    
    if([_amountTextField.text isEmpty] || [_dateTextField.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not retreive income source! Please try again!!" message:@"Warning!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if(![_amountTextField.text isANumber])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter valid number!! " message:@"Warning!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }

    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSNumber *old = [f numberFromString:_oldAmnt];
    NSNumber *new = [f numberFromString:_amountTextField.text];
    
    NSNumber *sum = [NSNumber numberWithFloat:([old floatValue] + [new floatValue])];
    NSString *newAmnt = [sum stringValue];
    NSDictionary *addIncome = @{_incomeSrcText:newAmnt};
    
    [[[[self.dbRef child:@"categories"] child:_userID] child:@"earnings"]updateChildValues:addIncome];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Income Added Successfully!!" message:@"Success!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

    
}
- (IBAction)cancelActionButtonClicked:(id)sender {
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
