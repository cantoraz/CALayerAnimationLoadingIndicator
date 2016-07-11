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
@property (nonatomic, weak) IBOutlet UIView* complexLoadingView;

@property (nonatomic, strong) CAShapeLayer* anotherOvalShapeLayer;
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
    
    // Initialize ovalShapeLayer for complexLoadingView
    _anotherOvalShapeLayer = [[CAShapeLayer alloc] init];
    _anotherOvalShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    _anotherOvalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    _anotherOvalShapeLayer.lineWidth = 7;
    
    CGFloat anotherOvalRadius = _complexLoadingView.bounds.size.height/2 * .8;
    CGRect anotherOvalRect = CGRectMake(_complexLoadingView.bounds.size.width/2 - anotherOvalRadius,
                                        _complexLoadingView.bounds.size.height/2 - anotherOvalRadius,
                                        2*anotherOvalRadius, 2*anotherOvalRadius);
    _anotherOvalShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:anotherOvalRect].CGPath;
    _anotherOvalShapeLayer.lineCap = kCALineCapRound;
    
    [_complexLoadingView.layer addSublayer:_anotherOvalShapeLayer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self __caz__beginSimpleAnimation];
    [self __caz__beginComplexAnimation];
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

- (void)__caz__beginComplexAnimation
{
    CABasicAnimation* strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-.5);
    strokeStartAnimation.toValue = @1;
    
    CABasicAnimation* strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @0;
    strokeEndAnimation.toValue = @1;
    
    CAAnimationGroup* strokeAnimationGroup = [[CAAnimationGroup alloc] init];
    strokeAnimationGroup.duration = 1.5;
    strokeAnimationGroup.repeatCount = HUGE;
    strokeAnimationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
    
    [_anotherOvalShapeLayer addAnimation:strokeAnimationGroup forKey:nil];
}

@end
