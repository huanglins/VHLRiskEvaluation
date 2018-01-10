//
//  VHLRiskEvaluationStepView.m
//  VHLRiskEvaluation
//
//  Created by Vincent on 2018/1/9.
//  Copyright © 2018年 Darnel Studio. All rights reserved.
//

#import "VHLRiskEvaluationTopStepView.h"
#import "UIView+VHLAdd.h"

@implementation VHLRiskEvaluationTopStepView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 30, 18)];
        self.leftLabel.font = [UIFont boldSystemFontOfSize:18];
        self.leftLabel.textColor = [UIColor colorWithRed:0.20 green:0.27 blue:0.42 alpha:1.00];
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
        self.leftLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.leftLabel];
        self.leftLabel.centerY = self.centerY;
        
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 40, 20, 30, 18)];
        self.rightLabel.font = [UIFont boldSystemFontOfSize:18];
        self.rightLabel.textColor = [UIColor colorWithRed:0.20 green:0.27 blue:0.42 alpha:1.00];
        self.rightLabel.textAlignment = NSTextAlignmentCenter;
        self.rightLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.rightLabel];
        self.rightLabel.centerY = self.centerY;
        
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, 280, 4)];
        self.progressView.tintColor = [UIColor whiteColor];
        self.progressView.trackTintColor = [UIColor whiteColor];
        self.progressView.progressTintColor = [UIColor colorWithRed:0.20 green:0.27 blue:0.42 alpha:1.00];
        self.progressView.layer.cornerRadius = 4;
        self.progressView.layer.masksToBounds = YES;
        self.progressView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        self.progressView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.progressView.layer.shadowOpacity = 1;//阴影透明度，默认0
        self.progressView.layer.shadowRadius = 4;//阴影半径，默认3
        [self addSubview:self.progressView];
        self.progressView.width = self.width * 0.72;
        self.progressView.center = self.center;
        //
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
        self.progressView.transform = transform;
        
        self.leftLabel.right = self.progressView.left - 10;
        self.rightLabel.left = self.progressView.right + 10;
        
        // test value
        self.leftLabel.text = @"0";
        self.rightLabel.text = @"1";
        self.progressView.progress = 0.0;
    }
    return self;
}
// 
- (void)setLeftValue:(NSString *)leftValue rightValue:(NSString *)rightValue progress:(CGFloat)progressValue pAnimation:(BOOL)isAnimation {
    self.leftLabel.text = leftValue;
    self.rightLabel.text = rightValue;
    [self.progressView setProgress:progressValue animated:isAnimation];
}

@end
