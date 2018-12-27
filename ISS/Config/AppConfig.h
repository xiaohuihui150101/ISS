//
//  AppConfig.h
//  ISS-ISPS-USER
//
//  Created by isoft on 2018/12/5.
//  Copyright © 2018 isoft. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h


//rgb颜色转换（16进制->10进制）
#define mHexColor(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

#define mHexColorAlpha(hex,a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:a]

#define kBottomBgColor    mHexColor(0xF5F5F5) //灰色的底色
#define kLineColor        mHexColor(0xEBEBEB)  //灰色的线
#define kLightWordColor   mHexColor(0xCBCBCB)  //浅灰色的字


#endif /* AppConfig_h */
