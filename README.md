QBGradientLabel
===============

Simple label that draws a gradient as the background. Offers multiple ways to initialize or change color. Written in Both ObjC and Swift


Getting Started
=================

Install
--------------------
1. Load files under GradientLabel in sample project to your own project.
2. `#import "QGGradientLabel.h"`

Usage
--------------------
Look at header methods in h file for usage.

Example:

```    
UIColor *lightBlue = [UIColor colorWithRed:97.0/255.0 green:118.0/255.0 blue:155.0/255.0 alpha:1.0];
UIColor *darkBlue = [UIColor colorWithRed:2.0/255.0 green:31.0/255.0 blue:84.0/255.0 alpha:1.0];
QBGradientLabel *plainLabel = [[QBGradientLabel alloc] initWithFrame:CGRectMake(20, 20, 200, 40) darkColor:lightBlue andLightColor:darkBlue];
``` 

![QBLog](http://www.topbalancesoftware.com/apps/gitmedia/gradientlabel.png)


MIT License
--------------------
    The MIT License (MIT)

    Copyright (c) 2014 Ruben Nieves

    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
    the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
