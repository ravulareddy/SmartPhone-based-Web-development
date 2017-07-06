//
//  UpadateProfileViewController.h
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/12/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//


#import "NSString+Validations.h"

@implementation NSString (Validations)

-(NSString *)readValueAndValidate{
    char value[100] = {0};
    while(true){
        scanf("%s",value);
        if([[[NSString stringWithUTF8String:value] stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]){
            NSLog(@"Input cannot be empty");
        }else{
            break;
        }
    }
    return [NSString stringWithUTF8String:value];
}

-(BOOL)isEmpty{
    NSString *temp1 = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return !([temp1 length] != 0);
}




-(BOOL)isValidEmail
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}




-(BOOL)isANumber{
    NSString *postcodeRegex = @"^\\d+$";
    NSPredicate *postcodeValidate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",postcodeRegex];
    
    if ([postcodeValidate evaluateWithObject:self] == YES) {
        return YES;
    } else {
        return NO;
    }
}




-(BOOL)isPhoneNumber{
    NSString *postcodeRegex = @"^[1-9]{1}[0-9]{2}[0-9]{3}[0-9]{4}$";
    NSPredicate *postcodeValidate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",postcodeRegex];
    
    if ([postcodeValidate evaluateWithObject:self] == YES) {
        return YES;
    } else {
        return NO;
    }
}




@end
