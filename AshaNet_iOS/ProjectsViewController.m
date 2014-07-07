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

@property (nonatomic, strong) NSMutableArray *projects;

@end

@implementation ProjectsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.projects = [[NSMutableArray alloc]init];
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
    
    [self getProjectsFromParse];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.projects.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProjectsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectCell" forIndexPath:indexPath];
    [cell customizeCell:self.projects[indexPath.row]];
    
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
    pdvc.project = self.projects[indexPath.row];
    pdvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pdvc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark - Helper methods

- (void) getProjectsFromParse{
    PFQuery *query = [PFQuery queryWithClassName:@"Project"];
    NSArray *objects = [query findObjects];
    
    for (NSDictionary *object in objects){
        Project *e = [[Project alloc]initWithDictionary:object];
        [self.projects addObject:e];
    }
    
}
@end
