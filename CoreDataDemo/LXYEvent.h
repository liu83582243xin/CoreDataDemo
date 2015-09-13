//
//  LXYEvent.h
//  
//
//  Created by lxyzk on 15/9/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LXYEvent : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * happenDate;

@end
