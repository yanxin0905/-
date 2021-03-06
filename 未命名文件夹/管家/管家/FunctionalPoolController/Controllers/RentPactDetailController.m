//
//  RentPactDetailController.m
//  管家
//
//  Created by mac on 16/5/10.
//  Copyright © 2016年 yanxin. All rights reserved.
//

#import "RentPactDetailController.h"
#import "PrefixHeader.pch"
#import "RentPactDetailCell.h"
#import "RentPactDetailModel.h"

@interface RentPactDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation RentPactDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataArray = [NSMutableArray new];
    [self createTableView];
    [self createData];
}

- (void)createData
{
    [HttpRequest Get:[NSString stringWithFormat:ProtocolRentPactDetail_URL,_rentNo] complete:^(AFHTTPRequestOperation *operation, id reseponeObject, NSError *error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:reseponeObject options:NSJSONReadingAllowFragments error:nil];
        RentPactDetailModel *model = [[RentPactDetailModel alloc] init];
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([key isEqualToString:@"rentPact"]) {
                [model setValuesForKeysWithDictionary:obj];
            }else if ([key isEqualToString:@"roomShow"]){
                [model setValuesForKeysWithDictionary:obj];
                [model setValue:obj[@"name"] forKey:@"renter_name"];
            }else if ([key isEqualToString:@"renter"]){
                [model setValuesForKeysWithDictionary:obj];
                [model setValue:obj[@"name"] forKey:@"name"];
            }else if ([key isEqualToString:@"attrList"]){
                model.attrList = obj;
            }
        }];
        [_dataArray addObject:model];
        [_tableView reloadData];
    }];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RentPactDetailCell *cell = [RentPactDetailCell new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RentPactDetailModel *model = _dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 735;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
