//
//  KSAlertView.m
//  demo
//
//  Created by 爱尚家 on 2020/12/9.
//
#define SCREEBRECT          [UIScreen mainScreen].bounds
#define WINDOW              [[[UIApplication sharedApplication] windows] lastObject]
#define DEVWIDTH            [UIScreen mainScreen].bounds.size.width
#define DEVHEIGHT           [UIScreen mainScreen].bounds.size.height

#define BackColor           [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.50]
#define RedColor            [UIColor colorWithRed:0.96 green:0.33 blue:0.33 alpha:1.00]
#define GrayColor           [UIColor colorWithRed:0.95 green:0.95 blue:0.96 alpha:1.00]

#define TitleFont           [UIFont boldSystemFontOfSize:18]
#define ShowTxtFont         [UIFont boldSystemFontOfSize:16]
#define MessageFont         [UIFont systemFontOfSize:14]
#define BtnFont             [UIFont systemFontOfSize:16]

#define TitleHeight         DEVWIDTH/8
#define ContentWidth        DEVWIDTH/1.5
#define BtnHeight           DEVWIDTH/8

#define ImageWidth          DEVWIDTH/2
#define ImageHeight         DEVWIDTH/2


#define GifWidth            100.0f
#define GifHeight           100.0f


#define WebWidth            DEVWIDTH/1.5
#define WebHeight           DEVHEIGHT/2

#define CELLHeight          DEVWIDTH/8

#define Padding             20.0f

#import "KSAlertView.h"
#import "UIImage+GIF.h"


@interface KSAlertView()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL ISArr;
    NSInteger selIndex;
    NSString * selImage;
    NSString * unselImage;
}
@property (nonatomic, strong) UITableView       * tableView;
@property (nonatomic, strong) NSMutableArray    * arrayList;
@property (nonatomic, strong) NSMutableArray    * arraySelList;
@end

@implementation KSAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message otherBtnTitle:(NSString *)cancelTitle clickIndexBlock:(KSAlertClickIndexBlock)block{
    self = [super init];
    if (self) {
        
        self.frame = SCREEBRECT;
        self.backgroundColor = BackColor;
        
        //计算传入的message的文字高度
        NSDictionary *attrs = @{NSFontAttributeName : MessageFont};
        CGSize maxSize = CGSizeMake(ContentWidth-Padding, MAXFLOAT);
        CGSize size = [message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        float messageheight = size.height + Padding*2;
        
        //背景contentview
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ContentWidth,DEVWIDTH/4 + messageheight)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.center = self.center;
        self.contentView.layer.cornerRadius=6.0;
        self.contentView.layer.masksToBounds=YES;
        
        //title
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ContentWidth, TitleHeight)];
        self.titleLab.text = title;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.font = TitleFont;
        [self.contentView addSubview:self.titleLab];
        
        //message
        self.messageLab = [[UILabel alloc] initWithFrame:CGRectMake(Padding/2, self.titleLab.bounds.size.height, ContentWidth-Padding, messageheight)];
        self.messageLab.text = message;
        self.messageLab.textAlignment = NSTextAlignmentCenter;
        self.messageLab.font = MessageFont;
        self.messageLab.numberOfLines = 0;
        [self.contentView addSubview:self.messageLab];
        
        //cancelBtn
        self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,TitleHeight+messageheight, ContentWidth, BtnHeight)];
        [self.cancelBtn setTitleColor:[UIColor grayColor] forState:0];
        [self.cancelBtn setTitle:cancelTitle forState:0];
        [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:0];
        self.cancelBtn.tag = 0;
        [self.cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.cancelBtn.titleLabel.font = BtnFont;
        self.cancelBtn.backgroundColor = RedColor;
        [self.contentView addSubview:self.cancelBtn];
        
        [self addSubview:self.contentView];
        self.clickIndexBlock = block;
    }
    
    return self;
    
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(KSAlertClickIndexBlock)block{
    self = [super init];
    if (self) {
        
        self.frame = SCREEBRECT;
        self.backgroundColor = BackColor;
        
        //计算传入的message的文字高度
        NSDictionary *attrs = @{NSFontAttributeName : MessageFont};
        CGSize maxSize = CGSizeMake(ContentWidth-Padding, MAXFLOAT);
        CGSize size = [message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        float messageheight = size.height + Padding*2;
        
        //背景contentview
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ContentWidth,DEVWIDTH/4 + messageheight)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.center = self.center;
        self.contentView.layer.cornerRadius = 6.0;
        self.contentView.layer.masksToBounds = YES;
        
        //title
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ContentWidth, TitleHeight)];
        self.titleLab.text = title;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.font = TitleFont;
        [self.contentView addSubview:self.titleLab];
        
        //message
        self.messageLab = [[UILabel alloc] initWithFrame:CGRectMake(Padding/2, self.titleLab.bounds.size.height, ContentWidth-Padding, messageheight)];
        self.messageLab.text = message;
        self.messageLab.textAlignment = NSTextAlignmentCenter;
        self.messageLab.font = MessageFont;
        self.messageLab.numberOfLines = 0;
        [self.contentView addSubview:self.messageLab];
        
        //cancelBtn
        self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,TitleHeight+messageheight, ContentWidth/2, BtnHeight)];
        [self.cancelBtn setTitleColor:[UIColor grayColor] forState:0];
        [self.cancelBtn setTitle:cancelTitle forState:0];
        self.cancelBtn.tag = 0;
        [self.cancelBtn addTarget:self action:@selector(removebtn) forControlEvents:UIControlEventTouchUpInside];
        self.cancelBtn.titleLabel.font = BtnFont;
        self.cancelBtn.backgroundColor = GrayColor;
        [self.contentView addSubview:self.cancelBtn];
        
        //otherBtn
        self.otherBtn = [[UIButton alloc] initWithFrame:CGRectMake(ContentWidth/2, TitleHeight+messageheight, ContentWidth/2, BtnHeight)];
        [self.otherBtn setTitleColor:[UIColor whiteColor] forState:0];
        [self.otherBtn setTitle:otherBtnTitle forState:0];
        self.otherBtn.tag = 1;
        [self.otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.otherBtn.titleLabel.font = BtnFont;
        self.otherBtn.backgroundColor = RedColor;
        [self.contentView addSubview:self.otherBtn];
        
        [self addSubview:self.contentView];
        self.clickIndexBlock = block;
    }
    return self;
}

- (instancetype)initWithImageUrl:(NSURL *)url closeBtn:(UIImage *)close clickImageBlock:(KSAlertClickImageBlock)imageblock{
    self = [super init];
    if (self) {
        
        self.frame = SCREEBRECT;
        self.backgroundColor = BackColor;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WebWidth, WebHeight)];
        self.imageView.center = self.center;
        //下载网络图片
        dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
        dispatch_async(queue, ^{
            NSData *resultData = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:resultData];
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.imageView.image = img;
            });
        });
        [self addSubview:self.imageView];
        
        //给图片添加手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouch)];
        self.imageView.userInteractionEnabled = YES;
        [self.imageView addGestureRecognizer:tap];
        
        self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.imageView.frame.size.height, 40, 40)];
        [self.closeBtn setBackgroundImage:close forState:0];
        self.closeBtn.tag = 0;
        [self.closeBtn addTarget:self action:@selector(removebtn) forControlEvents:UIControlEventTouchUpInside];
        self.closeBtn.center = CGPointMake(DEVWIDTH/2, self.imageView.frame.origin.y + WebHeight + 60);
        [self addSubview:self.closeBtn];
        
        self.clickImageBlock = imageblock;
    }
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image closeBtn:(UIImage *)close clickImageBlock:(KSAlertClickImageBlock)imageblock{
    self = [super init];
    if (self) {
        
        self.frame = SCREEBRECT;
        self.backgroundColor = BackColor;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WebWidth, WebHeight)];
        self.imageView.center = self.center;
        self.imageView.image = image;
        [self addSubview:self.imageView];
        
        //给图片添加手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouch)];
        self.imageView.userInteractionEnabled = YES;
        [self.imageView addGestureRecognizer:tap];
        
        self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.imageView.frame.size.height, 40, 40)];
        [self.closeBtn setBackgroundImage:close forState:0];
        self.closeBtn.tag = 0;
        [self.closeBtn addTarget:self action:@selector(removebtn) forControlEvents:UIControlEventTouchUpInside];
        self.closeBtn.center = CGPointMake(DEVWIDTH/2, self.imageView.frame.origin.y + WebHeight + 60);
        [self addSubview:self.closeBtn];
        
        self.clickImageBlock = imageblock;
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)url closeBtn:(UIImage *)close{
    self = [super init];
    if (self) {
        
        self.frame = SCREEBRECT;
        self.backgroundColor = BackColor;
        
        self.webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, WebWidth, WebHeight)];
        [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
        self.webview.center = self.center;
        [self addSubview:self.webview];
        
        self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [self.closeBtn setBackgroundImage:close forState:0];
        self.closeBtn.tag = 0;
        [self.closeBtn addTarget:self action:@selector(removebtn) forControlEvents:UIControlEventTouchUpInside];
        self.closeBtn.center = CGPointMake(DEVWIDTH/2, self.webview.frame.origin.y + WebHeight + 60);
        [self addSubview:self.closeBtn];
        
    }
    return self;
}

- (instancetype)initWithGif:(NSString *)gifImage endBlock:(KSAlertGifEndBlock)block{
    self = [super init];
    if (self) {
        
        self.frame = SCREEBRECT;
        self.backgroundColor = BackColor;
        
        UIImage * image = [UIImage imageWithGIFNamed:gifImage];
        float timeInterval = image.duration;
        
        self.gifimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GifWidth, GifHeight)];
        self.gifimageView.center = self.center;
        self.gifimageView.image = image;
        [self addSubview:self.gifimageView];
        
        self.gifEndBlock = block;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, timeInterval * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self gifEnd];
            });
        });
    }
    return self;
}

- (instancetype)initWithText:(NSString *)showText showTime:(int)time endBlock:(KSAlertGifEndBlock)block{
    self = [super init];
    if (self) {
        self.frame = SCREEBRECT;
        self.backgroundColor = BackColor;
        
        //计算传入的message的文字高度
        NSDictionary *attrs = @{NSFontAttributeName : MessageFont};
        CGSize maxSize = CGSizeMake(DEVWIDTH/2, MAXFLOAT);
        CGSize size = [showText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        float textheight = size.height + 20;
        
        self.hubLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVWIDTH/2, textheight)];
        self.hubLabel.center = self.center;
        self.hubLabel.layer.masksToBounds = YES;
        self.hubLabel.layer.cornerRadius=6.0;
        self.hubLabel.textColor = [UIColor whiteColor];
        self.hubLabel.backgroundColor = [UIColor grayColor];
        self.hubLabel.textAlignment = NSTextAlignmentCenter;
        self.hubLabel.font = ShowTxtFont;
        self.hubLabel.text = showText;
        [self addSubview:self.hubLabel];
        
        self.gifEndBlock = block;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self gifEnd];
            });
        });
    }
    return self;
}


- (instancetype)initWithArratList:(NSMutableArray *)list cancelBtn:(NSString *)cancel otherBtn:(NSString *)other clickBlock:(KSAlertClickIndexBlock)block{
    
    self = [super init];
    if (self) {
        
        self.frame = SCREEBRECT;
        self.backgroundColor = BackColor;
        
        self.arrayList = [[NSMutableArray alloc] init];
        self.arrayList = list;
        
        ISArr = NO;
        
        float tablehright = CELLHeight*self.arrayList.count;
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WebWidth, tablehright + BtnHeight)];
        self.contentView.center = self.center;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 6.0f;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WebWidth, tablehright) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:self.tableView];
        
        //cancelBtn
        self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,tablehright, WebWidth/2,BtnHeight)];
        [self.cancelBtn setTitleColor:[UIColor grayColor] forState:0];
        [self.cancelBtn setTitle:cancel forState:0];
        self.cancelBtn.tag = 0;
        [self.cancelBtn addTarget:self action:@selector(removebtn) forControlEvents:UIControlEventTouchUpInside];
        self.cancelBtn.titleLabel.font = BtnFont;
        [self.contentView addSubview:self.cancelBtn];
        
        //otherBtn
        self.otherBtn = [[UIButton alloc] initWithFrame:CGRectMake(WebWidth/2,tablehright, WebWidth/2,BtnHeight)];
        [self.otherBtn setTitleColor:[UIColor blueColor] forState:0];
        [self.otherBtn setTitle:other forState:0];
        self.otherBtn.tag = 1;
        [self.otherBtn addTarget:self action:@selector(tableviewClick) forControlEvents:UIControlEventTouchUpInside];
        self.otherBtn.titleLabel.font = BtnFont;
        [self.contentView addSubview:self.otherBtn];
        
        [self addSubview:self.contentView];
        
        self.clickIndexBlock = block;
    }
    return self;
}

- (instancetype)initWithArratList:(NSMutableArray *)list cancelBtn:(NSString *)cancel otherBtn:(NSString *)other clickArrBlock:(KSAlertClickArrBlock)arrblock{
    
    self = [super init];
    if (self) {
        
        self.frame = SCREEBRECT;
        self.backgroundColor = BackColor;
        
        self.arrayList = [[NSMutableArray alloc] init];
        self.arraySelList = [[NSMutableArray alloc] init];
        self.arrayList = list;
        
        ISArr = YES;
        
        float tablehright = CELLHeight*self.arrayList.count;
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WebWidth, tablehright + BtnHeight)];
        self.contentView.center = self.center;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 6.0f;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WebWidth, tablehright) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:self.tableView];
        
        //cancelBtn
        self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,tablehright, WebWidth/2,BtnHeight)];
        [self.cancelBtn setTitleColor:[UIColor grayColor] forState:0];
        [self.cancelBtn setTitle:cancel forState:0];
        self.cancelBtn.tag = 0;
        [self.cancelBtn addTarget:self action:@selector(removebtn) forControlEvents:UIControlEventTouchUpInside];
        self.cancelBtn.titleLabel.font = BtnFont;
        [self.contentView addSubview:self.cancelBtn];
        
        //otherBtn
        self.otherBtn = [[UIButton alloc] initWithFrame:CGRectMake(WebWidth/2,tablehright, WebWidth/2,BtnHeight)];
        [self.otherBtn setTitleColor:[UIColor blueColor] forState:0];
        [self.otherBtn setTitle:other forState:0];
        self.otherBtn.tag = 1;
        [self.otherBtn addTarget:self action:@selector(tableviewClick) forControlEvents:UIControlEventTouchUpInside];
        self.otherBtn.titleLabel.font = BtnFont;
        [self.contentView addSubview:self.otherBtn];
        
        [self addSubview:self.contentView];
        
        self.clickIndexArrBlock  = arrblock;
    }
    return self;
}

- (void)setSelectImage:(NSString *)select unSelectImage:(NSString *)unsel{
    selImage = select;
    unselImage = unsel;
}

#pragma mark tableview 相关

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if (selImage == nil || unselImage == nil) {
        selImage = @"sel_yes";
        unselImage = @"sel_no";
    }
    
    //多选
    if (ISArr) {
        NSString * str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        if ([self.arraySelList containsObject:str]) {
            cell.imageView.image = [UIImage imageNamed:selImage];
        }else{
            cell.imageView.image = [UIImage imageNamed:unselImage];
        }
    }else{
        if (indexPath.row == selIndex) {
            cell.imageView.image = [UIImage imageNamed:selImage];
        }else{
            cell.imageView.image = [UIImage imageNamed:unselImage];
        }
    }
    cell.textLabel.text = self.arrayList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if (ISArr) {
        if ([self.arraySelList containsObject:str]) {
            [self.arraySelList removeObject:str];
        }else{
            [self.arraySelList addObject:str];
        }
    }else{
        selIndex = indexPath.row;
    }
    [self.tableView reloadData];
}

#pragma mark 回调事件

-(void)tableviewClick{
    __weak typeof(self) weakSelf = self;
    //多选
    if (ISArr) {
        if (self.clickIndexArrBlock) {
            self.clickIndexArrBlock(self.arraySelList);
        }
    }else{
        if (self.clickIndexBlock) {
            self.clickIndexBlock(selIndex);
        }
    }
    //移除当前视图
    [weakSelf diss];
}

-(void)removebtn{
    [self diss];
}

-(void)gifEnd{
    __weak typeof(self) weakSelf = self;
    if (self.gifEndBlock) {
        self.gifEndBlock();
    }
    //移除当前视图
    [weakSelf diss];
}

-(void)imageTouch{
    __weak typeof(self) weakSelf = self;
    if (self.clickImageBlock) {
        self.clickImageBlock();
    }
    //移除当前视图
    [weakSelf diss];
}

-(void)btnClick:(UIButton *)btn{
    __weak typeof(self) weakSelf = self;
    if (self.clickIndexBlock) {
        self.clickIndexBlock(btn.tag);
    }
    if (self.webview) {
        [self.webview stopLoading];
    }
    //移除当前视图
    [weakSelf diss];
}

- (void)show{
    [WINDOW addSubview:self];
}
- (void)diss{
    [self removeFromSuperview];
}
-(void)dealloc{
    NSLog(@"%s",__func__);
}

@end
