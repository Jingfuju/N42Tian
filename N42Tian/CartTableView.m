//
//  CartTableView.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/21/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "CartTableView.h"
#import "CartProductInfo+CoreDataClass.h"

@interface CartTableView ()

@end

@implementation CartTableView {
        NSFetchedResultsController *_fetchedResultsController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performFetch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(NSFetchedResultsController *) fetchedResultsController {
    if (_fetchedResultsController == nil) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"CartProductInfo" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        [fetchRequest setFetchBatchSize:20];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"CartProductInfos"];
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;
}


@end
