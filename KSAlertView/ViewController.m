//
//  ViewController.m
//  KSAlertView
//
//  Created by Turboks on 2020/12/10.
//

#import "ViewController.h"
#import "KSAlertView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableview;
@property (nonatomic, strong) NSMutableArray * array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array = [[NSMutableArray alloc] initWithObjects:@"单按钮ALert",@"双按钮ALert",@"网络图片+按钮ALert",@"本地图片+单按钮ALert",@"网页ALert",@"GIF遮罩ALert",@"文字遮罩ALert",@"单选列表ALert",@"多选列表ALert", nil];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _tableview.delegate  = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = _array[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            KSAlertView * ks = [[KSAlertView alloc] initWithTitle:@"Title" message:@"Message" otherBtnTitle:@"other" clickIndexBlock:^(NSInteger index) {
                
            }];
            [ks show];
        }
            break;
        case 1:
        {
            KSAlertView * ks = [[KSAlertView alloc] initWithTitle:@"Title" message:@"Message" cancelBtnTitle:@"cancel" otherBtnTitle:@"other" clickIndexBlock:^(NSInteger index) {
                
            }];
            [ks show];
        }
            break;
        case 2:
        {
            KSAlertView * ks = [[KSAlertView alloc] initWithImageUrl:[NSURL URLWithString:@"https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1819216937,2118754409&fm=26&gp=0.jpg"] closeBtn:[UIImage imageNamed:@"close"] clickImageBlock:^{
            }];
            [ks show];
        }
            break;
        case 3:
        {
            KSAlertView * ks = [[KSAlertView alloc] initWithImage:[UIImage imageNamed:@"logo"] closeBtn:[UIImage imageNamed:@"close"] clickImageBlock:^{
            }];
            [ks show];
        }
            break;
            
            
        case 4:
        {
            KSAlertView * ks = [[KSAlertView alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"] closeBtn:[UIImage imageNamed:@"close"]];
            [ks show];
        }
            break;
            
        case 5:
        {
            KSAlertView * ks = [[KSAlertView alloc] initWithGif:@"loading" endBlock:^{
            }];
            [ks show];
        }
            break;
        case 6:
        {
            KSAlertView * ks = [[KSAlertView alloc] initWithText:@"loading..." showTime:1.0 endBlock:^{
            }];
            [ks show];
        }
            break;
            
        case 7:
        {
            KSAlertView * ks = [[KSAlertView alloc] initWithArratList:[NSMutableArray arrayWithObjects:@"111",@"222",@"333",@"444",@"555",nil] cancelBtn:@"取消" otherBtn:@"确定" clickBlock:^(NSInteger index) {
                NSLog(@"选择了%ld",(long)index);
            }];
            [ks show];
        }
            break;
        case 8:
        {
            KSAlertView * ks = [[KSAlertView alloc] initWithArratList:[NSMutableArray arrayWithObjects:@"111",@"222",@"333",@"444",@"555",nil] cancelBtn:@"取消" otherBtn:@"确定" clickArrBlock:^(NSMutableArray *arr) {
                NSLog(@"%@",arr);
            }];
            [ks show];
        }
            break;
        default:
            break;
    }
    
}

@end

