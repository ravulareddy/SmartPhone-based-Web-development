//
//  Validations.h
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/14/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validations : NSString (ReadValue)

-(NSString *)readValue;
-(BOOL)isEmpty;
-(BOOL)isZipCode;
-(BOOL)isPhoneNumber;
-(BOOL)isADouble;
-(BOOL)isANumber;
-(BOOL)isValidEmail;
-(BOOL)isCardNumber;

@end
