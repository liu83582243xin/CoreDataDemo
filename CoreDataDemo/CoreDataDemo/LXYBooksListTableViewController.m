//
//  LXYBooksListTableViewController.m
//  CoreDataDemo
//
//  Created by lxyzk on 15/9/13.
//  Copyright (c) 2015年 lxyzk. All rights reserved.
//

#import "LXYBooksListTableViewController.h"
#import "LXYBooksAddViewController.h"
#import "AppDelegate.h"
#import "LXYAuthor.h"
#import "LXYBook.h"

@interface LXYBooksListTableViewController ()

@property (weak, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSMutableArray *books;


@end

@implementation LXYBooksListTableViewController

#pragma  mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.books = [self fetchBooksForAuthor:self.author];
    
    [self.tableView reloadData];
}

#pragma mark - Core Data

- (NSMutableArray *)fetchBooksForAuthor:(LXYAuthor *)author
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LXYBook" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [request setEntity:entity];
    request.predicate = [NSPredicate predicateWithFormat:@"author=%@",author];
    
    NSError *error = nil;
    NSMutableArray *books = [[self.appDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if(books == nil)
    {
        NSLog(@"Error when fetch books for author:%@,%@",error,[error userInfo]);
    }
    
    return books;
}

- (void)removeBookFromDataSource:(LXYBook *)book
{
    NSError *error = nil;
    [self.appDelegate.managedObjectContext deleteObject:book];
    
    if(![self.appDelegate.managedObjectContext save:&error])
    {
        NSLog(@"Error when remove book from data source:%@,%@",error,[error userInfo]);
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXYBookTableViewCell" forIndexPath:indexPath];
    
    LXYBook *book = self.books[indexPath.row];
    cell.textLabel.text = book.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXYBook *book = self.books[indexPath.row];
    
    [self.books removeObject:book];
    [self removeBookFromDataSource:book];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    NSString *identifer = segue.identifier;
    
    if([identifer isEqualToString:@"toBooksAddViewControllerSegue"])
    {
        UINavigationController *navc = (UINavigationController *)segue.destinationViewController;
        LXYBooksAddViewController *bavc = (LXYBooksAddViewController *)navc.topViewController;
        
        bavc.author = self.author;
        
        return;
    }
    
}

@end
