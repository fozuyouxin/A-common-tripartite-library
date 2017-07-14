概述
----------------

* 本工程主要是利用iOS 的Objective-C开发的技术要点汇总；
* 涵盖了开发中踩坑的原因，以及填坑的技术分享；
* 抛砖引玉，取长补短，希望能够提供一点思路，避免少走一些弯路。

要求
----------------

* iOS 8+
* Xcode 8.0+

期待
----------------

* 如果在使用过程中遇到BUG，希望你能[Issues](https://github.com/NSLog-YuHaitao/iOSReview/issues)我，谢谢(或者尝试下载最新的代码看看BUG修复没有)。
* 如果在使用过程中发现有更好或更巧妙的实用技术，希望你能[Issues](https://github.com/NSLog-YuHaitao/iOSReview/issues)我，我非常为该项目扩充更多好用的技术，谢谢。
* 如果通过该工程的使用，对您在开发中有一点帮助，码字不易，还请点击右上角star按钮，谢谢。

主要实现:
----------------
* 2017年7月7日更新内容:
* 网路视频的播放;
* UITableViewCell滚动动画加载;
* UIView阴影加圆角功能;
* 本地视频第一帧图片的预加载;
* 制作领取会员卡的页面;
* 导航栏按钮的使用及其功能的实现;
* UIButton背景色实时更改;
* App清理缓存功能;
* UILable部分文字更改颜色等功能;
* 2017.7.11 增加三方库Masonry功能;

~~~
    UIView *superview = self.view;
    superview.backgroundColor = [UIColor orangeColor];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor greenColor];
    [superview addSubview:view1];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(74, 10, 10, 10);
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(padding.top);
        make.left.equalTo(superview.mas_left).with.offset(padding.left);
        make.bottom.equalTo(superview.mas_bottom).with.offset(-padding.bottom);
        make.right.equalTo(superview.mas_right).with.offset(-padding.right);
    }];
    
    UIEdgeInsets padding1 = UIEdgeInsetsMake(84, 20, 20, 20);
    UIView * view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor yellowColor];
    [superview addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview).with.insets(padding1);
    }];
    
    self.btn = [[UIButton alloc]init];
    _btn.backgroundColor = [UIColor redColor];
    [view2 addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2.mas_top);//上
        make.left.mas_equalTo(view2.mas_left);//左
        make.width.mas_equalTo(@100);//宽
        make.height.mas_equalTo(@50);//高
    }];
    
    
    UIButton * btn1 = [[UIButton alloc]init];
    [view2 addSubview:btn1];
    btn1.backgroundColor = [UIColor blueColor];
    UIButton * btn2 = [[UIButton alloc]init];
    [view2 addSubview:btn2];
    btn2.backgroundColor = [UIColor darkGrayColor];
    
    int padding_t = 10;
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2).offset(padding_t);
        make.centerY.equalTo(view2);
        make.height.equalTo(@150);
        make.width.mas_equalTo(100);
        make.right.equalTo(btn2.mas_left).with.offset(-padding_t);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view2).offset(-padding_t);
        make.centerY.equalTo(view2);
        make.height.equalTo(@150);
        make.width.mas_equalTo(btn1);
    }];
    
    UIButton * btn3 = [[UIButton alloc]init];
    btn3.backgroundColor = [UIColor cyanColor];
    [view2 addSubview:btn3];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.mas_bottom).offset(10);
        make.centerX.equalTo(btn1);
        make.width.equalTo(btn1);
        make.height.equalTo(btn1);
    }];
    
    UIButton * btn4 = [[UIButton alloc]init];
    btn4.backgroundColor = [UIColor purpleColor];
    [view2 addSubview:btn4];
    
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view2);
        make.bottom.equalTo(btn1.mas_top).offset(-10);
        make.width.equalTo(btn1);
        make.height.equalTo(btn1);
    }];
~~~

* 2017.7.12 增加MJRefresh,实现刷新功能,下拉功能以文字和动画两种形式进行显示;</br>
<img width="250" height="400" src="/donghua.gif" />

* 2017.7.13 增加MJExtension和IQKeyboardManager;</br>
<img width="250" height="400" src="/IQKeyboardManager.png" />

* 2017.7.14 增加指纹解锁功能;</br>
<div>
<img width="250" height="400" src="/3.png" />
<img width="250" height="400" src="/2.png" />
<img width="250" height="400" src="/1.png" />
</div>

* 功能持续更新中...

实现功能效果图:
----------------

<img width="250" height="400" src="/result.gif" />

