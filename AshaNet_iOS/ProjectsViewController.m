//
//  ProjectsViewController.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "ProjectsViewController.h"
#import "ProjectsTableViewCell.h"
#import "ProjectDetailsViewController.h"

@interface ProjectsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *projectsTable;
@property (nonatomic, strong) ProjectsTableViewCell *prototypeCell;
@property (nonatomic, copy) NSArray *projects;

@end

@implementation ProjectsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.projectsTable.dataSource = self;
    self.projectsTable.delegate = self;
    self.projectsTable.rowHeight = 130;
    // Do any additional setup after loading the view from its nib.
    UINib *projectCellNib = [UINib nibWithNibName:@"ProjectsTableViewCell" bundle:nil];
    [self.projectsTable registerNib:projectCellNib forCellReuseIdentifier:@"ProjectCell"];
    self.prototypeCell = [self.projectsTable dequeueReusableCellWithIdentifier:@"ProjectCell"];
    
    self.navigationItem.title = @"Projects - What we do";

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProjectsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectCell" forIndexPath:indexPath];
 //   cell.project = self.projects[indexPath.row];
    
    return cell;
}

////- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
////{
//////    self.prototypeCell.project = self.projects[indexPath.row];
////    [self.prototypeCell layoutSubviews];
////    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
////    return size.height + 1;
////}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 140;
//}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    //MovieModel *movieModel = self.movies[indexPath.row];
    
    [self.projectsTable deselectRowAtIndexPath:indexPath animated:NO];
    ProjectDetailsViewController *pdvc = [[ProjectDetailsViewController alloc]init];
   // pdvc.selectedMovie = movieModel;
    pdvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pdvc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
