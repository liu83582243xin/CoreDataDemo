//
//  LXYAuthor.h
//  CoreDataDemo
//
//  Created by lxyzk on 15/9/13.
//  Copyright (c) 2015年 lxyzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LXYBook;

@interface LXYAuthor : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * authorDesc;
@property (nonatomic, retain) NSSet *books;
@end

@interface LXYAuthor (CoreDataGeneratedAccessors)

- (void)addBooksObject:(LXYBook *)value;
- (void)removeBooksObject:(LXYBook *)value;
- (void)addBooks:(NSSet *)values;
- (void)removeBooks:(NSSet *)values;

@end
