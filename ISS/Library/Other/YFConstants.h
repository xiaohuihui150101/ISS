//
//  YFConstants.h
//  ISS-ISPS-USER
//
//  Created by isoft on 2018/12/5.
//  Copyright © 2018 isoft. All rights reserved.
//

#ifndef YFConstants_h
#define YFConstants_h

#define YF_DEPRECATED(explain) __attribute__((deprecated(explain)))
#define YF_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define YF_IS_IPHONE_X (YF_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0f)
#define YF_IS_IPHONE_XS (YF_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 896.0f)
#define YF_IS_IOS_11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.f)


#endif /* YFConstants_h */
