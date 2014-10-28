//
//  PNBarChart.m
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PNBarChart.h"
#import "PNColor.h"
#import "PNChartLabel.h"


@interface PNBarChart () {
    NSMutableArray *_labels;
}
@property (nonatomic)UIScrollView *contentScrollView;

//=====================YF custom
@property (nonatomic) CAShapeLayer *chartLineLayer;  // Array[CAShapeLayer]
@property (nonatomic) CAShapeLayer *chartPointLayer; // Array[CAShapeLayer] save the point layer

@property (nonatomic) NSMutableArray *chartPath;       // Array of line path, one for each line.
@property (nonatomic) NSMutableArray *pointPath;       // Array of point path, one for each line
//=====================YF custom

- (UIColor *)barColorAtIndex:(NSUInteger)index;

@end

@implementation PNBarChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds   = YES;
        _showLabel           = YES;
        _showLine            = NO;
        _barBackgroundColor  = PNLightGrey;
        _labelTextColor      = [UIColor grayColor];
        _labelFont           = [UIFont systemFontOfSize:11.0f];
        _labels              = [NSMutableArray array];
        _bars                = [NSMutableArray array];
        _xLabelSkip          = 1;
        _yLabelSum           = 6;
        _labelMarginTop      = 0;
        _chartMargin         = 15.0;
        _barRadius           = 2.0;
        _yChartLabelWidth    = 30;
        _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.frame.origin.x+_yChartLabelWidth, 0, 320-_yChartLabelWidth, self.frame.size.height)];
        [_contentScrollView setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        [_contentScrollView setShowsHorizontalScrollIndicator:NO];
        [self addSubview:_contentScrollView];
    }

    return self;
}


- (void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    
    if (_yMaxValue) {
        _yValueMax = _yMaxValue;
    }else{
        [self getYValueMax:yValues];
    }
    

    _xLabelWidth = (self.frame.size.width - _chartMargin * 2) / [_yValues count];
}

- (void)getYValueMax:(NSArray *)yLabels
{
    int max = [[yLabels valueForKeyPath:@"@max.intValue"] intValue];
    
    _yValueMax = (int)max * 1.1;
    
    if (_yValueMax == 0) {
        _yValueMax = _yMinValue;
    }
}


- (void)setYLabels:(NSArray *)yLabels
{
    
}


- (void)setXLabels:(NSArray *)xLabels
{
    _xLabels = xLabels;

    if (_showLabel) {
        _xLabelWidth = (self.frame.size.width - _chartMargin * 2) / [xLabels count];
    }
}

//=====================YF custom
- (void)setLineValues:(NSArray *)lineValues
{
    _lineValues = lineValues;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:_yValues];
    [array addObjectsFromArray:_lineValues];
    
    if (_yMaxValue) {
        _yValueMax = _yMaxValue;
    }else{
        [self getYValueMax:array];
    }
}
//=====================YF custom


- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
}


- (void)strokeChart
{
    [self viewCleanupForCollection:_labels];
    //Add Labels
    if (_showLabel) {
        //Add x labels
        int labelAddCount = 0;
        for (int index = 0; index < _xLabels.count; index++) {
            labelAddCount += 1;
            
            if (labelAddCount == _xLabelSkip) {
                NSString *labelText = _xLabels[index];
                PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectZero];
                label.font = _labelFont;
                label.textColor = _labelTextColor;
                [label setTextAlignment:NSTextAlignmentCenter];
                label.text = labelText;
                [label sizeToFit];
                CGFloat labelXPosition  = (index *  _xLabelWidth + _xLabelWidth /2.0 );
                
                label.center = CGPointMake(labelXPosition,
                                           self.frame.size.height - xLabelHeight - _chartMargin + label.frame.size.height /2.0 + _labelMarginTop);
                labelAddCount = 0;
                
                [_labels addObject:label];
                [_contentScrollView addSubview:label];
            }
        }
        
        //Add y labels
        
        float yLabelSectionHeight = (self.frame.size.height - _chartMargin * 2 - xLabelHeight) / _yLabelSum;
        
        for (int index = 0; index < _yLabelSum; index++) {

            NSString *labelText = _yLabelFormatter((float)_yValueMax * ( (_yLabelSum - index) / (float)_yLabelSum ));
            
            PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectMake(0,
                                                                                  yLabelSectionHeight * index + _chartMargin - yLabelHeight/2.0,
                                                                                  _yChartLabelWidth,
                                                                                  yLabelHeight)];
            label.font = _labelFont;
            label.textColor = _labelTextColor;
            [label setTextAlignment:NSTextAlignmentRight];
            label.text = labelText;

            [_labels addObject:label];
            [self addSubview:label];

        }
    }
    

    [self viewCleanupForCollection:_bars];
    
    
    //Add bars
    CGFloat chartCavanHeight = self.frame.size.height - _chartMargin * 2 - xLabelHeight;
    NSInteger index = 0;

    for (NSNumber *valueString in _yValues) {
        float value = [valueString floatValue];

        float grade = (float)value / (float)_yValueMax;
        
        if (isnan(grade)) {
            grade = 0;
        }
        
        PNBar *bar;
        CGFloat barWidth;
        CGFloat barXPosition;
        
        if (_barWidth) {
            barWidth = _barWidth;
            barXPosition = index *  _xLabelWidth + _xLabelWidth /2.0 - _barWidth /2.0;
        }else{
            barXPosition = index *  _xLabelWidth + _xLabelWidth * 0.25;
            if (_showLabel) {
                barWidth = _xLabelWidth * 0.5;
                
            }
            else {
                barWidth = _xLabelWidth * 0.6;
                
            }
        }
        
        bar = [[PNBar alloc] initWithFrame:CGRectMake(barXPosition, //Bar X position
                                                      self.frame.size.height - chartCavanHeight - xLabelHeight - _chartMargin, //Bar Y position
                                                      barWidth, // Bar witdh
                                                      chartCavanHeight)]; //Bar height
        
        //Change Bar Radius
        bar.barRadius = _barRadius;
        
        //Change Bar Background color
        bar.backgroundColor = _barBackgroundColor;
        
        //Bar StrokColor First
        if (self.strokeColor) {
            bar.barColor = self.strokeColor;
        }else{
            bar.barColor = [self barColorAtIndex:index];
        }
        
        //Height Of Bar
        bar.grade = grade;
        
        // Add gradient
        bar.barColorGradientStart = _barColorGradientStart;
        

        //For Click Index
        bar.tag = index;
        
        
        [_bars addObject:bar];
        [_contentScrollView addSubview:bar];

        index += 1;
    }
    
    //=====================YF custom
    if (_showLine) {
        NSMutableArray *yLabelsArray = [NSMutableArray arrayWithCapacity:_yValues.count];
        CGFloat yMax = 0.0f;
        CGFloat yMin = MAXFLOAT;
        CGFloat yValue;
        
        // remove all shape layers before adding new ones
        
        [_chartLineLayer removeFromSuperlayer];
        [_chartPointLayer removeFromSuperlayer];
        
        
        // set for point stoken
        // create as many chart line layers as there are data-lines
        CAShapeLayer *chartLine = [CAShapeLayer layer];
        chartLine.lineCap       = kCALineCapButt;
        chartLine.lineJoin      = kCALineJoinMiter;
        chartLine.fillColor     = [[UIColor whiteColor] CGColor];
        chartLine.lineWidth     = 2.f;
        chartLine.strokeEnd     = 0.0;
        [_contentScrollView.layer addSublayer:chartLine];
        _chartLineLayer = chartLine;
        
        // create point
        CAShapeLayer *pointLayer = [CAShapeLayer layer];
        pointLayer.strokeColor   = [TextLightGray CGColor];
        pointLayer.lineCap       = kCALineCapRound;
        pointLayer.lineJoin      = kCALineJoinBevel;
        pointLayer.fillColor     = nil;
        pointLayer.lineWidth     = 2.f;
        [_contentScrollView.layer addSublayer:pointLayer];
        _chartPointLayer = pointLayer;
        
        for (NSUInteger i = 0; i < _yValues.count; i++) {
            yValue = [[_yValues objectAtIndex:i]floatValue];
            [yLabelsArray addObject:[NSString stringWithFormat:@"%2f", yValue]];
            yMax = fmaxf(yMax, yValue);
            yMin = fminf(yMin, yValue);
        }
        
        [self setNeedsDisplay];
    }
    
    //add lines
    if (_showLine) {
        _chartPath = [[NSMutableArray alloc] init];
        _pointPath = [[NSMutableArray alloc] init];
        
        CAShapeLayer *chartLine = _chartLineLayer;
        CAShapeLayer *pointLayer = _chartPointLayer;
        
        float yValue;
        float innerGrade;
        CGFloat chartCavanHeight = self.frame.size.height - _chartMargin * 2 - xLabelHeight;
        
        UIGraphicsBeginImageContext(self.frame.size);
        
        CGFloat lineWidth = 2.f;
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        [progressline setLineWidth:lineWidth];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        
        UIBezierPath *pointPath = [UIBezierPath bezierPath];
        [pointPath setLineWidth:lineWidth];
        
        [_chartPath addObject:progressline];
        [_pointPath addObject:pointPath];
        
        NSMutableArray *linePointsArray = [[NSMutableArray alloc] init];
        
        int last_x = 0;
        int last_y = 0;
        CGFloat inflexionWidth = 6.0f;
        
        for (NSUInteger i = 0; i < _lineValues.count; i++) {
            
            yValue = [[_lineValues objectAtIndex:i] floatValue];
            innerGrade = (float)yValue / (float)_yValueMax;
            if (isnan(innerGrade)) {
                innerGrade = 0;
            }
            
            CGFloat barXPosition;
            if (_barWidth) {
                barXPosition = i *  _xLabelWidth + _xLabelWidth /2.0;
            }else{
                barXPosition = i *  _xLabelWidth + _xLabelWidth * 0.5;
            }
            
            int x = barXPosition;
            int y = chartCavanHeight - (innerGrade * chartCavanHeight) + yLabelHeight*1.5;
            
            // cycle style point
            CGRect circleRect = CGRectMake(x - inflexionWidth / 2, y - inflexionWidth / 2, inflexionWidth, inflexionWidth);
            CGPoint circleCenter = CGPointMake(circleRect.origin.x + (circleRect.size.width / 2), circleRect.origin.y + (circleRect.size.height / 2));
            
            [pointPath moveToPoint:CGPointMake(circleCenter.x + (inflexionWidth / 2), circleCenter.y)];
            [pointPath addArcWithCenter:circleCenter radius:inflexionWidth / 2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
            
            if ( i != 0 ) {
                
                // calculate the point for line
                float distance = sqrt(pow(x - last_x, 2) + pow(y - last_y, 2) );
                float last_x1 = last_x + (inflexionWidth / 2) / distance * (x - last_x);
                float last_y1 = last_y + (inflexionWidth / 2) / distance * (y - last_y);
                float x1 = x - (inflexionWidth / 2) / distance * (x - last_x);
                float y1 = y - (inflexionWidth / 2) / distance * (y - last_y);
                
                [progressline moveToPoint:CGPointMake(last_x1, last_y1)];
                [progressline addLineToPoint:CGPointMake(x1, y1)];
            }
            
            last_x = x;
            last_y = y;
            
            [linePointsArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        }
        
        // setup the color of the chart line
        chartLine.strokeColor = [TextLightGray CGColor];
        pointLayer.strokeColor = [TextLightGray CGColor];
        
        [progressline stroke];
        
        chartLine.path = progressline.CGPath;
        pointLayer.path = pointPath.CGPath;
        
        [CATransaction begin];
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 1.0;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = @0.0f;
        pathAnimation.toValue   = @1.0f;
        
        [chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        chartLine.strokeEnd = 1.0;
        
        // if you want cancel the point animation, conment this code, the point will show immediately
        [pointLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        [CATransaction setCompletionBlock:^{
            // pointLayer.strokeEnd = 1.0f; // stroken point when animation end
        }];
        [CATransaction commit];
        
        UIGraphicsEndImageContext();
    }
    //=====================YF custom
}


- (void)viewCleanupForCollection:(NSMutableArray *)array
{
    if (array.count) {
        [array makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [array removeAllObjects];
    }
}


#pragma mark - Class extension methods

- (UIColor *)barColorAtIndex:(NSUInteger)index
{
    if ([self.strokeColors count] == [self.yValues count]) {
        return self.strokeColors[index];
    }
    else {
        return self.strokeColor;
    }
}


@end
