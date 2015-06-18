//
//  Blinds.m
//
//  Blinds is created by Abelardo Marquez @ajmarquez
//  this library is based on AccodianView by AnubhabRay
//

#import "Blinds.h"
#import <QuartzCore/QuartzCore.h>
#import "Parser.h"

#define Yvalueinitial 0
@interface Blinds ()

//We should clean a little bit this code

@property (nonatomic) BOOL isExpanded;
@property (nonatomic) NSUInteger tagOfViewExpanded;

@end

@implementation Blinds
@synthesize scrollViewForAccordian;
@synthesize isExpanded;
@synthesize tagOfViewExpanded;
@synthesize headerArray;
@synthesize contentArray;
@synthesize globalWidth;
@synthesize headerFontSize;
@synthesize contentFontSize;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 
 Set the init method that will define sizes, colors, and fonts for the accordion
 **/

-(void)initWithWidth:(NSInteger)width {
    
    globalWidth = width;
}

-(void)initWithHeaderArray:(NSMutableArray*)header ContentArray:(NSMutableArray*)content {
    
    headerArray = header;
    contentArray = content;
}

-(void)setFontSizesForHeader:(NSInteger)headerSize andContent:(NSInteger)contentSize{
    
    headerFontSize  = headerSize;
    contentFontSize = contentSize;
}



-(void) settingDifferentDevices
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480)
    {
        NSLog(@"its 3.5 inch");
        scrollViewForAccordian.frame  = CGRectMake(scrollViewForAccordian.frame.origin.x, scrollViewForAccordian.frame.origin.y, scrollViewForAccordian.frame.size.width, scrollViewForAccordian.frame.size.height-88);
        
    }
    else
    {
        NSLog(@"its 4 inch");
        
        
    }
}

/**
 Main Methods to create the accordion
 **/

-(void)createBlinds
{
    int yValue=Yvalueinitial;
    for (UIView *views in scrollViewForAccordian.subviews)
    {
        [views removeFromSuperview];
    }
    for (int i=1 ; i<= headerArray.count; i++)
    {
        UIView *viewForOutertable = [[UIView alloc]initWithFrame:CGRectMake(0, yValue, globalWidth, 44)];
        viewForOutertable.tag = i;
        viewForOutertable.backgroundColor = [UIColor colorWithRed:247/255.0f
                                                            green:247/255.0f
                                                             blue:247/255.0f
                                                            alpha:1.0f];
        viewForOutertable.layer.borderColor = [UIColor colorWithRed:240/255.0f
                                                              green:240/255.0f
                                                               blue:240/255.0f
                                                              alpha:1.0f].CGColor;
        viewForOutertable.layer.borderWidth = 1.5f;
        
        UILabel *labelOnOuter = [[UILabel alloc]initWithFrame:CGRectMake(20, 7, 250, 30)];
        labelOnOuter.text = headerArray[i-1];
        labelOnOuter.font = [UIFont fontWithName:@"Avenir-Medium" size:headerFontSize];
        labelOnOuter.textColor = [UIColor colorWithRed:149/255.0f
                                                 green:149/255.0f
                                                  blue:149/255.0f
                                                 alpha:1.0f];;
        
        UIButton *buttonToEnlarge = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, globalWidth, 44)];
        buttonToEnlarge.tag = i;
        //[buttonToEnlarge setImage:[UIImage imageNamed:@"open.png"] forState:UIControlStateNormal];
        //[buttonToEnlarge setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateSelected];
        
        [buttonToEnlarge addTarget:self action:@selector(expandButtonTapped:) forControlEvents: UIControlEventTouchUpInside];
        UIImageView *imageViewFOrOuterTable = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, globalWidth, 44)];
        //imageViewFOrOuterTable.image = [UIImage imageNamed:@"gray_bar_520X88.png"];
        [viewForOutertable addSubview:imageViewFOrOuterTable];
        [viewForOutertable addSubview:labelOnOuter];
        [viewForOutertable addSubview:buttonToEnlarge];
        [scrollViewForAccordian addSubview:viewForOutertable];
        yValue = yValue+viewForOutertable.frame.size.height;
    }
    [scrollViewForAccordian setContentSize:CGSizeMake(globalWidth, yValue)];
}



-(void)createContentForTag:(NSUInteger)tagForView
{
    float yValue=Yvalueinitial, yValueForSubviews;
    tagOfViewExpanded = tagForView;
    UIView *viewBelowWhichItStarts;
    NSMutableArray *subviewsArray = [scrollViewForAccordian.subviews mutableCopy];
    NSSortDescriptor *aSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    [subviewsArray sortUsingDescriptors:[NSArray arrayWithObject:aSortDescriptor]];
    
    for (UIView * subviews in subviewsArray)
    {
        if (subviews.tag == 0 )
        {
            [subviews removeFromSuperview];
        }
        if (subviews.tag ==tagForView )
        {
            viewBelowWhichItStarts = subviews;
            yValueForSubviews=viewBelowWhichItStarts.frame.origin.y+viewBelowWhichItStarts.frame.size.height;
        }
    }
    yValue = viewBelowWhichItStarts.frame.origin.y+44;
    NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 8;
    UIFont* font = [UIFont fontWithName:@"Avenir-Book" size:contentFontSize]; //*** CONTENT FONT
    NSDictionary* fontAttributes = @{
                           NSParagraphStyleAttributeName: paragraph,
                           NSFontAttributeName:font
                           };
        
    NSAttributedString* attrString = [[NSAttributedString alloc]
                                      initWithString:contentArray[tagForView-1]
                                      attributes:fontAttributes];

    NSTextStorage* textStorage = [NSTextStorage new];
    [textStorage appendAttributedString:attrString];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    
        //*** Experiment (1)
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(300, SIZE_MAX)];
    
        //End of Experiment */
        
    [layoutManager addTextContainer:container];
    [textStorage addLayoutManager:layoutManager];
    
    int rectHeight =   [layoutManager usedRectForTextContainer:container].size.height;
    NSLog(@"****The rectheight is: %u", rectHeight);
        //POR REVISAR
        
    UITextView* dummySection = [[UITextView alloc] initWithFrame:CGRectMake(20, 0, 300, rectHeight+10) textContainer:container];
    dummySection.editable = NO;
    
    UIView* viewForInnerTable = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                    yValue,
                                                                    300,
                                                                        rectHeight+10)]; //size check 220
    viewForInnerTable.backgroundColor = [UIColor whiteColor];
    [viewForInnerTable addSubview:dummySection];
    yValue = yValue+viewForInnerTable.frame.size.height;
    [scrollViewForAccordian addSubview:viewForInnerTable];
    yValueForSubviews = yValue;
    for (UIView * subviews in subviewsArray)
    {
        if (subviews.tag > tagForView)
        {
            [scrollViewForAccordian bringSubviewToFront:subviews];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            subviews.frame = CGRectMake(0, yValueForSubviews, globalWidth, viewBelowWhichItStarts.frame.size.height);
            [UIView commitAnimations];
            
            
            yValueForSubviews = yValueForSubviews + viewBelowWhichItStarts.frame.size.height;
        }
    }
    [scrollViewForAccordian setContentSize:CGSizeMake(globalWidth, yValueForSubviews+2)];
}


-(void)expandButtonTapped:(UIButton *)sender
{
    for (UIView *outerViews in scrollViewForAccordian.subviews)
    {
        if (outerViews.tag >0)
        {
            for (UIView *subviews in outerViews.subviews)
            {
                if ([subviews isMemberOfClass:[UIButton class]])
                {
                    ((UIButton *)subviews).selected = NO;
                }
                if ([subviews isMemberOfClass:[UIImageView class]])
                {
                    //((UIImageView *)subviews).image = [UIImage imageNamed:@"gray_bar_520X88.png"];
                    if (outerViews.tag == sender.tag && !sender.selected)
                    {
                        //((UIImageView *)subviews).image = [UIImage imageNamed:@"gray_bar_520X88_selected.png"];
                    }
                }
            }
        }
    }
    if (!isExpanded) // when NO process tree is already expanded
    {
        isExpanded = YES;
        sender.selected = YES;
        [self createContentForTag: sender.tag]; //setTableInner: sender.tag
    }
    else // when the process tree is already expanded
    {
        isExpanded =NO;
        if (sender.tag == tagOfViewExpanded)
        {
            sender.selected = NO;
            [self bringUpViews:tagOfViewExpanded];
        }
        else
        {
            sender.selected = YES;
            [self bringUpViews:tagOfViewExpanded];
            [self createContentForTag: sender.tag];  //setTableInner: sender.tag
            isExpanded = YES;
        }
        
    }
}

-(void)bringUpViews:(NSUInteger)tagForView
{
    UIView *viewBelowWhichItStarts;
    float yValueForSubviews;
    for (UIView * subviews in scrollViewForAccordian.subviews)
    {
        if (subviews.tag == tagForView)
        {
            viewBelowWhichItStarts =subviews;
            yValueForSubviews = viewBelowWhichItStarts.frame.origin.y+44;
        }
        if (subviews.tag > tagForView )
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            subviews.frame = CGRectMake(0, yValueForSubviews, 320, viewBelowWhichItStarts.frame.size.height);
            [UIView commitAnimations];
            yValueForSubviews = yValueForSubviews + viewBelowWhichItStarts.frame.size.height;
        }
    }
    [scrollViewForAccordian setContentSize:CGSizeMake(320, yValueForSubviews)];
    yValueForSubviews = viewBelowWhichItStarts.frame.origin.y;
    [scrollViewForAccordian bringSubviewToFront:viewBelowWhichItStarts];
    float yChek = yValueForSubviews;
    // if needed to remove the previosly cretaed views
    for (UIView * subviews in scrollViewForAccordian.subviews)
    {
        if (subviews.tag == 0)
        {
            if ((subviews.frame.origin.y - yChek) == 44)
            {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.3];
                subviews.frame = CGRectMake(0, yValueForSubviews, 320, viewBelowWhichItStarts.frame.size.height);
                [UIView commitAnimations];
                yChek +=44;
                
            }
        }
    }
}

#pragma Integrator Function

-(void)CreateBlindWithJson:(NSString*)json {
    
    headerArray = [[NSMutableArray alloc] init];
    
    contentArray = [[NSMutableArray alloc] init];
    
    
    scrollViewForAccordian = [[UIScrollView alloc] init];
    scrollViewForAccordian.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height);
    scrollViewForAccordian.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollViewForAccordian];
    [self settingDifferentDevices];
    Parser* parseInfo = [[Parser alloc] init];
    
    [parseInfo createArraysUsing:json];
    //[parseInfo getJSONDataFromFile:json];
    [self initWithHeaderArray:parseInfo.headerTextArray ContentArray:parseInfo.contentTextArray];
    NSLog(@"Header info: %lu",(unsigned long)parseInfo.headerTextArray.count);
    NSLog(@"Content info: %lu",(unsigned long)parseInfo.contentTextArray.count);
    
    
    [self initWithWidth:self.view.bounds.size.width];
    [self setFontSizesForHeader:20 andContent:18];
    [self createBlinds];

    
    
    
}


@end
