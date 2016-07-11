//
//  ViewController.m
//  CALayerAnimationLoadingIndicator
//
//  Created by Cantoraz Chou on 7/11/16.
//
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIView* loadingView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Initialize ovalShapeLayer for loadingView
    CAShapeLayer* ovalShapeLayer = [[CAShapeLayer alloc] init];
    ovalShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    ovalShapeLayer.lineWidth = 7;
    
    CGFloat ovalRadius = _loadingView.frame.size.height/2 * 0.8;
    CGRect ovalRect = CGRectMake(_loadingView.frame.size.width/2 - ovalRadius,
                                 _loadingView.frame.size.height/2 - ovalRadius,
                                 2*ovalRadius, 2*ovalRadius);
    ovalShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:ovalRect].CGPath;
    ovalShapeLayer.strokeEnd = 0.4;
    ovalShapeLayer.lineCap = kCALineCapRound;
    
    [_loadingView.layer addSublayer:ovalShapeLayer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self __caz__beginSimpleAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)__caz__beginSimpleAnimation
{
    CABasicAnimation* rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.duration = 1.5;
    rotate.fromValue = @0;
    rotate.toValue = @(2 * M_PI);
    rotate.repeatCount = HUGE;
    [_loadingView.layer addAnimation:rotate forKey:nil];
}

@end
