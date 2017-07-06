//
//  UpadateProfileViewController.h
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/12/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (Validations)

-(BOOL)isEmpty;
-(NSString *)readValueAndValidate;

-(BOOL)isZipCode;
-(BOOL)isANumber;
-(BOOL)isPhoneNumber;
-(BOOL)isValidEmail;

@end
