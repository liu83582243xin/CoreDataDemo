//
//  LXYAuthorAddViewController.m
//  CoreDataDemo
//
//  Created by lxyzk on 15/9/13.
//  Copyright (c) 2015年 lxyzk. All rights reserved.
//

#import "LXYAuthorAddViewController.h"
#import "LXYAuthor.h"
#import "AppDelegate.h"

@interface LXYAuthorAddViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *descTextField;
@property (weak, nonatomic) AppDelegate *appDelegate;

- (IBAction)finishedEdit:(id)sender;

- (BOOL) textFieldShouldReturn:(UITextField *)textField;

@end

@implementation LXYAuthorAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextField.delegate = self;
    self.descTextField.delegate = self;
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)addAuthor
{
    NSString *name = self.nameTextField.text;
    NSString *authorDesc = self.descTextField.text;
    
    LXYAuthor *author = [NSEntityDescription insertNewObjectForEntityForName:@"LXYAuthor" inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    author.name = name;
    author.authorDesc = authorDesc;
    
    NSError *error = nil;
    if([self.appDelegate.managedObjectContext save:&error])
    {
        NSLog(@"Error when add author:%@,%@",error,[error userInfo]);
    }
        
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)finishedEdit:(id)sender
{
    [self addAuthor];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
