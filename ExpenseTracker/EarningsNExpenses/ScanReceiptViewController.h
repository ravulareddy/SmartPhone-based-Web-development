//
//  ScanReceiptViewController.h
//  EandE
//
//  Created by Sruthi Ravula on 12/15/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TesseractOCR/TesseractOCR.h>
#import "AddExpensesViewController.h"
#import "ViewExpensesController.h"
@import FirebaseDatabase;
@import FirebaseAuth;
@import FirebaseStorage;



@interface ScanReceiptViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>


@property (weak, nonatomic) IBOutlet UITextView *receipttextViewField;
@property UIImagePickerController *imagePicker;
@property UIActionSheet *actionSheet;
@property UIImage *receiptImg;
@property NSMutableDictionary *scannedReceipts;
@property NSString *userID;
@property NSURL *downloadURL;
@property (strong, nonatomic) FIRStorageReference *storageRef;
@property NSNumber *count;
@property FIRDatabaseReference *dbRef;

@end
