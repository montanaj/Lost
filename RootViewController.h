//
//  RootViewController.h
//  Lost
//
//  Created by Claire Jencks on 4/1/14.
//  Copyright (c) 2014 Claire Jencks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RootViewController : UIViewController
//conduit to allow view controllers to talk to each other - allows data to move between train stations, (it's the track)
@property NSManagedObjectContext* managedObjectContext;

@end
