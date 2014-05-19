//
//  QBGradientView.m
//  MobileMafia
//
//  Created by Ruben Nieves on 10/2/10.
//  Copyright 2010 Mobile Mafia. All rights reserved.
//

#import "QBGradientLabel.h"

struct QBColor const QBColorBlack		= {0.0, 0.0, 0.0, 1.0};
struct QBColor const QBColorGray		= {0.5, 0.5, 0.5, 1.0};
struct QBColor const QBColorZero		= {0.0, 0.0, 0.0, 0.0};

@interface QBGradientLabel ()
@property struct QBColor lightColor;
@property struct QBColor darkColor;
@end

@implementation QBGradientLabel

#pragma mark - Special Methods
- (struct QBColor)colorFromUIColor:(UIColor*)UIcolor;
{
	CGColorRef color = UIcolor.CGColor;
    struct QBColor rv = QBColorZero;
	size_t numComponents = CGColorGetNumberOfComponents(color);
	if (numComponents == 4) {
		const CGFloat *components = CGColorGetComponents(color);
		float red = components[0];
		float green = components[1];
		float blue = components[2];
		float alpha = components[3];
		rv.red = red;
        rv.green = green;
        rv.blue = blue;
        rv.alpha = alpha;
		
	} else if (numComponents == 2)	{
        const CGFloat *components = CGColorGetComponents(color);
        float allColor = components[0];
        float alpha = components[1];
        rv.red = allColor;
        rv.green = allColor;
        rv.blue = allColor;
        rv.alpha = alpha;
	}
    return rv;
}

struct QBColor QBColorMake(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
{
	struct QBColor rv = QBColorZero;
	rv.red		= red;
	rv.green	= green;
	rv.blue		= blue;
	rv.alpha	= alpha;
	
	return (rv);
}

void QBContextDrawVerticalGradient(CGContextRef c, CGGradientRef gradient, CGRect rect, CGFloat ratio)
{
	CGFloat midx = CGRectGetMidX(rect);
	CGFloat miny = CGRectGetMinY(rect), maxy = CGRectGetMaxY(rect);
	
	CGPoint startPoint;
	CGPoint endPoint;
	
	startPoint.x = midx;
	startPoint.y = miny;
	endPoint.x   = midx;
	endPoint.y   = maxy * ratio;
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGContextDrawLinearGradient(c, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
	CGColorSpaceRelease(rgb);
}

void QBContextDrawHorizontalGradient(CGContextRef c, CGGradientRef gradient, CGRect rect, CGFloat ratio)
{
	CGFloat minx = CGRectGetMinX(rect);
	CGFloat maxx = CGRectGetMaxX(rect);
	CGFloat midy = CGRectGetMidY(rect);
	
	CGPoint startPoint;
	CGPoint endPoint;
	
	// Gradient line
	startPoint.x = minx;
	startPoint.y = midy;
	endPoint.x   = maxx * ratio;
	endPoint.y   = midy;
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGContextDrawLinearGradient(c, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
	CGColorSpaceRelease(rgb);
}


#pragma mark - Instance Methods
- (void)setLighterColor:(UIColor *)color
{
    self.lightColor = [self colorFromUIColor:color];
    [self setNeedsDisplay];
}

- (void)setDarkerColor:(UIColor *)color
{
    self.darkColor = [self colorFromUIColor:color];
    [self setNeedsDisplay];
}

#pragma mark - Object lifecycle
- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        _lightColor = QBColorGray;
        _darkColor = QBColorBlack;
		_gradientDirection = Orientation_Vertical;
        _startOffset = GRADIENT_PERCENTAGE;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame darkColor:(UIColor *)darkColor andLightColor:(UIColor *)lightColor
{
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        _lightColor = [self colorFromUIColor:lightColor];
        _darkColor = [self colorFromUIColor:darkColor];
		_gradientDirection = Orientation_Vertical;
        _startOffset = GRADIENT_PERCENTAGE;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    
	CGContextSaveGState(ctx);
	
	//Gradient
	CGFloat gradientColors[] = {
		_lightColor.red ,  _lightColor.green, _lightColor.blue, _lightColor.alpha,
		_darkColor.red ,  _darkColor.green, _darkColor.blue, _darkColor.alpha,
	};
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, gradientColors, NULL, sizeof(gradientColors)/(sizeof(gradientColors[0])*4));
    
    
    if (_gradientDirection == Orientation_Vertical) {
		QBContextDrawVerticalGradient(ctx, gradient, rect, _startOffset);
	} else {
		QBContextDrawHorizontalGradient(ctx, gradient, rect, _startOffset);
	}
    
	CGGradientRelease(gradient);
	CGColorSpaceRelease(rgb);
	CGContextRestoreGState(ctx);
    
    [super drawRect:rect];
}

@end
