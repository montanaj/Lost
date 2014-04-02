//
//  RootViewController.m
//  Lost
//
//  Created by Steve Toosevich on 4/1/14.
//  Copyright (c) 2014 Claire Jencks. All rights reserved.
//

#import "RootViewController.h"
#import "Character.h"

@interface RootViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *actorNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passengerNameTextField;


@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic) NSArray* charactersArray;

@end

@implementation RootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"LOST";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67/255.0f green:97/255.0f blue:114/255.0f alpha:1.0f];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;

    [self load];
    
}
- (IBAction)onAddButtonTapped:(id)sender

{
    Character* character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];
    character.passengerName = self.passengerNameTextField.text;
    character.actorName = self.actorNameTextField.text;
    [self.managedObjectContext save:nil];
    
    [self.passengerNameTextField resignFirstResponder];
    [self.actorNameTextField resignFirstResponder];
    [self load];
    
}


#pragma mark FILTER & LOADING INTO TABLEVIEW CELLS

-(void)load
{
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Character"];
   
    NSSortDescriptor* sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"actorName" ascending:YES];
    //NSSortDescriptor* sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"passengerName" ascending:YES];
    NSArray* sortDescriptorsArray = [NSArray arrayWithObjects:sortDescriptor1, nil];
    request.sortDescriptors = sortDescriptorsArray;
    
    self.charactersArray = [self.managedObjectContext executeFetchRequest:request error:nil];
    
        if (self.charactersArray.count == 0)
        {
            
            // get (from internet) array of dictionaries that represent lost characters
            NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/2/lost.plist"];
            self.charactersArray = [NSArray arrayWithContentsOfURL:url];
            
            // we will put the Character objects in here
            NSMutableArray *mutableArray = [NSMutableArray new];
            
            // crap! charactersArray is an array of dictionaries
            for (NSDictionary *characterDictionary in self.charactersArray)
            {
                
                // Convert each NSDictionary into a Character object
                Character* character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];
                character.actorName= characterDictionary[@"actor"];
                
                character.passengerName= characterDictionary[@"passenger"];
                
                [mutableArray addObject:character];
                
            };
            self.charactersArray = mutableArray;
        }
    [self.myTableView reloadData];
}

#pragma mark CELL POPULATING METHODS

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.charactersArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Character* character = self.charactersArray[indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"LostCharactersReuseID"];
    cell.textLabel.text = character.actorName;
    cell.detailTextLabel.text = character.passengerName.description;
    return cell;
    
}


#pragma MARK  SWIPE TO DELETE

//allow the standard swipe to delete functionality
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.managedObjectContext deleteObject:self.charactersArray[indexPath.row]];
        [self.managedObjectContext save:nil];
        [self load];
    }
}


//change the title of the delete confirmation button
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Smoke Monster";
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
{
    //    CharacterDetailViewController* viewController = segue.destinationViewController;
    //    viewController.managedObjectContext = self.managedObjectContext;
}


- (IBAction)unwindFromCharacterDetail:(UIStoryboard*)segue
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
