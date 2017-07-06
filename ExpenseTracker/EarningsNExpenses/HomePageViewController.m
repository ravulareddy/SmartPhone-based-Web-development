//
//  HomePageViewController.m
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/11/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.startButtonImage.layer.cornerRadius = self.startButtonImage.frame.size.width / 2;
    self.startButtonImage.clipsToBounds = YES;
    
    self.startButtonImage.layer.borderWidth = 3.0f;
    self.startButtonImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.navigationController.navigationBarHidden = YES;
      self.navigationController.navigationItem.backBarButtonItem.enabled = FALSE;
     [self.navigationItem setHidesBackButton:TRUE animated:YES];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signOutButtonClicked:(id)sender {
    
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
    else{
     NSLog(@"signing out ::: ");
    }

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
