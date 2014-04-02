//
//  Character.h
//  Lost
//
//  Created by Claire Jencks on 4/1/14.
//  Copyright (c) 2014 Claire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Character : NSManagedObject

@property (nonatomic, retain) NSString * actorName;
@property (nonatomic, retain) NSString * passengerName;

@end
