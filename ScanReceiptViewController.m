//
//  ScanReceiptViewController.m
//  EandE
//
//  Created by Sruthi Ravula on 12/15/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "ScanReceiptViewController.h"

@interface ScanReceiptViewController ()

@end

@implementation ScanReceiptViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FIRStorage *storage = [FIRStorage storage];
    _storageRef = [storage referenceForURL:@"gs://earningsnexpenses-ded3d.appspot.com"];
    
    // Firebase Db reference
    self.dbRef = [[FIRDatabase database] reference];
      _userID = [[[FIRAuth auth] currentUser] uid];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// share expenses scanned using ocr via mail, contacts etc .

- (IBAction)shareYourExpenses:(id)sender {
    
    if([_receipttextViewField.text isEqualToString: @""] || [_receipttextViewField.text isEqualToString:nil])  {
      //  return;
    }
 // Activity view controller to show options to share
    
    NSURL *url = [NSURL URLWithString:@"mailto:sruthi.ravula@gmail.com"];
    NSMutableArray *shareExpenseText = [NSMutableArray new];
    [shareExpenseText addObject:url];
    [shareExpenseText addObject:_receipttextViewField.text];
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc]initWithActivityItems:shareExpenseText
                                     applicationActivities:nil];
    NSArray *excludeActivities = @[
                                   UIActivityTypeAirDrop,
                             UIActivityTypeAssignToContact,
                             UIActivityTypeSaveToCameraRoll,
                             UIActivityTypeAddToReadingList,
                             UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
  
  //  [activityViewController setValue:mailSubject forKey:@"Subject"];
    activityViewController.excludedActivityTypes = excludeActivities;
  
    [self.navigationController presentViewController:activityViewController animated: true
                      completion: nil];
}



// Menu to show the action sheet to ytyake photo or choose photo from library
-(IBAction)showActionSheetMenu:(id)sender
{
    
    UIAlertController *view = [UIAlertController alertControllerWithTitle:@"Snap/Upload Photo" message: @"Select your choice" preferredStyle:UIAlertControllerStyleActionSheet];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertAction *takePhotAction = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self takePhoto];
         //
           // _imagePicker.delegate =self;
           // _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
           // [self presentViewController:_imagePicker animated:YES completion:nil];
        //    [view dismissViewControllerAnimated:YES completion:nil];
        }];
        [view addAction:takePhotAction];
        
    }
                                         
        UIAlertAction *choosePhotoAction = [UIAlertAction actionWithTitle:@"Choose Existing from Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //
         //   _imagePicker.delegate =self;
           // _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
           // [self presentViewController:_imagePicker animated:YES completion:nil];
             //    [view dismissViewControllerAnimated:YES completion:nil];
            [self chooseExistingPhotoFromLibrary];
            
             }];
                                         
        [view addAction:choosePhotoAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
     
        
    }];
    
    [view addAction:cancelAction];
    
    [self presentViewController:view animated:YES completion:nil];
}

-(UIImage *) scaleImage:(UIImage *)image :(CGFloat)maxDimension
{
    
  //  CGSizeMake(maxDimension, maxDimension);
    
//    CGSize(maxDimension, maxDimension);
    CGSize scaledSize = CGSizeMake(maxDimension, maxDimension);
    CGFloat scaleFactor;
    
    if (image.size.width > image.size.height) {
        scaleFactor = (image.size.height / image.size.width);
        scaledSize.width = maxDimension;
        scaledSize.height = scaledSize.width * scaleFactor;
    } else {
        scaleFactor = image.size.width / image.size.height;
        scaledSize.height = maxDimension;
        scaledSize.width = scaledSize.height * scaleFactor;
    }
    
    UIGraphicsBeginImageContext(scaledSize);
    [image drawInRect:CGRectMake(0, 0, scaledSize.width, scaledSize.height )];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


- (void)takePhoto {
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    
    [self presentViewController:_imagePicker animated:YES completion:nil];
    
}

-(void)chooseExistingPhotoFromLibrary
{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    _receiptImg = info[UIImagePickerControllerOriginalImage];
    
  //  _receiptImg = [[UIImage imageNamed:@"/Users/tejageetla/Downloads/GroceryReceipt.png"]g8_blackAndWhite];
  //  NSLog(@"image::: ", _receiptImg.size);
    UIImage *scaledImage = [self scaleImage:_receiptImg :640];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        // Process image using OCR
        
        G8Tesseract *tesseract = [[G8Tesseract alloc]initWithLanguage:@"eng"];
        tesseract.engineMode = G8OCREngineModeTesseractCubeCombined;
     // tesseract.engineMode = G8OCREngineModeTesseractOnly;
        tesseract.delegate = self;
    //  [tesseract setCharWhitelist:@"0123456789"];
        tesseract.pageSegmentationMode = G8PageSegmentationModeAuto;
        tesseract.maximumRecognitionTime = 60.0;
        tesseract.image = [scaledImage g8_blackAndWhite];
        [tesseract recognize];
        NSLog(@"Scanned Text :::: %@", tesseract.recognizedText);
        
   //     NSArray *characterBox = tesseract.characterBoxes;
     //   NSArray *characterChoice = tesseract.characterChoices;
    //    UIImage *imagewithBlocks = [tesseract imageWithBlocks:characterBox drawText:YES thresholded:NO];
        
        _receipttextViewField.text  = [tesseract recognizedText];
        _receipttextViewField.editable = NO;
        _receipttextViewField.autoresizingMask= UIViewAutoresizingFlexibleHeight;
    /*
        NSString *recepit = [NSString stringWithFormat:@"%@ \n %@", _receipttextViewField.text];
        NSArray *listOfWords = [recepit componentsSeparatedByString:@" "];
        for (NSString *word in listOfWords) {
            if ([[word substringWithRange:NSMakeRange(0, 1)]isEqualToString:@"$"]) {
                NSString *total = [[word componentsSeparatedByString:@"$"]lastObject];
                NSLog(@"Total :::smart scan :::::", total);
            }
        }
     */
    }];
    
    NSData *uploadData;
    if(_receipttextViewField.text){
        uploadData = UIImageJPEGRepresentation(_receiptImg, 0.9f);
    }else{
        uploadData = UIImagePNGRepresentation([UIImage imageNamed:_userID]);
    }
    
    FIRStorageReference *scannedRec = [_storageRef child:[[@"receipts/" stringByAppendingString:_userID] stringByAppendingString:@".png"]];
    
    // Upload the file to the path
    [scannedRec deleteWithCompletion:^(NSError *error){
        
        FIRStorageUploadTask *uploadTask = [scannedRec putData:uploadData metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                self.downloadURL = metadata.downloadURL;
                [_scannedReceipts setValue:_downloadURL.absoluteString forKey:@"scannedReceipts"];
            }
        }];
        
    }];

    

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"addSmartExpense"])
    {
        AddExpensesViewController *addExp =(AddExpensesViewController *)segue.destinationViewController;
    
 
    }
}


@end
