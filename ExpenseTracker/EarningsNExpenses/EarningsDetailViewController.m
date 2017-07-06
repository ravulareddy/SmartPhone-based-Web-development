//
//  EarningsDetailViewController.m
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/15/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "EarningsDetailViewController.h"

@interface EarningsDetailViewController ()


@end

@implementation EarningsDetailViewController

@synthesize update;
@synthesize category;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
        NSLog(@"selected category in detailed vewi :: %@ ", category);
   //     _incomeSourceTxtField.text = category;
    
 //   [[[[_dbRef child:@"categories"] child:_userID]child:@"earnings"]
  //   observeSingleEventOfType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * snapshot){
    
        //    _totalamount.text = @"0";
    
        
    
    
        [[[[_dbRef child:@"categories"] child:_userID]child:@"earnings"] observeSingleEventOfType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * snapshot){
            
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *salry;
            NSNumber *business;
            NSNumber *property;
            NSNumber *others;
               NSNumber *test;
            NSNumber *myNumber = [formatter numberFromString:_totalamount.text];
            
            
            if([snapshot hasChild:@"SalaryIncome"])
            {
                
             _salaryIncome.text = snapshot.value[@"SalaryIncome"];
                salry = [formatter numberFromString:_salaryIncome.text];
            }
            if([snapshot hasChild:@"BusinessIncome"])
            {
                _businessIncome.text = snapshot.value[@"BusinessIncome"];
                business = [formatter numberFromString:_businessIncome.text];
            }
            if([snapshot hasChild:@"PropertyIncome"])
            {
                _propertyIncome.text = snapshot.value[@"PropertyIncome"];
                property = [formatter numberFromString:_propertyIncome.text];
            }
            if([snapshot hasChild:@"Others"])
            {
                _otherIncome.text = snapshot.value[@"Others"];
                others = [formatter numberFromString:_otherIncome.text];
            }
            
            if([snapshot hasChild:@"test"])
            {
                _otherIncome.text = snapshot.value[@"test"];
                test = [formatter numberFromString:_otherIncome.text];
            }
            
            NSNumber *sum = [NSNumber numberWithFloat:([salry floatValue] + [business floatValue] + [property floatValue] + [others floatValue] + [test floatValue])];
            NSLog(@"sum of earnings is :::: %@", sum);
            
           _totalamount.text = [sum stringValue];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addEarningsButtonClicked:(id)sender {
    
    
}

- (IBAction)CancelButtonClicked:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
