//
//  KSAlertView.h
//  demo
//
//  Created by 爱尚家 on 2020/12/9.
//

#import <UIKit/UIKit.h>
#import <WebKit/WKWebView.h>

typedef void(^KSAlertClickIndexBlock)(NSInteger index);
typedef void(^KSAlertClickImageBlock)(void);
typedef void(^KSAlertGifEndBlock)(void);
typedef void(^KSAlertClickArrBlock)(NSMutableArray * arr);

@interface KSAlertView : UIView

//文字类型
@property (nonatomic, strong) UIView        * contentView;          ///<弹出框
@property (nonatomic, strong) UILabel       * titleLab;             ///<标题标题
@property (nonatomic, strong) UILabel       * messageLab;           ///<标题内容
@property (nonatomic, strong) UIButton      * cancelBtn;            ///<标题取消按钮
@property (nonatomic, strong) UIButton      * otherBtn;             ///<标题其他按钮
//图片+文字类型
@property (nonatomic, strong) UIImageView   * imageView;            ///<图片
@property (nonatomic, strong) UIButton      * closeBtn;             ///<关闭按钮
//网页类型
@property (nonatomic, strong) WKWebView     * webview;              ///<网页显示
//遮罩类型
@property (nonatomic, strong) UIImageView   * gifimageView;         ///<gif图片（遮罩）
@property (nonatomic, strong) UILabel       * hubLabel;             ///<提示laebl（遮罩）

@property (nonatomic, copy) KSAlertClickIndexBlock clickIndexBlock; ///< 按钮点击事件block

@property (nonatomic, copy) KSAlertClickImageBlock clickImageBlock; ///< 图片点击事件block

@property (nonatomic, copy) KSAlertGifEndBlock gifEndBlock;         ///< gif和文字结束事件block

@property (nonatomic, copy) KSAlertClickArrBlock clickIndexArrBlock; ///< 列表多选事件block


/// 单按钮提示框
/// @param title 标题
/// @param message 内容
/// @param cancelTitle 按钮
/// @param block 点击block
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message otherBtnTitle:(NSString *)cancelTitle  clickIndexBlock:(KSAlertClickIndexBlock)block;

/// 双按钮提示框
/// @param title 标题
/// @param message 内容
/// @param cancelTitle 取消按钮
/// @param otherBtnTitle 其他按钮
/// @param block 点击block
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(KSAlertClickIndexBlock)block;

/// 网络图片+按钮   具体显示位置可以自己调整
/// @param url 图片URL
/// @param close 取消按钮图片
/// @param imageblock 点击图片block
-(instancetype)initWithImageUrl:(NSURL *)url closeBtn:(UIImage *)close clickImageBlock:(KSAlertClickImageBlock)imageblock;

/// 本地图片+按钮    具体显示位置可以自己调整
/// @param image 本地图片
/// @param close 取消按钮图片
/// @param imageblock 点击图片block
-(instancetype)initWithImage:(UIImage *)image closeBtn:(UIImage *)close clickImageBlock:(KSAlertClickImageBlock)imageblock;

/// 网页显示
/// @param url 链接
/// @param close 取消按钮图片
-(instancetype)initWithURL:(NSURL *)url closeBtn:(UIImage *)close;

/// 单gif遮罩
/// @param gifImage gif图片、显示时长为gif的循环时长
/// @param block 结束block
-(instancetype)initWithGif:(NSString *)gifImage endBlock:(KSAlertGifEndBlock)block;

/// 单文字遮罩
/// @param showText 显示文本
/// @param time 显示时间
/// @param block 结束block
-(instancetype)initWithText:(NSString *)showText showTime:(int)time endBlock:(KSAlertGifEndBlock)block;

/// 列表选择---单选
/// @param list 数组
/// @param cancel 取消
/// @param other 确定
/// @param block 点击block
-(instancetype)initWithArratList:(NSMutableArray *)list cancelBtn:(NSString *)cancel otherBtn:(NSString *)other clickBlock:(KSAlertClickIndexBlock)block;

/// 列表选择---多选
/// @param list 数组
/// @param cancel 取消
/// @param other 确定
/// @param arrblock 数组block
-(instancetype)initWithArratList:(NSMutableArray *)list cancelBtn:(NSString *)cancel otherBtn:(NSString *)other clickArrBlock:(KSAlertClickArrBlock)arrblock;

/// 显示弹框
-(void)show;

/// 移除弹框
-(void)diss;

/// 设置单选和多选图片
/// @param select 选中图片
/// @param unsel 未选中图片
-(void)setSelectImage:(NSString *)select unSelectImage:(NSString *)unsel;

@end
