//
//  CustomTableViewCell.h
//  Lost
//
//  Created by Claire Jencks on 4/1/14.
//  Copyright (c) 2014 Steve Toosevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (nonatomic) NSString* cellText;
@end
