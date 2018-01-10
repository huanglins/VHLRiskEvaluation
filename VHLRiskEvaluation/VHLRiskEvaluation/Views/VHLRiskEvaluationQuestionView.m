//
//  VHLRiskEvaluationQuestionView.m
//  VHLRiskEvaluation
//
//  Created by Vincent on 2018/1/10.
//  Copyright © 2018年 Darnel Studio. All rights reserved.
//

#import "VHLRiskEvaluationQuestionView.h"
#import "UIView+VHLAdd.h"
//
#import "VHLRiskAnswerCell.h"

@interface VHLRiskEvaluationQuestionView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *answerTableView;

@property (nonatomic, strong) UIButton *upButton;           // 上一题
@property (nonatomic, strong) UIButton *nextButton;         // 下一题

@end

@implementation VHLRiskEvaluationQuestionView

- (instancetype)initWithFrame:(CGRect)frame questionModel:(VHLRiskEvaluationModel *)questionModel {
    if (self = [super initWithFrame:frame]) {
        self.questionModel = questionModel;
        
        self.backgroundColor = [UIColor whiteColor];
        // 设置圆角,阴影
        [self addShadowToView:self withOpacity:0.8 shadowRadius:3 andCornerRadius:8];
        [self initViews];
    }
    return self;
}
/** */
- (void)initViews {
    // 标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor colorWithRed:0.20 green:0.27 blue:0.42 alpha:1.00];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.text = self.questionModel.question;
    [self addSubview:self.titleLabel];
    CGSize contentSize = [self.titleLabel sizeThatFits:CGSizeMake(self.width - 40, CGFLOAT_MAX)];
    self.titleLabel.size = contentSize;
    self.titleLabel.left = 20;
    self.titleLabel.top = 16;
    
    // 分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(12, self.titleLabel.bottom + 16, self.width - 24, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
    [self addSubview:lineView];
    // 答案选项
    self.answerTableView = [[UITableView alloc] initWithFrame:CGRectMake(12, lineView.bottom, self.width - 24, self.height - lineView.bottom - 60)];
    self.answerTableView.separatorColor = [UIColor whiteColor];
    self.answerTableView.separatorInset = UIEdgeInsetsZero;
    //self.answerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.answerTableView.showsVerticalScrollIndicator = NO;
    self.answerTableView.dataSource = self;
    self.answerTableView.delegate = self;
    self.answerTableView.tableFooterView = [UIView new];
    [self addSubview:self.answerTableView];
    
    // 分割线2
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(12, self.answerTableView.bottom, self.width - 24, 0.5)];
    lineView1.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
    [self addSubview:lineView1];
    
    // 上一题，下一题
    self.upButton = [[UIButton alloc] initWithFrame:CGRectMake(20, lineView1.bottom, 60, 60)];
    [self.upButton setTitleColor:[UIColor colorWithRed:0.20 green:0.27 blue:0.42 alpha:1.00] forState:UIControlStateNormal];
    [self.upButton setTitleColor:[UIColor colorWithRed:0.20 green:0.27 blue:0.42 alpha:0.8] forState:UIControlStateHighlighted];
    self.upButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.upButton setTitle:@"上一题" forState:UIControlStateNormal];
    [self addSubview:self.upButton];
    
    self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(20, lineView1.bottom, 60, 60)];
    [self.nextButton setTitleColor:[UIColor colorWithRed:0.20 green:0.27 blue:0.42 alpha:1.00] forState:UIControlStateNormal];
    [self.nextButton setTitleColor:[UIColor colorWithRed:0.20 green:0.27 blue:0.42 alpha:0.5] forState:UIControlStateHighlighted];
    [self.nextButton setTitleColor:[UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1.00] forState:UIControlStateDisabled];
    self.nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.nextButton setTitle:@"下一题" forState:UIControlStateNormal];
    
    [self addSubview:self.nextButton];
    self.nextButton.right = self.width - 20;
    // 点击事件
    [self.upButton addTarget:self action:@selector(upButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //
    if (self.questionModel.index <= 1) {
        self.upButton.hidden = YES;
    }
    [self refreshRightButtonStatus];        // 下一题按钮状态
}
- (void)refreshRightButtonStatus {
    self.nextButton.enabled = NO;
    for (int i = 0; i < self.questionModel.answers.count; i++) {
        VHLRiskEvaluationAnswerModel *model = self.questionModel.answers[i];
        if (model.isSelected) {
            self.nextButton.enabled = YES;
            break;
        }
    }
}
- (void)upButtonClick {
    if ([self.delegate respondsToSelector:@selector(upQuestionClick:cIndex:)]) {
        [self.delegate upQuestionClick:self.questionModel cIndex:self.index];
    }
}
- (void)nextButtonClick {
    if ([self.delegate respondsToSelector:@selector(nextQuestionClick:cIndex:)]) {
        [self.delegate nextQuestionClick:self.questionModel cIndex:self.index];
    }
}
#pragma mark - setter
- (void)setIsLast:(BOOL)isLast {
    _isLast = isLast;
    if (self.isLast) {
        [self.nextButton setTitle:@"完成" forState:UIControlStateNormal];
    } else {
        [self.nextButton setTitle:@"下一题" forState:UIControlStateNormal];
    }
}
#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questionModel.answers.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"answerCell";
    VHLRiskAnswerCell *answerCell = (VHLRiskAnswerCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!answerCell) {
        answerCell = [[VHLRiskAnswerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier    ];
    }
    VHLRiskEvaluationAnswerModel *answerModel = self.questionModel.answers[indexPath.row];
    answerCell.answerModel = answerModel;
    
    return answerCell;
}
#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取当前已选中数量
    int currentSelectCount = 0;
    for (int i = 0; i < self.questionModel.answers.count; i++) {
        VHLRiskEvaluationAnswerModel *answerModel = self.questionModel.answers[i];
        if (answerModel.isSelected) {
            currentSelectCount ++;
        }
    }
    VHLRiskEvaluationAnswerModel *answerModel = self.questionModel.answers[indexPath.row];
    if (answerModel.isSelected || self.questionModel.maxSelectCount > currentSelectCount) {
        answerModel.isSelected = !answerModel.isSelected;
        self.questionModel.answers[indexPath.row] = answerModel;
    } else if (self.questionModel.maxSelectCount <= currentSelectCount && self.questionModel.maxSelectCount > 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"最多可选%d项", self.questionModel.maxSelectCount] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    } else {            // 单选下，选择切换
        for (int i = 0; i < self.questionModel.answers.count; i++) {
            VHLRiskEvaluationAnswerModel *answerModel = self.questionModel.answers[i];
            if (i == indexPath.row) {
                answerModel.isSelected = !answerModel.isSelected;
            } else {
                if (self.questionModel.maxSelectCount <= currentSelectCount) {
                    answerModel.isSelected = NO;
                }
            }
            self.questionModel.answers[i] = answerModel;
        }
    }
    // delegate
    if ([self.delegate respondsToSelector:@selector(updateQuestion:cIndex:)]) {
        [self.delegate updateQuestion:self.questionModel cIndex:self.index];
    }
    [self refreshRightButtonStatus];
    [tableView reloadData];
}
// ------------------------------------------------------------------------------------
/*
 周边加阴影，并且同时圆角
 */
- (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
        andCornerRadius:(CGFloat)cornerRadius {
    //////// shadow /////////
    CALayer *shadowLayer = [CALayer layer];
    shadowLayer.frame = view.layer.frame;
    
    shadowLayer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    shadowLayer.shadowOffset = CGSizeMake(0, 0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    shadowLayer.shadowOpacity = shadowOpacity;//0.8;//阴影透明度，默认0
    shadowLayer.shadowRadius = shadowRadius;//8;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = shadowLayer.bounds.size.width;
    float height = shadowLayer.bounds.size.height;
    float x = shadowLayer.bounds.origin.x;
    float y = shadowLayer.bounds.origin.y;
    
    CGPoint topLeft      = shadowLayer.bounds.origin;
    CGPoint topRight     = CGPointMake(x + width, y);
    CGPoint bottomRight  = CGPointMake(x + width, y + height);
    CGPoint bottomLeft   = CGPointMake(x, y + height);
    
    CGFloat offset = -2.f;
    [path moveToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    [path addArcWithCenter:CGPointMake(topLeft.x + cornerRadius, topLeft.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    [path addLineToPoint:CGPointMake(topRight.x - cornerRadius, topRight.y - offset)];
    [path addArcWithCenter:CGPointMake(topRight.x - cornerRadius, topRight.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 * 3 endAngle:M_PI * 2 clockwise:YES];
    [path addLineToPoint:CGPointMake(bottomRight.x + offset, bottomRight.y - cornerRadius)];
    [path addArcWithCenter:CGPointMake(bottomRight.x - cornerRadius, bottomRight.y - cornerRadius) radius:(cornerRadius + offset) startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y + offset)];
    [path addArcWithCenter:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y - cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    
    //设置阴影路径
    shadowLayer.shadowPath = path.CGPath;
    
    //////// cornerRadius /////////
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
    view.layer.shouldRasterize = YES;
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [view.superview.layer insertSublayer:shadowLayer below:view.layer];
}

@end
