//
//  DetailViewController.m
//  Restourant
//
//  Created by RAHUL on 9/3/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "DetailViewController.h"
#import "MapViewController.h"


@interface DetailViewController ()

@end
@implementation DetailViewController

@synthesize dictName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  

  
    
   // textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //textLabel.numberOfLines = 2;
    
    self.lblAdress.lineBreakMode=NSLineBreakByWordWrapping;
    self.lblAdress.numberOfLines=0;
    self.lblAdress.preferredMaxLayoutWidth=[UIScreen mainScreen].bounds.size.width-40;
    
    NSLog(@"%@",_lblname);
    NSLog(@"%@",_lbladress);
    
    
    self.lblAdress.text=_lbladress;
    self.lblName.text=_lblname;
    self.lblCheckinsCount.text=_lblcheckinsCount;
    
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
//    [super viewDidAppear:YES];
//    self.frostedViewController.panGestureEnabled = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)backButtonClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)btnMapClick:(id)sender {
    
    MapViewController *controller=( MapViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
    controller.arr=[[NSArray alloc]initWithObjects:self.vanue, nil];
    NSLog(@"%@",controller.arr);
    [self.navigationController pushViewController:controller animated:YES];

}


@end
