//
//  ViewController.m
//  LeviTest2
//
//  Created by Aditya Athavale on 4/27/15.
//  Copyright (c) 2015 Aditya Athavale. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataArray;
    int screenIdentifier;
    __weak IBOutlet UITableView *table;
    float tableOffset;
    float rowHeight;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenIdentifier = 1;
    
    //Load first screen..Default values.
    dataArray = [NSMutableArray arrayWithObjects:@"A", @"A1", @"A2", @"A3", @"A4", @"A5", @"A6", @"A7", @"A8", @"A9",@"A10", nil];
    
    
    //Add gesture Recognizers to enable swipe.
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeDetected:)];
    leftSwipe.direction= UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeDetected:)];
    rightSwipe.direction= UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upSwipeDetected:)];
    upSwipe.direction= UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipeDetected:)];
    downSwipe.direction= UISwipeGestureRecognizerDirectionDown;
    
    [table addGestureRecognizer:leftSwipe];
    [table addGestureRecognizer:rightSwipe];
    [table addGestureRecognizer:upSwipe];
    [table addGestureRecognizer:downSwipe];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    rowHeight = table.frame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftSwipeDetected:(id)sender
{
    //Left swipe means user wants to move to next screen.
    screenIdentifier++;
    if(screenIdentifier == 6)
    {
        screenIdentifier = 5;
    }
    [self reloadTableData];
}

-(void)rightSwipeDetected:(id)sender
{
    //Right swipe means user wants to go back.
    screenIdentifier--;
    if(screenIdentifier == 0)
    {
        screenIdentifier = 1;
    }
    [self reloadTableData];
}

-(void)upSwipeDetected:(id)sender
{
    //For first swipe it should go by 400 pixel and then by table hight.
    if(tableOffset == 0)
    {
        tableOffset = 400;
    }
    else
    {
        tableOffset = tableOffset + rowHeight;
        //Taking care of last swipe so that it does not go off the screen
        if(tableOffset > ((rowHeight * dataArray.count)-400))
        {
           tableOffset = tableOffset - rowHeight;
        }
    }
    [UIView animateWithDuration:0.5 animations:^{
    [table setContentOffset:CGPointMake(0, tableOffset)];
    }];
}

-(void)downSwipeDetected:(id)sender
{
    tableOffset = tableOffset - rowHeight;
    if(tableOffset < 0)
    {
        tableOffset = 0;
    }
    [UIView animateWithDuration:0.5 animations:^{
    [table setContentOffset:CGPointMake(0, tableOffset)];
    }];
}

-(void)reloadTableData
{
    //Adjust array contents based on selected screen.
    [dataArray removeAllObjects];
    switch (screenIdentifier)
    {
        case 1:
            [dataArray addObjectsFromArray:[NSArray arrayWithObjects:@"A",@"A1", @"A2", @"A3", @"A4", @"A5", @"A6", @"A7", @"A8", @"A9",@"A10", nil]];
            break;
        case 2:
            [dataArray addObjectsFromArray:[NSArray arrayWithObjects:@"B",@"B1", @"B2", @"B3", @"B4", @"B5", @"B6", @"B7", @"B8", @"B9",@"B10", nil]];
            break;
        case 3:
            [dataArray addObjectsFromArray:[NSArray arrayWithObjects:@"C",@"C1", @"C2", @"C3", @"C4", @"C5", @"C6", @"C7", @"C8", @"C9",@"C10", nil]];
            break;
        case 4:
            [dataArray addObjectsFromArray:[NSArray arrayWithObjects:@"D",@"D1", @"D2", @"D3", @"D4", @"D5", @"D6", @"D7", @"D8", @"D9",@"D10", nil]];
            break;
        case 5:
            [dataArray addObjectsFromArray:[NSArray arrayWithObjects:@"E",@"E1", @"E2", @"E3", @"E4", @"E5", @"E6", @"E7", @"E8", @"E9",@"E10", nil]];
            break;
        default:
            break;
    }
    [table reloadData];
}


#pragma mark Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FirstCell"];
        cell.lblTitle.text = [dataArray objectAtIndex:indexPath.row];
    }
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CustomCellIdentifier"];

    cell.lblTitle.text = [dataArray objectAtIndex:indexPath.row];
//    NSLog(@"Cell Index : %ld : Cell height :%.2f", (long)indexPath.row,cell.frame.size.height);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 400;
    }
    return 667;
}


@end
