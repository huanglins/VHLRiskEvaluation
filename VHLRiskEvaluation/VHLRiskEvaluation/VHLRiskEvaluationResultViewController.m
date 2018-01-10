//
//  VHLRiskEvaluationResultViewController.m
//  VHLRiskEvaluation
//
//  Created by Vincent on 2018/1/10.
//  Copyright © 2018年 Darnel Studio. All rights reserved.
//

#import "VHLRiskEvaluationResultViewController.h"
#import "UIView+VHLAdd.h"

@interface VHLRiskEvaluationResultViewController ()

@property (nonatomic, assign) int score;                    // 风险评测得分

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIButton *goRiskButton;
@property (nonatomic, strong) UIButton *finishRiskButton;

@end

@implementation VHLRiskEvaluationResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"风险测评";
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //
    self.topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"risk_start_top_info"]];
    [self.view addSubview:self.topImageView];
    self.topImageView.centerX = self.view.centerX;
    self.topImageView.top = 50;
    // 得分
    self.scoreLabel = [[UILabel alloc] init];
    self.scoreLabel.font = [UIFont systemFontOfSize:20];
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel.textColor = [UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1.00];
    [self.view addSubview:self.scoreLabel];
    self.scoreLabel.left = 0;
    self.scoreLabel.top = self.topImageView.bottom + 30;
    self.scoreLabel.width = self.view.width;
    
    if (self.score > 0) {
        self.scoreLabel.text = [NSString stringWithFormat:@"-   %d分   -", self.score];
        self.scoreLabel.height = 18;
    } else {
        self.scoreLabel.height = 0;
    }
    //
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1.00];
    self.titleLabel.text = @"温馨提示";
    [self.view addSubview:self.titleLabel];
    self.titleLabel.left = 0;
    self.titleLabel.top = self.scoreLabel.bottom + 20;
    self.titleLabel.width = self.view.width;
    self.titleLabel.height = 18;
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = @"尊敬的客户，欢迎您参加本次自我风险测评，您的测评结果将有助于您了解自己的风险承受能力，更好的在平联贷平台上进行投融资活动。您在此问卷上所填的个人资料本平台将予以保密。";
    [self.view addSubview:self.contentLabel];
    CGSize contentSize = [self.contentLabel sizeThatFits:CGSizeMake(self.view.width * 0.8, CGFLOAT_MAX)];
    self.contentLabel.size = contentSize;
    self.contentLabel.centerX = self.view.centerX;
    self.contentLabel.top = self.titleLabel.bottom + 20;
    // 按钮
    self.finishRiskButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.85, 48)];
    [self.finishRiskButton setBackgroundColor:[UIColor whiteColor]];
    [self.finishRiskButton setTitle:@"重新测评" forState:UIControlStateNormal];
    [self.finishRiskButton setTitleColor:[UIColor colorWithRed:0.42 green:0.78 blue:0.93 alpha:1.00] forState:UIControlStateNormal];
    [self.finishRiskButton setTitleColor:[UIColor colorWithRed:0.42 green:0.78 blue:0.93 alpha:0.5] forState:UIControlStateHighlighted];
    [self.view addSubview:self.finishRiskButton];
    self.finishRiskButton.layer.cornerRadius = 24;
    self.finishRiskButton.layer.borderWidth = 1;
    self.finishRiskButton.layer.borderColor = [UIColor colorWithRed:0.42 green:0.78 blue:0.93 alpha:1.00].CGColor;
    self.finishRiskButton.layer.masksToBounds = YES;
    
    self.goRiskButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.85, 48)];
    [self.goRiskButton setBackgroundColor:[UIColor colorWithRed:0.42 green:0.78 blue:0.93 alpha:1.00]];
    [self.goRiskButton setTitle:@"开始测评" forState:UIControlStateNormal];
    [self.goRiskButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.goRiskButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    [self.view addSubview:self.goRiskButton];
    self.goRiskButton.layer.cornerRadius = 24;
    self.goRiskButton.layer.masksToBounds = YES;
    // 添加事件
    [self.finishRiskButton addTarget:self action:@selector(goRiskClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.goRiskButton addTarget:self action:@selector(goRiskClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //
    [self changeViewValue];
}
/** */
- (void)goRiskClick:(UIButton *)button {
    NSString *title = button.titleLabel.text;
    if ([title isEqualToString:@"开始测评"] || [title isEqualToString:@"重新测评"]) {
        if ([self.delegate respondsToSelector:@selector(restartRiskEvaluation:vc:)]) {
            __weak typeof(self) weakSelf = self;
            [self.delegate restartRiskEvaluation:self.questionArray vc:weakSelf];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
// ------------------------------------------------------------
- (void)changeViewValue {
    if (!self.topImageView || !self.titleLabel) {
        return;
    }
    //
    if (self.score > 0) {
        self.finishRiskButton.hidden = NO;
        
        self.finishRiskButton.size = CGSizeMake((self.view.width - 60) / 2, 48);
        self.finishRiskButton.left = 15;
        self.finishRiskButton.top = self.contentLabel.bottom + 24;

        self.goRiskButton.size = CGSizeMake((self.view.width - 60) / 2, 48);
        self.goRiskButton.right = self.view.right - 15;
        self.goRiskButton.top = self.contentLabel.bottom + 24;
        
        [self.goRiskButton setTitle:@"完成测评" forState:UIControlStateNormal];
    } else {
        self.finishRiskButton.hidden = YES;
        
        self.goRiskButton.size = CGSizeMake(self.view.width * 0.85, 48);
        self.goRiskButton.centerX = self.view.centerX;
        self.goRiskButton.top = self.contentLabel.bottom + 24;
    }
    if (_score > 8 && _score <= 14) {             // 保守型
        self.topImageView.image = [UIImage imageNamed:@"risk_result_top_1"];
        self.titleLabel.text = @"您属于保守型投资者";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
        NSRange itemRange = [self.titleLabel.text rangeOfString:[NSString stringWithFormat:@"保守型"]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.51 green:0.85 blue:0.31 alpha:1.00] range:itemRange];
        self.titleLabel.attributedText = attributedString;
        
        self.contentLabel.text = @"您具有较低的风险承受能力，您对风险总是存在的道理有清楚的认识，您愿意在风险较小的情况下，进行一些能够获得相对稳定收益的投资。您不适合选择预期收益率奇高的P2P融资标的。";
    } else if (_score > 15 && _score <= 27) {     // 稳健性
        self.topImageView.image = [UIImage imageNamed:@"risk_result_top_2"];
        self.titleLabel.text = @"您属于稳健型投资者";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
        NSRange itemRange = [self.titleLabel.text rangeOfString:[NSString stringWithFormat:@"稳健型"]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.31 green:0.65 blue:0.95 alpha:1.00] range:itemRange];
        self.titleLabel.attributedText = attributedString;
        
        self.contentLabel.text = @"您的风险承受能力一般，对风险与收益之间的正比关系有清楚认识。您愿意进行一些预期收益率略高的投资，并为此承担略高于市场平均水平的风险，您适合选择预期收益率适中且信誉良好。";
    } else if (_score > 27) {
        self.topImageView.image = [UIImage imageNamed:@"risk_result_top_3"];
        self.titleLabel.text = @"您属于积极型投资者";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
        NSRange itemRange = [self.titleLabel.text rangeOfString:[NSString stringWithFormat:@"积极型"]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.94 green:0.58 blue:0.22 alpha:1.00] range:itemRange];
        self.titleLabel.attributedText = attributedString;
        
        self.contentLabel.text = @"您具有较高的风险承受能力，对高风险对应高收益的道理有清楚的认识。对预期收益率较高的投资更感兴趣，并愿意为此承担较大的风险。";
    }
}

/** 当前风险测试得分*/
- (void)setScore:(int)score {
    _score = score;
    [self changeViewValue];
}

@end
