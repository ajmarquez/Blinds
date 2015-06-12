//
//  Blinds.h
//
//  Blinds is created by Abelardo Marquez @ajmarquez
//  This library is based on AccodianView by AnubhabRay
//

#import <UIKit/UIKit.h>


@interface Blinds : UIViewController

@property (nonatomic, copy) NSMutableArray* headerArray;    //Array tha contains the set of Header texts
@property (nonatomic, copy) NSMutableArray* contentArray;   //Array that contains the set of content texts

//View properties
@property (nonatomic, assign) NSInteger globalWidth;    //Sets the width of the header and other cells
@property (nonatomic, assign) NSInteger headerFontSize;
@property (nonatomic, assign) NSInteger contentFontSize;

/** Configuration Methods **/
/*  Run this methods in order to setud the accordion to de required size, color, font and data */

//Configure desired width
-(void)initWithWidth:(NSInteger)width;
//Add the arrays that provide the content. Quite explicit which is which
-(void)initWithHeaderArray:(NSMutableArray*)header ContentArray:(NSMutableArray*)content;
// Set the Font size for Header and Content
-(void)setFontSizesForHeader:(NSInteger)headerSize andContent:(NSInteger)contentSize;

//Main Method
-(void)createAccordion;




@end
