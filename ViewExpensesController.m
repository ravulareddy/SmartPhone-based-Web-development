//
//  ViewExpensesController.m
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/17/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "ViewExpensesController.h"

@interface ViewExpensesController ()
@property NSNumber *sub1;
@property NSNumber *sub2;
@property NSNumber *sub3;
@property NSNumber *sub4;
@property NSNumber *sub5;
@property NSString *update;
@end

@implementation ViewExpensesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //Firebase Database
    self.dbRef = [[FIRDatabase database] reference];
    _userID = [[[FIRAuth auth] currentUser] uid];
    
    
    _perExpTotal.allowsEditingTextAttributes = FALSE;
    _busExpTotal.allowsEditingTextAttributes= FALSE;
    
    _perExpTotal.delegate =self;
    _busExpTotal.delegate = self;
    
   
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *test;
    
    [[[_dbRef child:@"expenses"] child:_userID] observeSingleEventOfType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * snapshot){
        
      
        NSMutableDictionary *perExpDictionary = [NSMutableDictionary new];
        NSMutableDictionary *busExpDic = [NSMutableDictionary new];
        
         [perExpDictionary setValue:snapshot.value forKey:@"Personal"];
        
         [busExpDic setValue:snapshot.value forKey:@"Business"];
        
        NSLog(@"Personal Exp Total :: %@", perExpDictionary.allValues);
   
        
        if([snapshot hasChild:@"Entertainment"])
         {
         NSString *test  = snapshot.value[@"Entertainment"];
         _sub1 = [formatter numberFromString:test];
         
         }
         if([snapshot hasChild:@"Gas"])
         {
         NSString *test = snapshot.value[@"Gas"];
         _sub2 = [formatter numberFromString:test];
         }
         if([snapshot hasChild:@"Groceries"])
         {
         NSString *test = snapshot.value[@"Groceries"];
         _sub3 = [formatter numberFromString:test];
         }
         if([snapshot hasChild:@"Other"])
         {
         NSString *test = snapshot.value[@"Other"];
         _sub4 = [formatter numberFromString:test];
         }
         if([snapshot hasChild:@"Shopping"])
         {
             NSString *test = snapshot.value[@"Shopping"];
             _sub5 = [formatter numberFromString:test];
         }
     //    _update = @"P";
          
         NSNumber *sum = [NSNumber numberWithFloat:([_sub1 floatValue] + [_sub2 floatValue] + [_sub3 floatValue] + [_sub4 floatValue] + [_sub5 floatValue])];
        NSLog(@"PErsonal expense sum %@", sum);
          _perExpTotal.text = [sum stringValue];
          
      

          if([snapshot hasChild:@"Travel"])
          {
              NSString *test  = snapshot.value[@"Travel"];
              _sub1 = [formatter numberFromString:test];
              
          }
          if([snapshot hasChild:@"Food"])
          {
              NSString *test = snapshot.value[@"Food"];
              _sub2 = [formatter numberFromString:test];
          }
          if([snapshot hasChild:@"Hotel"])
          {
              NSString *test = snapshot.value[@"Hotel"];
              _sub3 = [formatter numberFromString:test];
          }
          if([snapshot hasChild:@"Other"])
          {
              NSString *test = snapshot.value[@"Other"];
              _sub4 = [formatter numberFromString:test];
          }
          
          NSNumber *sum1 = [NSNumber numberWithFloat:([_sub1 floatValue] + [_sub2 floatValue] + [_sub3 floatValue] + [_sub4 floatValue] + [_sub5 floatValue])];
          NSLog(@"sum of earnings is :::: %@", sum1);
          
          _busExpTotal.text = [sum1 stringValue];
          
      //     _update = @"B";
          
     //   NSLog(@"business Exp Total :: %@", busExpDic.allValues);
      
       
         }];
    
    
    
    NSNumber *sum = [NSNumber numberWithFloat:([_sub1 floatValue] + [_sub2 floatValue] + [_sub3 floatValue] + [_sub4 floatValue] + [_sub5 floatValue])];
    NSLog(@"sum of earnings is :::: %@", sum);
   
   /* if([_update isEqualToString:@"P"])
    {
    _perExpTotal.text = [sum stringValue];
    }
    else if([_update isEqualToString:@"B"])
    {
        _busExpTotal.text = [sum stringValue];
    }
    */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
