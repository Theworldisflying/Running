//
//  HistoryViewController.m
//  Running
//
//  Created by guangwei li on 2018/5/7.
//  Copyright © 2018年 123. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryTableViewCell.h"
#import "HealthDetailsViewController.h"
#import "HealthModel.h"


#import "UIBarButtonItem+XYMenu.h"

#define TableCellId @"HealthHistory"

#define ShowDay @"ShowDays"

@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView * tableView;

@property (strong,nonatomic) NSMutableArray * arr;
@property (strong,nonatomic) NSMutableArray * getDataArr;

@property(strong,nonatomic)MyUserDefaults * userDefaults;

@property(strong,nonatomic) FMDBManager *db;

@property(strong,nonatomic) NSArray * dayArr;

@end

@implementation HistoryViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getDataFormdb];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.db = [FMDBManager shareDatabase];
    
    self.dayArr = @[@"7天内", @"30天内", @"一年内", @"所有"];
    
     CGFloat f = [MyUserDefaults readUserDefaultsKey:ShowDay];
    
    if (f == 0) {
        [MyUserDefaults wirteUserDefaultsF:1 andKey:ShowDay];
    }
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除记录" style:UIBarButtonItemStylePlain target:self action:@selector(left:)];
    
    int index = [MyUserDefaults readUserDefaultsKey:ShowDay];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.dayArr[index-1] style:UIBarButtonItemStylePlain target:self action:@selector(right:)];
    
   [self setTableView];
}

-(void)left:(UIBarButtonItem*)item{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",@"清除所有历史记录"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action){}];
    [alert addAction:cancel];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action){
        
        [self.db deleteAllDataFromTable:HealthTable];
        [self.getDataArr removeAllObjects];
        [self.tableView reloadData];


    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:true completion:nil];
    
}
-(void)right:(UIBarButtonItem*)item{
    NSArray *imgArr = @[@"clock", @"clock", @"clock", @"clock"];
    [item xy_showMenuWithImages:imgArr titles:_dayArr menuType:XYMenuRightNavBar currentNavVC:self.navigationController withItemClickIndex:^(NSInteger index) {
        NSLog(@"index==%ld",index);
        
        [self.navigationItem.rightBarButtonItem setTitle:self.dayArr[index-1]];
        [MyUserDefaults wirteUserDefaultsF:index andKey:ShowDay];
        
        if (index == 1) {
            if (self.arr.count < 7) {
                self.getDataArr = self.arr;
            }else{
                self.getDataArr = [NSMutableArray arrayWithArray:[self.arr subarrayWithRange:NSMakeRange(0, 7)]];
            }
           
            
        }else if (index == 2){
            if (self.arr.count < 30) {
                self.getDataArr = self.arr;
            }else{
                self.getDataArr = [NSMutableArray arrayWithArray:[self.arr subarrayWithRange:NSMakeRange(0, 30)]];
            }
        }else if (index == 3){
            if (self.arr.count < 365) {
                self.getDataArr = self.arr;
            }else{
                self.getDataArr = [NSMutableArray arrayWithArray:[self.arr subarrayWithRange:NSMakeRange(0, 365)]];
            }
        }else{
           self.getDataArr = self.arr;
        }
         [self.tableView reloadData];
  
    }];
}

#pragma mark-getData
-(void)getDataFormdb{
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray  * healthArr = [self.db lookupTable:HealthTable dicOrModel:[HealthModel class] whereFormat:nil];
//    NSMutableArray * caArr = [NSMutableArray arrayWithCapacity:7];
//    [caArr removeAllObjects];
//    [caArr addObjectsFromArray:healthArr]
    
    
    self.arr = [[NSMutableArray alloc] initWithArray:healthArr];
    
    int index = [MyUserDefaults readUserDefaultsKey:ShowDay];
    if (index == 1) {
        if (self.arr.count < 7) {
            self.getDataArr = self.arr;
        }else{
            self.getDataArr = [NSMutableArray arrayWithArray:[self.arr subarrayWithRange:NSMakeRange(0, 7)]];
        }
        
    }else if (index == 2){
        if (self.arr.count < 30) {
            self.getDataArr = self.arr;
        }else{
            self.getDataArr = [NSMutableArray arrayWithArray:[self.arr subarrayWithRange:NSMakeRange(0, 30)]];
        }
    }else if (index == 3){
        if (self.arr.count < 365) {
            self.getDataArr = self.arr;
        }else{
            self.getDataArr = [NSMutableArray arrayWithArray:[self.arr subarrayWithRange:NSMakeRange(0, 365)]];
        }
    }else{
        self.getDataArr = self.arr;
    }
 
    
    [self.tableView reloadData];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark-UITableView
-(void)setTableView{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.estimatedRowHeight = 60;
    tableView.rowHeight = UITableViewAutomaticDimension;
//    [tableView registerClass:[HistoryTableViewCell class] forCellReuseIdentifier:TableCellId];
    self.tableView = tableView;
    [self.view addSubview:tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _getDataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HistoryTableViewCell * cell = [[HistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TableCellId];
   
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    
    HealthModel * model = self.getDataArr[indexPath.row];
    
    [cell loadUIForStep:model.totalStep walkStep:model.compStep Date:model.savedate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HealthDetailsViewController * details = [[HealthDetailsViewController alloc] init];
    details.model = self.arr[indexPath.row];
    [self.navigationController pushViewController:details animated:YES ];
}

///单个按钮 删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        HealthModel * model = self.arr[indexPath.row];
        
        if (indexPath.row <self.arr.count) {
          [self.arr removeObjectAtIndex:indexPath.row];
        }
        
        
        [self.tableView reloadData];
        
        //    NSArray * healthArr = [self.db lookupTable:HealthTable dicOrModel:[HealthModel class] whereFormat:@"WHERE  savedate = '%@'",date];
        //    NSLog(@"=====000=====%@",healthArr);
        [self.db deleteTable:HealthTable whereFormat:@"WHERE  savedate = '%@'",model.savedate];

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }

}
///单个按钮title
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    self.tableView.contentSize = CGSizeMake(0, Height*1.5);
}


@end
