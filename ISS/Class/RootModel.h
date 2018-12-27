//
//  RootModel.h
//  ISS
//
//  Created by isoft on 2018/12/25.
//  Copyright © 2018 isoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ListData,ListRows,ListPostLabels;

@interface RootModel : NSObject

@property (nonatomic, strong) ListData *data;

@end

@interface ListData : NSObject

@property (nonatomic, strong) NSArray<ListRows *> *rows;

@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, assign) NSInteger maxPage;

@end

@interface ListRows : NSObject

@property (nonatomic, strong) NSArray<ListPostLabels *> *postLabels;

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *circleid;
@property (nonatomic, copy) NSString *circlename;
@property (nonatomic, copy) NSString *commentsum;
@property (nonatomic, copy) NSString *coverimg;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *photo;

@end

@interface ListPostLabels : NSObject

@property (nonatomic, copy) NSString *postID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;

@end



