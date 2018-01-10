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

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *goRiskButton;

@end

@implementation VHLRiskEvaluationResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"风险评测";
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //
    self.topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"risk_start_top_info"]];
    [self.view addSubview:self.topImageView];
    self.topImageView.centerX = self.view.centerX;
    self.topImageView.top = 50;
    //
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1.00];
    self.titleLabel.text = @"温馨提示";
    [self.view addSubview:self.titleLabel];
    self.titleLabel.left = 0;
    self.titleLabel.top = self.topImageView.bottom + 30;
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
    
    self.goRiskButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.85, 65)];
    [self.goRiskButton setBackgroundImage:[UIImage imageNamed:@"risk_start_button_bg"] forState:UIControlStateNormal];
    [self.goRiskButton setBackgroundImage:[UIImage imageNamed:@"risk_start_button_bg"] forState:UIControlStateHighlighted];
    [self.goRiskButton setTitle:@"开始测评" forState:UIControlStateNormal];
    [self.goRiskButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.goRiskButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    [self.view addSubview:self.goRiskButton];
    self.goRiskButton.centerX = self.view.centerX;
    self.goRiskButton.top = self.contentLabel.bottom + 20;
    
    [self.goRiskButton addTarget:self action:@selector(goRiskClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goRiskClick {
    
}


@end
