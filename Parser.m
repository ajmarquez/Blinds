//
//  Parser.m
//  AccordianView
//
//  Created by Abelardo Marquez on 6/15/15.
//  Copyright (c) 2015 innofied.com. All rights reserved.
//

#import "Parser.h"

@implementation Parser

@synthesize headerTextArray;
@synthesize contentTextArray;



#pragma Methods to get array with dictionary

-(void)createArraysUsing:(NSString*)json{
    
    //Getting the json
    headerTextArray = [[NSMutableArray alloc]init];
    contentTextArray = [[NSMutableArray alloc] init];
    NSLog(@"(void)getJSONDataFromFile:(NSString*)fileAddress");
    NSString *filePath = [[NSBundle mainBundle] pathForResource:json ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:0 error:nil];
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    
    NSLog(@"json: %@",jsonObject);
    
    
    for (NSDictionary *jsonData in jsonObject) {
        
        
        
        NSUInteger count=1 ;
        
        for (NSString* key in jsonData) {
            
            if ([jsonData[key] isEqualToString:@""]) {
                
                
            }
            
            else{
                
                count++;
                [headerTextArray addObject:key];
                [contentTextArray addObject:jsonData[key]];
                NSLog(@"**Behols the header array: %@",key);
                NSLog(@"**Behold the content Array: %@", jsonData[key]);
                
            }
            
        }
        
        NSLog(@"Behols the header array: %lu",(unsigned long)headerTextArray.count);
        NSLog(@"Behold the content Array: %lu", (unsigned long)contentTextArray.count);

        
        
        
        
        
        
    }

    
}






-(NSMutableArray*)getHeaderArray{
  
    
    return headerTextArray;
}

-(NSMutableArray*)getContentArray{
 
    return contentTextArray;
}




# pragma Private Methods. Getting Arrays without Dictionary.

- (void)getJSONDataFromFile:(NSString*)fileAddress
{
    headerTextArray = [[NSMutableArray alloc]init];
    contentTextArray = [[NSMutableArray alloc] init];
    NSLog(@"(void)getJSONDataFromFile:(NSString*)fileAddress");
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileAddress ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:0 error:nil];
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    
    NSLog(@"json: %@",jsonObject);
    
    
    [self parseJSON:jsonObject];
}


-(void)parseJSON:(NSArray*)json{
    
    
    
    for (NSDictionary *medData in json) {
        
        
        
        NSUInteger sectionNumber = [self countNumberOfSections:medData];
        NSLog(@"The number is: %lu", (unsigned long)sectionNumber);
        

        
        
        

    }
}


-(NSUInteger)countNumberOfSections:(NSDictionary*)json{
    
    NSUInteger count=1 ;
    
    for (NSString* key in json) {
        
        if ([json[key] isEqualToString:@""]) {
            
            
        }
        
        else{
            
            count++;
            [headerTextArray addObject:key];
            [contentTextArray addObject:json[key]];
            NSLog(@"**Behols the header array: %@",key);
            NSLog(@"**Behold the content Array: %@", json[key]);
            
        }
        
    }
    
    NSLog(@"Behols the header array: %lu",(unsigned long)headerTextArray.count);
    NSLog(@"Behold the content Array: %lu", (unsigned long)contentTextArray.count);
    return count;
}


@end
