//
//  RES.h
//  XingAPIMobile
//
//  Created by Gwanho Jeong on 2020/02/23.
//  Copyright © 2020 Gwanho Jeong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RES : NSObject
{
    NSString* m_strCode;            // TR코드
    NSString* m_strName;            // TR명
    BOOL m_bAttr;                   // Attribute
    BOOL m_bBlock;                  // Block Mode
    BOOL m_bTran;                   // 조회성TR 여부
    NSString* m_strHeader;          // header type
    NSString* m_strServiceCode;     // Tux Code
    NSString* m_strResName;         // 파일이름
    NSMutableDictionary* m_dicBlock;
}

- (id)init:(NSString*)resName;


-(BOOL) SetFieldData:(NSString*)blockName fieldName:(NSString*)fieldName occursIndex:(NSInteger)occursIndex data:(NSString*)data;

-(NSString*) GetFieldData:(NSString*)blockName fieldName:(NSString*)fieldName occursIndex:(NSInteger)occursIndex;

-(NSData*) GetInputBlockData;

-(BOOL) SetOutputData:(NSData*)data blockName:(NSString*)blockName;

-(NSString*) GetHeaderType;

-(NSInteger) GetOccursCount:(NSString*)blockName;

-(BOOL) ReadRes;

-(void) ClearData;

//json 포멧으로 input 값을 만든다.
-(BOOL) SetJsonInput:(NSString*)jsonStr;

//JSON 파일 처리
-(NSString*) GetJsonData:(NSString*) blockName;

@end

NS_ASSUME_NONNULL_END
