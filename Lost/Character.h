//
//  Character.h
//  Lost
//
//  Created by Claire Jencks on 4/1/14.
//  Copyright (c) 2014 Steve Toosevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Character : NSManagedObject

@property (nonatomic, retain) NSString * actorName;
@property (nonatomic, retain) NSString * passengerName;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * hairColor;
@property (nonatomic, retain) NSString * gender;

@end
