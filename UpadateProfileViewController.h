//
//  UpadateProfileViewController.h
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/12/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Validations.h"
@import Firebase;
@import FirebaseStorage;
@import FirebaseDatabase;
@import FirebaseAuth;


@interface UpadateProfileViewController : ViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (nonatomic, retain)UIImagePickerController *imagePicker;
@property UIImage *profilePic;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTxtField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property BOOL *updatedProfilePic;
@property NSString *userID;
@property NSURL *downloadURL;
@property NSMutableDictionary *updateProfile;
@property FIRDatabaseReference *dbRef;

@end
