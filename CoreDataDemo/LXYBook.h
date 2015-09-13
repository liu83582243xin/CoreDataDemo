//
//  LXYBook.h
//  CoreDataDemo
//
//  Created by lxyzk on 15/9/13.
//  Copyright (c) 2015年 lxyzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface LXYBook : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * pulicationDate;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSManagedObject *author;

@end
