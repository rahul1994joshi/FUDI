//
//  LoginViewController.m
//  Restourant
//
//  Created by RAHUL on 9/3/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "LoginViewController.h"
#import "Database.h"
#import "HomeViewController.h"
#import "DEMORootViewController.h"
#import "SignUpViewController.h"
#import "DataClass.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    _tap.enabled = NO;
    [self.view addGestureRecognizer:_tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    for (int i=1; i<3; i++) {
        
        UITextField *textField = (UITextField *)[self.view viewWithTag:i];
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, textField.frame.size.height - 1, textField.frame.size.width,1.0f);
        bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
        [textField.layer addSublayer:bottomBorder];
    }
    
    
   /*self.txtEmail.leftViewMode=UITextFieldViewModeAlways;
     self.txtEmail.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mail.png"]];
    self.txtEmail.leftView.frame=CGRectMake(self.txtEmail.frame.origin.x, self.txtEmail.frame.origin.y, 20 , 20);*/
    
   
    self.txtEmail.leftViewMode=UITextFieldViewModeAlways;
    self.txtEmail.leftView =[[UIView alloc]initWithFrame:CGRectMake(0  ,0, 40, 40)];
    UIImageView *img1 =[[UIImageView alloc]initWithFrame:CGRectMake(10,10,20,20)];
    img1.image =[UIImage imageNamed:@"mail.png"];
    [self.txtEmail.leftView addSubview:img1];
        
        

    
    
   /* self.txtPassword.leftViewMode=UITextFieldViewModeAlways;
    self.txtPassword.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lock.png"]];
    self.txtPassword.leftView.frame=CGRectMake(self.txtPassword.frame.origin.x, self.txtPassword.frame.origin.y, 20 , 20);*/
    
    self.txtPassword.leftViewMode=UITextFieldViewModeAlways;
    self.txtPassword.leftView =[[UIView alloc]initWithFrame:CGRectMake(0  ,0, 40, 40)];
    UIImageView *img2 =[[UIImageView alloc]initWithFrame:CGRectMake(10,10,20,20)];
    img2.image =[UIImage imageNamed:@"lock.png"];
    [self.txtPassword.leftView addSubview:img2];
    
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    //  CGFloat screenHeight = screenRect.size.height;
    
    
    CGRect scrollFrame;
    scrollFrame.origin=self.scrollView.frame.origin;
    scrollFrame.size=CGSizeMake(screenWidth,(CGFloat)1000);
}

#pragma mark- validation

- (NSString *)validateForm {
    NSString *errorMessage;
    
    NSString *regex = @"[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
    
    
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
   
  if (![emailPredicate evaluateWithObject:self.txtEmail.text]){
        errorMessage = @"Please enter a valid email address";
    } else if (!(self.txtPassword.text.length >= 1)){
        errorMessage = @"Please enter a valid password";
    }
   
    
    return errorMessage;
}


- (IBAction)btnLoginClick:(id)sender {
    
    NSLog(@"%@",[[Database getInstance]Select:@"UserInfo"]);
    
    
    // next step is to implement validateForm
    NSString *errorMessage = [self validateForm];
    
    if (errorMessage) {
        [[[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        return;
    }
    
    if (![[Database getInstance]validateUser:self.txtEmail.text]) {
        return;
    }
    
      int result=  [[Database getInstance]validateUser:self.txtEmail.text Password:self.txtPassword.text];
        
        if(result==1)
        {
            
            DataClass *usrProfile=[DataClass getInstance];
            usrProfile.userEmail=self.txtEmail.text;
            usrProfile.userPassword=self.txtPassword.text;
      
            
            DEMORootViewController *VC=(DEMORootViewController *)[self.storyboard   instantiateViewControllerWithIdentifier:@"rootController"];
            
//            UINavigationController *nav =             [[UINavigationController alloc]initWithRootViewController:VC];
//            nav.navigationBarHidden = YES;
//            [self.window setRootViewController:nav];
            
            
            
            [self.navigationController pushViewController:VC animated:YES];
        }
        else{
         [[[UIAlertView alloc]initWithTitle:@"Login" message:@"failed to login" delegate:self
                                                cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];

        }
        

        return;
        
        
        
        
    }

- (IBAction)btnRegisterClick:(id)sender {
    
    [self.view endEditing:YES];
  //  [self.frostedViewController.view endEditing:YES];

    
    SignUpViewController *controller =(SignUpViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
    
    // Send the form values to the server here.
#pragma mark -hide and show keypad  

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _tap.enabled = YES;
    return YES;
}

-(void)hideKeyboard
{
    [self.txtEmail resignFirstResponder];
    _tap.enabled = NO;
}

@end
