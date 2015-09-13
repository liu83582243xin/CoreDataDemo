//
//  LXYBooksAddViewController.m
//  CoreDataDemo
//
//  Created by lxyzk on 15/9/13.
//  Copyright (c) 2015年 lxyzk. All rights reserved.
//

#import "LXYBooksAddViewController.h"
#import "AppDelegate.h"
#import "LXYAuthor.h"
#include "LXYBook.h"

@interface LXYBooksAddViewController () <UITextFieldDelegate>

@property (weak, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;

- (IBAction)finishEdit:(id)sender;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end

@implementation LXYBooksAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.nameTextField.delegate = self;
    self.priceTextField.delegate = self;
}

- (void)addBookForAuthor:(LXYAuthor *)author
{
    LXYBook *book = [NSEntityDescription insertNewObjectForEntityForName:@"LXYBook" inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    book.name = self.nameTextField.text;
    double price = [self.priceTextField.text doubleValue];
    book.price = [NSNumber numberWithDouble:price];
    book.author = self.author;
    
    NSLog(@"In books add ,author name:%@",book.author);
    
    NSError *error = nil;
    if(![self.appDelegate.managedObjectContext save:&error])
    {
        NSLog(@"Error when add book for author:%@,%@",error,[error userInfo]);
    }
    else
    {
        NSLog(@"Add book successed");
    }
}

- (IBAction)finishEdit:(id)sender
{
    [self addBookForAuthor:self.author];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
