//
//  UpadateProfileViewController.m
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/12/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "UpadateProfileViewController.h"

@interface UpadateProfileViewController ()

@property (strong, nonatomic) FIRStorageReference *storageRef;

@end

@implementation UpadateProfileViewController

@synthesize userID;
@synthesize updatedProfilePic;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Firebase Db reference
    self.dbRef = [[FIRDatabase database] reference];
    // Firebase storage
    FIRStorage *storage = [FIRStorage storage];
    _storageRef = [storage referenceForURL:@"gs://earningsnexpenses-ded3d.appspot.com"];
    
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    
    self.profileImageView.layer.borderWidth = 3.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _firstNameTxtField.delegate = self;
    _lastNameTxtField.delegate = self;
    _phoneNumberTxtField.delegate = self;
    _updateProfile = [NSMutableDictionary new];
    
    userID = [[[FIRAuth auth] currentUser] uid];
   
    _emailTextField.allowsEditingTextAttributes=false;
    
    [self populateFields];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) populateFields{
    
    //Retrieve Profile Data for User
  //  NSString *userID = [[[FIRAuth auth] currentUser] uid];
    [[[_dbRef child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * snapshot){
        
        _emailTextField.text = snapshot.value[@"emailId"];
        
    
        if([snapshot hasChild:@"firstName"]){
            _firstNameTxtField.text = snapshot.value[@"firstName"];
        }
        if([snapshot hasChild:@"lastName"]){
            _lastNameTxtField.text = snapshot.value[@"lastName"];
        }
        
        if([snapshot hasChild:@"phoneNumber"]){
            _phoneNumberTxtField.text = snapshot.value[@"phoneNumber"];
        }
        if([snapshot hasChild:@"profilePic"])
        {
            
            FIRStorageReference *profilePicRef = [_storageRef child:[[@"profilepics/" stringByAppendingString:userID] stringByAppendingString:@".jpg"]];
            
            
            [profilePicRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData *data, NSError *error){
                if (error != nil) {
                    // Uh-oh, an error occurred!
                } else {
                    // Data for "images/island.jpg" is returned
                    // ... UIImage *islandImage = [UIImage imageWithData:data];
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        //Load Image
                        _profileImageView.image = [UIImage imageWithData:data];
                        _profileImageView.hidden = NO;
                    });
                }
            }];
        }
        
        [self loadProfile:snapshot];
    }];
    
}

-(void)loadProfile:(FIRDataSnapshot * )snapshot{
    if(snapshot){
        if([snapshot hasChild:@"emailId"]){
            [_updateProfile setValue:snapshot.value[@"emailId"] forKey:@"emailId"];
        }
       
        if([snapshot hasChild:@"firstName"]){
            [_updateProfile setValue:snapshot.value[@"firstName"] forKey:@"firstName"];
        }
        if([snapshot hasChild:@"lastName"]){
            [_updateProfile setValue:snapshot.value[@"lastName"] forKey:@"lastName"];
        }
        
        if([snapshot hasChild:@"phoneNumber"]){
            [_updateProfile setValue:snapshot.value[@"phoneNumber"] forKey:@"phoneNumber"];
        }
        
        if([snapshot hasChild:@"profilePic"]){
            [_updateProfile setValue:snapshot.value[@"profilePic"] forKey:@"profilePic"];
        }
        
        
        
        
    }
}



- (IBAction)chooseProfilePic{
    
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    [self.imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:_imagePicker animated:YES completion:Nil];
    
    NSData *uploadData;
    if(_profileImageView){
        uploadData = UIImageJPEGRepresentation(_profileImageView.image, 0.9f);
    }else{
        uploadData = UIImagePNGRepresentation([UIImage imageNamed:userID]);
    }
    
    FIRStorageReference *profilepicref = [_storageRef child:[[@"profilepics/" stringByAppendingString:userID] stringByAppendingString:@".jpg"]];
    
    // Upload the file to the path
    [profilepicref deleteWithCompletion:^(NSError *error){
        
        FIRStorageUploadTask *uploadTask = [profilepicref putData:uploadData metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                self.downloadURL = metadata.downloadURL;
                [_updateProfile setValue:_downloadURL.absoluteString forKey:@"profilePic"];
            }
        }];

      }];
    
   // [self.imagePicker release];
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    _profilePic = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.profileImageView setImage:_profilePic];
    updatedProfilePic = YES;
    
       [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (IBAction)saveProfileButtonClicked:(id)sender {
    
    if([_firstNameTxtField.text isEmpty] || [_lastNameTxtField.text isEmpty] || [_phoneNumberTxtField.text isEmpty]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter values in all fields!" message:@"Warning!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    else if(![_phoneNumberTxtField.text isPhoneNumber])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter valid Phone Number!" message:@"Warning!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Profile Updated Successfully!" message:@"Success!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    
    [_updateProfile setValue:_emailTextField.text forKey:@"emailId"];
    [_updateProfile setValue:_firstNameTxtField.text forKey:@"firstName"];
    [_updateProfile setValue:_lastNameTxtField.text forKey:@"lastName"];
    [_updateProfile setValue:_phoneNumberTxtField.text forKey:@"phoneNumber"];
    if(updatedProfilePic)
        {
        [_updateProfile setValue:userID forKey:@"profilePic"];
        }
    
    [[[_dbRef child:@"users"] child:[[FIRAuth auth] currentUser].uid]updateChildValues:_updateProfile];
    [self populateFields];
    
    NSLog(@"Successfully update account profile for the user  :::::: ");
  //  [self performSegueWithIdentifier:@"unwindToSignIn" sender:self];

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signOutButtonClicked:(id)sender {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }else{
        [self didTapSignOut:sender];
        [self performSegueWithIdentifier:@"logout" sender:self];
    }
    
}

- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
    [[GIDSignIn sharedInstance] disconnect];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    //[self keyboardWillHide];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
