//
//  Parser.h
//  AccordianView
//
//  Created by Abelardo Marquez on 6/15/15.
//  Copyright (c) 2015 innofied.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSObject

@property (nonatomic, copy) NSString* jsonDocument;
@property (nonatomic, copy) NSDictionary* wordList;

@property (nonatomic, copy) NSMutableArray* headerTextArray;
@property (nonatomic, copy) NSMutableArray* contentTextArray;

/* Parsing Methods */

/* This method creates a Header Array using the rwords specified on the Dictionary, is there's
    no content, it will skip to the next word */

-(void)createArraysUsing:(NSString*)json; // andKeys:(NSDictionary*)list;
- (void)getJSONDataFromFile:(NSString*)fileAddress;

//Getters for the Header and Content Arrays
-(NSMutableArray*)getHeaderArray;
-(NSMutableArray*)getContentArray;

 


@end
