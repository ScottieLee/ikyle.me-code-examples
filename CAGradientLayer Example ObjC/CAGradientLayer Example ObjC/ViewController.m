//
//  ViewController.m
//  CAGradientLayer Example ObjC
//
//  Created by Kyle Howells on 14/06/2020.
//  Copyright © 2020 Kyle Howells. All rights reserved.
//

#import "ViewController.h"
#import "KHGradientView.h"

@interface ViewController (){
	KHGradientView *linGradientView;
	KHGradientView *radGradientView;
	KHGradientView *angGradientView;
}
@end

@implementation ViewController{
	UILabel *topLeft;
	UILabel *topRight;
	
	UILabel *bottomLeft;
	UILabel *bottomRight;
}

-(BOOL)prefersStatusBarHidden{
	return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
	return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	
	//
	// Linear Gradient
	//
	linGradientView = [[KHGradientView alloc] init];
	linGradientView.layer.type = kCAGradientLayerAxial;
	// The colors
	linGradientView.layer.colors =
	@[
		(id)[UIColor colorWithRed: 48.0/255.0 green: 35.0/255.0 blue: 174.0/255.0 alpha: 1.0].CGColor,
		(id)[UIColor colorWithRed: 200.0/255.0 green: 109.0/255.0 blue: 215.0/255.0 alpha: 1.0].CGColor
	];
	// Start and end position (x:0 left - x:1 right) (y:0 top - y:1 bottom)
	linGradientView.layer.startPoint = CGPointZero;
	linGradientView.layer.endPoint = CGPointMake(1, 1);
	[self.view addSubview:linGradientView];
	
	
	//
	// Radial Graient
	//
	radGradientView = [[KHGradientView alloc] init];
	radGradientView.layer.type = kCAGradientLayerRadial;
	radGradientView.layer.colors =
	@[
		(id)[UIColor colorWithRed: 0.0/255.0 green: 101.0/255.0 blue: 255.0/255.0 alpha: 1.0].CGColor,
		(id)[UIColor colorWithRed: 0.0/255.0 green: 40.0/255.0 blue: 101.0/255.0 alpha: 1.0].CGColor
	];
	// Start point of first color
	radGradientView.layer.startPoint = CGPointMake(0.5, 0.5);
	// End points of the x and y edges of the second color circle
	radGradientView.layer.endPoint = CGPointMake(0, 1);
	[self.view addSubview:radGradientView];
	
	
	//
	// Angluar Gradient
	//
	angGradientView = [[KHGradientView alloc] init];
	angGradientView.layer.type = kCAGradientLayerConic;
	angGradientView.layer.colors =
	@[
		(id)[UIColor colorWithRed: 245.0/255.0 green: 81.0/255.0 blue: 95.0/255.0 alpha: 1.0].CGColor,
		(id)[UIColor colorWithRed: 159.0/255.0 green: 4.0/255.0 blue: 27.0/255.0 alpha: 1.0].CGColor
	];
	// The center point the gradient spins around
	angGradientView.layer.startPoint = CGPointMake(0.5, 0.5);
	// The point in the view for the point it is drawn pointing towards
	angGradientView.layer.endPoint = CGPointMake(1, 0.5);
	[self.view addSubview:angGradientView];
	
	
	//
	// Corner Labels
	//
	topLeft = [self newCornerLabelWithX:0 Y:0];
	topLeft.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
	topLeft.center = CGPointMake(topLeft.frame.size.width * 0.5, topLeft.frame.size.height * 0.5);
	[self.view addSubview:topLeft];
	
	topRight = [self newCornerLabelWithX:1 Y:0];
	topRight.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
	topRight.center = CGPointMake(self.view.bounds.size.width - (topLeft.frame.size.width * 0.5), topLeft.frame.size.height * 0.5);
	[self.view addSubview:topRight];
	
	bottomLeft = [self newCornerLabelWithX:0 Y:1];
	bottomLeft.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
	bottomLeft.center = CGPointMake(bottomLeft.frame.size.width * 0.5, self.view.bounds.size.height - bottomLeft.frame.size.height * 0.5);
	[self.view addSubview:bottomLeft];
	
	bottomRight = [self newCornerLabelWithX:1 Y:1];
	bottomRight.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
	bottomRight.center = CGPointMake(self.view.bounds.size.width - (bottomRight.frame.size.width * 0.5), self.view.bounds.size.height - bottomRight.frame.size.height * 0.5);
	[self.view addSubview:bottomRight];
}

-(UILabel*)newCornerLabelWithX:(CGFloat)x Y:(CGFloat)y{
	UILabel *label = [[UILabel alloc] init];
	label.text = [NSString stringWithFormat:@"(x:%.1f, y:%.1f)", x, y];
	label.font = [UIFont systemFontOfSize:20];
	[label sizeToFit];
	label.textColor = [UIColor whiteColor];
	label.shadowColor = [UIColor blackColor];
	label.shadowOffset = CGSizeMake(0, 1);
	label.hidden = YES;
	return label;
}


- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	const CGSize size = self.view.bounds.size;
	
	if (size.height > size.width)
	{
		// Vertical layout
		CGFloat height = size.height/3;
		
		linGradientView.frame = ({
			CGRect frame = CGRectZero;
			frame.size.width = size.width;
			frame.size.height = height;
			frame;
		});
		
		radGradientView.frame = ({
			CGRect frame = CGRectZero;
			frame.origin.y = height;
			frame.size.width = size.width;
			frame.size.height = height;
			frame;
		});
		
		angGradientView.frame = ({
			CGRect frame = CGRectZero;
			frame.origin.y = (size.height - height);
			frame.size.width = size.width;
			frame.size.height = height;
			frame;
		});
	}
	else
	{
		// Horizontal layout
		CGFloat width = size.width/3;
		
		linGradientView.frame = ({
			CGRect frame = CGRectZero;
			frame.size.width = width;
			frame.size.height = size.height;
			frame;
		});
		
		radGradientView.frame = ({
			CGRect frame = CGRectZero;
			frame.origin.x = width;
			frame.size.width = width;
			frame.size.height = size.height;
			frame;
		});
		
		angGradientView.frame = ({
			CGRect frame = CGRectZero;
			frame.origin.x = (size.width - width);
			frame.size.width = width;
			frame.size.height = size.height;
			frame;
		});
	}
}

@end
