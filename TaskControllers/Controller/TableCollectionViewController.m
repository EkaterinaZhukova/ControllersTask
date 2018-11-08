//
//  TableCollectionViewController.m
//  TaskControllers
//
//  Created by Екатерина on 10/30/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "TableCollectionViewController.h"
#import "CustomTableViewCell.h"
#import "Masonry.h"
#import "ViewControllerFromCell.h"
#import "SelectedIndexViewController.h"


@interface TableCollectionViewController ()
@property (nonatomic,retain) UIButton *closeButton;
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) UICollectionView *collectionView;

@end

@interface TableCollectionViewController(TableView) <UITableViewDataSource,UITableViewDelegate>
@end



@implementation TableCollectionViewController

- (void) createButton{
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [self.closeButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    
    [self.closeButton addTarget:self action:@selector(onCloseAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.closeButton];
    
}
-(void) addConstraints{
    __weak typeof(self) weakSelf = self;
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@(weakSelf.view.safeAreaInsets.bottom + 20));
        make.left.equalTo(weakSelf.view.mas_left).with.offset(20);
        make.height.equalTo(@(50));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.top.equalTo(weakSelf.closeButton.mas_bottom);
    }];
}
-(void)onCloseAction{
    if(self.onCloseBlock){
        self.onCloseBlock();
    }
}
- (void) createTableView{
    
    UITableView * table = [[UITableView alloc]initWithFrame:CGRectMake(0, self.closeButton.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.closeButton.bounds.size.height)];
    
    self.tableView = table;
    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = false;
    self.tableView.rowHeight = 100;
    [self.view addSubview:self.tableView];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self createButton];
    [self createTableView];
    [self addConstraints];
}

- (void)dealloc{
    NSLog(@"dealloc TableCollectinViewController");
}

@end



@implementation TableCollectionViewController(TableView)

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [tableView setRowHeight:100];
    
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


@end


@interface TableCollectionViewController(CustomCellProtocol) <ViewControllerFromCell>

@end

@implementation TableCollectionViewController(CustomCellProtocol)

- (void)showNewViewController:(nonnull NSString *)selectedIndex {
    if(self.onCreateSelectedIndex){
        self.onCreateSelectedIndex(selectedIndex);
    }
}

@end
