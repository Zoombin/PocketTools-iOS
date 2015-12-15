//
//  MovieInfo.m
//  PocketTools
//
//  Created by 颜超 on 15/3/11.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "MovieInfo.h"

@implementation MovieInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.rid = attributes[@"rid"];
        self.name = attributes[@"name"];
        self.wk = attributes[@"wk"];
        self.wboxoffice = attributes[@"wboxoffice"];
        self.tboxoffice = attributes[@"tboxoffice"];
        
        self.attendance = attributes[@"attendance"];
        self.averaging = attributes[@"averaging"];
        self.boxoffice = attributes[@"boxoffice"];
        self.fare = attributes[@"fare"];
        self.people = attributes[@"people"];
        self.statistics = attributes[@"statistics"];
        self.totals = attributes[@"totals"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *movies = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        MovieInfo *info = [[MovieInfo alloc] initWithAttributes:array[i]];
        [movies addObject:info];
    }
    return movies;
}
@end
