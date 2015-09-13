//
//  LXYAuthorLIstTableViewController.m
//  CoreDataDemo
//
//  Created by lxyzk on 15/9/13.
//  Copyright (c) 2015年 lxyzk. All rights reserved.
//

#import "LXYAuthorLIstTableViewController.h"
#import "AppDelegate.h"
#import "LXYAuthor.h"
#import "LXYBooksListTableViewController.h"


@interface LXYAuthorLIstTableViewController ()

@property (nonatomic, weak) AppDelegate *appDelegate;
@property (nonatomic, strong) NSMutableArray *authors;

@end

@implementation LXYAuthorLIstTableViewController

#pragma mark - View

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.authors = [self fetchAuthorsFromDataSource];
    
    [self.tableView reloadData];
}

#pragma mark - Core Data

- (NSMutableArray *)fetchAuthorsFromDataSource
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LXYAuthor" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSMutableArray *authors = [[self.appDelegate.managedObjectContext
                     executeFetchRequest:request error:&error] mutableCopy];
    
    if(authors == nil)
    {
        NSLog(@"Error when fetch authors from data source:%@,%@",error,[error userInfo]);
    }
    
    return authors;
}

- (void)removeAuthorFromDataSource:(LXYAuthor *)author
{
    [self.appDelegate.managedObjectContext deleteObject:author];
    
    NSError *error = nil;
    if(![self.appDelegate.managedObjectContext save:&error])
    {
        NSLog(@"Error when remove author form data source:%@,%@",error,[error userInfo]);
    }
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.authors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXYAuthorTableViewCell" forIndexPath:indexPath];
    LXYAuthor *author = self.authors[indexPath.row];
    cell.textLabel.text = author.name;
    cell.detailTextLabel.text = author.authorDesc;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        LXYAuthor *author = self.authors[indexPath.row];
        
        [self.authors removeObject:author];
        [self removeAuthorFromDataSource:author];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        return;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if([vc isMemberOfClass:[LXYBooksListTableViewController class]])
    {
        LXYBooksListTableViewController *blvc = (LXYBooksListTableViewController *)vc;
        UITableViewCell *cell = (UITableViewCell *)sender;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        blvc.author = self.authors[indexPath.row];
        
        return;
    }
}

@end
