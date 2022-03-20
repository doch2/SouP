//
//  InoutDefine.h
//  XingAPIMobile
//
//  Created by Gwanho Jeong on 2020/02/10.
//  Copyright © 2020 Gwanho Jeong. All rights reserved.
//

#ifndef InoutDefine_h
#define InoutDefine_h


//접속 서버 설정
//#define MOTU_SERVER         1 //모의투자 서버
//#define API_SERVER          2 //실서버

typedef NS_ENUM(NSUInteger, SERVER_TYPE) {
    API_SERVER,  //실서버
    MOTU_SERVER //모의투자
};

//설정
#define DEFAULT_SEND_COUNT_PER_SEC      2     //1초동안 보낸수 있는 default packet 갯수
#define RECEIVE_TIMEOUTERROR            -7     //Time out
#define RECEIVE_INITECHERROR            -6    // Initech Handshaking error
#define RECEIVE_ERROR                   -4    // 일반적인 에러
#define RECEIVE_DISCONNECT              -3    // SOCKET이 연결종료된 경우
#define RECEIVE_SYSTEMERROR             -2    // 서버에서 내려주는 시스템에러
#define RECEIVE_CONNECTERROR            -1    // SOCKET 연결에러
#define RECEIVE_CONNECT                 0     // SOCKET 연결완료
#define RECEIVE_DATA                    1     // TR데이타 수신
#define RECEIVE_REALDATA                2     // 실시간데이타 수신
#define RECEIVE_MSG                     3     // TR메세지 수신
#define RECEIVE_LOGINCOMPLETE           4     // 로그인완료
#define RECEIVE_RECONNECT               5     // SOCKET종료후 재연결 완료
#define RECEIVE_SIGN                    6     // 선택한 공인인증서 관련 정보
#define RECEIVE_INITECHOK               7     // Initech  Handshaking OK
#define RECEIVE_RELEASEDATA             8     // Release data
#define RQID_REAL_DATA                  -1    //rqID 값이 -1인경우 실시간 데이터
#define RQID_USER_MESSAGE               -2    //rqID 값이 -2인경우 사용자 메시지

//해더정보 설정
#define HT_SERVICE_CODE                 100 // 서비스 코드
#define HT_FUNCTION                     101// Function
#define HT_LOAN                         102// Loan 사용여부
#define HT_RQCNT                        103// Request Count
#define HT_LANG                         104// 언어
#define HT_USERDATA                     105// 사용자 데이터
#define HT_ETKMEDIA                     106// 당사매체
#define HT_COMMEDIA                     107// 통신매체

//로그인 형태
#define LOGIN_BY_ID                     1 // 아이디, 비밀번호로 로그인
#define LOGIN_BY_PUB_CERTI              2 // 공인인증으로 로그임


//접속 관련
typedef NS_ENUM(NSUInteger, CONNECT_ERROR)
{
    ALRADY_CONNECTED,
    CONNECT_FAIL,
    INITEC_ERROR,
    UNKNOWN_ERROR,
    NOTHING_ERROR
};

#define XM_LRC_SUCCESS                              0000
#define XM_LRC_SUCCESS_MSG                               @"로그인 성공"
#define XM_LRC_CERT_EXPIRE                          2001
#define XM_LRC_CERT_EXPIRE_MSG                          @"공인인증서가 만료/정지/폐지 되었습니다."
#define XM_LRC_CERT_NOT_REG                         2002
#define XM_LRC_CERT_NOT_REG_MSG                         @"미등록된 공인인증서입니다."
#define XM_LRC_CERT_NOT_EXIST                       2003
#define XM_LRC_CERT_NOT_EXIST_MSG                       @"공인인증서가 존재하지 않습니다."
#define XM_LRC_CERT_WRONG_PWD_5                     2004
#define XM_LRC_CERT_WRONG_PWD_5_MSG                     @"공인인증 비밀번호가 5회 오류 발생하였습니다."
#define XM_LRC_CERT_WRONG_PWD                       2005
#define XM_LRC_CERT_WRONG_PWD_MSG                       @"공인인증서 비밀번호 에러입니다."
#define XM_LRC_CERT_NOT_LOAD                        2006
#define XM_LRC_CERT_NOT_LOAD_MSG                        @"공인인증서 모듈 초기화에 실패했습니다."
#define XM_LRC_CERT_NOT_INIT                        2007
#define XM_LRC_CERT_NOT_INIT_MSG                        @"공인인증서 모듈 초기화에 실패했습니다."
#define XM_LRC_CERT_CANCEL                          2008
#define XM_LRC_CERT_CANCEL_MSG                          @"인증과정이 취소되었습니다."
#define XM_LRC_CERT_FAIL_GET_PUBLIC_KEY             2009
#define XM_LRC_CERT_FAIL_GET_PUBLIC_KEY_MSG             @"공개키 추출에 실패했습니다."
#define XM_LRC_CERT_SEND_PUBLIC_KEY                 2010
#define XM_LRC_CERT_SEND_PUBLIC_KEY_MSG                 @"공개키 전송이 실패했습니다"
#define XM_LRC_REQUEST_FAIL_ACCLIST                 5003
#define XM_LRC_REQUEST_FAIL_ACCLIST_MSG                 @"서버에 계좌리스트 요청 실패"
#define XM_LRC_REQUEST_FAIL_LOGIN_INFO              5004
#define XM_LRC_REQUEST_FAIL_LOGIN_INFO_MSG              @"로그인 정보 요청이 실패했습니다."
#define XM_LRC_REQUEST_FAIL_API_REG_INFO            5005
#define XM_LRC_REQUEST_FAIL_API_REG_INFO_MSG            @"API 신청 여부 조회가 실패했습니다."
#define XM_LRC_NOT_USE_FREEMEMBER                   8000
#define XM_LRC_NOT_USE_FREEMEMBER_MSG                   @"프리맴버는 사용이 불가능합니다."
#define XM_LRC_EMPTY_ACCLIST                        8002
#define XM_LRC_EMPTY_ACCLIST_MSG                        @"수신된 계좌리스트가 비어 있습니다."
#define XM_LRC_ERROR_ACCLIST                        8003
#define XM_LRC_ERROR_ACCLIST_MSG                        @"수신된 계좌리스트에 오류가 발생하였습니다."
#define XM_LRC_LOGIN_ERROR                          8004
#define XM_LRC_LOGIN_ERROR_MSG                          @"로그인 실패했습니다."
#define XM_LRC_LOGIN_CANCELED_BY_USER               8005
#define XM_LRC_LOGIN_CANCELED_BY_USER_MSG               @"사용자가 취소했습니다."
#define XM_LRC_FIDO_NOT_ALLOW_MOTO                  8100
#define XM_LRC_FIDO_NOT_ALLOW_MOTO_MSG                  @"운영서버에서만 지문인증이 가능합니다."
#define XM_LRC_NOT_FOUND_FIDO_CLNT_NO               8101
#define XM_LRC_NOT_FOUND_FIDO_CLNT_NO_MSG               @"바이오인증 고객번호가 존재하지 않습니다."
#define XM_LRC_NOT_FOUND_CHAIN_DN                   8102
#define XM_LRC_NOT_FOUND_CHAIN_DN_MSG                   @"공동인증 DN값이 존재하지 않습니다."
#define XM_LRC_CONNECT_DEMO_SVR                     8103
#define XM_LRC_CONNECT_DEMO_SVR_MSG                     @"모의투자서버에 접속해 주세요."
#define XM_LRC_CONNECT_REAL_SVR                     8104
#define XM_LRC_CONNECT_REAL_SVR_MSG                     @"운영서버에 접속해 주세요."
#define XINGAPI_SUCCESS                              1
#define XINGAPI_SUCCESS_MSG                             @"데이터 요청을 완료했습니다."
#define XINGAPI_ERROR_SOCKET_CREATE_FAIL            -1
#define XINGAPI_ERROR_SOCKET_CREATE_FAIL_MSG            @"통신소켓 생성에 실패하였습니다."
#define XINGAPI_ERROR_CONNECT_FAIL                  -2
#define XINGAPI_ERROR_CONNECT_FAIL_MSG                  @"서버접속에 실패하였습니다."
#define XINGAPI_ERROR_WRONG_ADDRESS                 -3
#define XINGAPI_ERROR_WRONG_ADDRESS_MSG                 @"서버주소가 틀렸습니다."
#define XINGAPI_ERROR_CONNECT_TIMEOUT               -4
#define XINGAPI_ERROR_CONNECT_TIMEOUT_MSG               @"서버 접속시간이 초과되었습니다."
#define XINGAPI_ERROR_ALREADY_LOGINED               -5
#define XINGAPI_ERROR_ALREADY_LOGINED_MSG               @"이미 로그인되었습니다."
#define XINGAPI_ERROR_CANT_USE_TR                   -6
#define XINGAPI_ERROR_CANT_USE_TR_MSG                   @"해당 TR은 사용할 수 없습니다."
#define XINGAPI_ERROR_NEED_LOGIN                    -7
#define XINGAPI_ERROR_NEED_LOGIN_MSG                    @"로그인을 해야 사용이 가능합니다"
#define XINGAPI_ERROR_CANT_USE_SISEONLY             -8
#define XINGAPI_ERROR_CANT_USE_SISEONLY_MSG             @"시세전용에서는 사용이 불가능합니다."
#define XINGAPI_ERROR_HAVE_NOT_ACCOUNT              -9
#define XINGAPI_ERROR_HAVE_NOT_ACCOUNT_MSG              @"해당 계좌가 없습니다."
#define XINGAPI_ERROR_FAULT_PACKET_SIZE             -10
#define XINGAPI_ERROR_FAULT_PACKET_SIZE_MSG             @"Packet의 크기가 잘못되었습니다."
#define XINGAPI_ERROR_DIFF_DATA_SIZE                -11
#define XINGAPI_ERROR_DIFF_DATA_SIZE_MSG                @"Data 크기가 다릅니다."
#define XINGAPI_ERROR_NOT_EXIST_ACCOUNT             -12
#define XINGAPI_ERROR_NOT_EXIST_ACCOUNT_MSG             @"계좌가 존재하지 않습니다."
#define XINGAPI_ERROR_NOT_ENOUGH_RQID               -13
#define XINGAPI_ERROR_NOT_ENOUGH_RQID_MSG               @"Request ID가 부족합니다."
#define XINGAPI_ERROR_NOT_CREATE_SOCKET             -14
#define XINGAPI_ERROR_NOT_CREATE_SOCKET_MSG             @"통신소켓이 생성되지 않았습니다."
#define XINGAPI_ERROR_ENCRYPT_CREATE_FAIL           -15
#define XINGAPI_ERROR_ENCRYPT_CREATE_FAIL_MSG           @"암호화 생성에 실패했습니다."
#define XINGAPI_ERROR_DATA_SEND_FAIL                -16
#define XINGAPI_ERROR_DATA_SEND_FAIL_MSG                @"데이터 전송에 실패했습니다."
#define XINGAPI_ERROR_FAIL_ENCRYPT_RTN              -17
#define XINGAPI_ERROR_FAIL_ENCRYPT_RTN_MSG              @"암호화(RTN)처리에 실패했습니다."
#define XINGAPI_ERROR_CERT_NOT_EXIST_FILE           -18
#define XINGAPI_ERROR_CERT_NOT_EXIST_FILE_MSG           @"공인인증 파일이 없습니다."
#define XINGAPI_ERROR_CERT_NOT_EXIST_FUNC           -19
#define XINGAPI_ERROR_CERT_NOT_EXIST_FUNC_MSG           @"공인인증 Function이 없습니다."
#define XINGAPI_ERROR_NOT_ENOUGH_MEMORY             -20
#define XINGAPI_ERROR_NOT_ENOUGH_MEMORY_MSG             @"메모리가 충분하지 않습니다."
#define XINGAPI_ERROR_LIMIT_TR                      -21
#define XINGAPI_ERROR_LIMIT_TR_MSG                      @"TR의 시간당 전송제한에 걸렸습니다."
#define XINGAPI_ERROR_NOT_USE_FUNCTION              -22
#define XINGAPI_ERROR_NOT_USE_FUNCTION_MSG              @"해당 TR은 해당 함수를 이용할 수 없습니다."
#define XINGAPI_ERROR_NOT_FIND_TR_INFO              -23
#define XINGAPI_ERROR_NOT_FIND_TR_INFO_MSG              @"TR에 대한 정보를 찾을 수 없습니다."
#define XINGAPI_ERROR_ACCOUNT_POS                   -24
#define XINGAPI_ERROR_ACCOUNT_POS_MSG                   @"계좌위치가 지정되지 않았습니다."
#define XINGAPI_ERROR_HAVE_NOT_ACCOUNTLIST          -25
#define XINGAPI_ERROR_HAVE_NOT_ACCOUNTLIST_MSG          @"계좌리스트가 없습니다."
#define XINGAPI_ERROR_FILE_READ                     -26
#define XINGAPI_ERROR_FILE_READ_MSG                     @"파일 읽기에 실패했습니다."
#define XINGAPI_ERROR_REALKEY_REG                   -27
#define XINGAPI_ERROR_REALKEY_REG_MSG                   @"실시간 종목검색 조건 등록 최대건수를 초과하였습니다."
#define XINGAPI_ERROR_REALKEY                       -28
#define XINGAPI_ERROR_REALKEY_MSG                       @"실시간 종목검색 등록 키에 대한 정보를 찾을 수 없습니다."
#define XINGAPI_ERROR_MULTILOGIN                    -29
#define XINGAPI_ERROR_MULTILOGIN_MSG                    @"API 최대 접속 가능 횟수를 초과하였습니다."
#define XINGAPI_ERROR_CCONVERTTR_CSPAT03800         -30
#define XINGAPI_ERROR_CCONVERTTR_CSPAT03800_MSG         @"CSPAT03800 TR 요청 시, 한 번에 전송 가능한 주문갯수는 최대 7건입니다."
#define XINGAPI_ERROR_NOT_FIND_CHARTLIB             -31
#define XINGAPI_ERROR_NOT_FIND_CHARTLIB_MSG             @"차트라이브러리가 연동되지 않았습니다."
#define XINGAPI_ERROR_NOT_REAL_CHARTLIB             -32
#define XINGAPI_ERROR_NOT_REAL_CHARTLIB_MSG             @"차트데이터는 실서버로 접속하셔야만 이용이 가능합니다."
#define XINGAPI_ERROR_NOT_INPUT_CHARTLIB            -33
#define XINGAPI_ERROR_NOT_INPUT_CHARTLIB_MSG            @"차트데이터 inblock의 각 필드값을 확인해 주시기 바랍니다."
#define XINGAPI_ERROR_LIMITMAX_TR                   -34
#define XINGAPI_ERROR_LIMITMAX_TR_MSG                   @"TR의 10분당 최대 전송 가능 횟수를 초과하였습니다.\n이후부터는 전송가능횟수가 5배로 제한됩니다"
#define XINGAPI_ERROR_MULTILOGIN_OVER               -35
#define XINGAPI_ERROR_MULTILOGIN_OVER_MSG               @"API 최대 접속 가능 횟수를 초과하여 접속이 종료되었습니다."
#define XINGAPI_ERROR_CONVERTTR_CFOAT7XX00          -36
#define XINGAPI_ERROR_CONVERTTR_CFOAT7XX00_MSG          @"선옵복수주문 TR 요청 시, 한 번에 전송 가능한 주문갯수는 최대 7건입니다."
#define XINGAPI_ERROR_NOT_INPUT_SEARCHREAL          -37
#define XINGAPI_ERROR_NOT_INPUT_SEARCHREAL_MSG          @"실시간 종목검색 입력값을 확인하시기 바랍니다."
#define XINGAPI_ERROR_NOT_INPUT_ORD_QTY             -38
#define XINGAPI_ERROR_NOT_INPUT_ORD_QTY_MSG             @"주문수량 입력값을 확인하시기 바랍니다."
#define XINGAPI_ERROR_NOT_INPUT_ORD_PRICE           -39
#define XINGAPI_ERROR_NOT_INPUT_ORD_PRICE_MSG           @"주문가격 입력값을 확인하시기 바랍니다."
#define XINGAPI_ERROR_NOT_INPUT_ORD_CODE            -40
#define XINGAPI_ERROR_NOT_INPUT_ORD_CODE_MSG            @"종목코드가 입력되지 않았습니다."
#define XINGAPI_ERROR_NOT_INPUT_ORD_PWD             -41
#define XINGAPI_ERROR_NOT_INPUT_ORD_PWD_MSG             @"계좌비밀번호가 입력되지 않았습니다."
#define XINGAPI_ERROR_NOT_INPUT_ORD_ORIGNO          -42
#define XINGAPI_ERROR_NOT_INPUT_ORD_ORIGNO_MSG          @"원주문번호가 입력되지 않았습니다."
#define XINGAPI_ERROR_NOT_CONNECTED                 -70
#define XINGAPI_ERROR_NOT_CONNECTED_MSG                 @"네트워크 연결이 되지 않았습니다."
#define XINGAPI_ERROR_NOT_LOGGED_IN                 -71
#define XINGAPI_ERROR_NOT_LOGGED_IN_MSG                 @"로그인이 되지 않았습니다."
#define XINGAPI_ERROR_CERT_IDX_NOT_FOUND            -72
#define XINGAPI_ERROR_CERT_IDX_NOT_FOUND_MSG            @"선택한 인증서가 존재하지 않습니다."
#define XINGAPI_ERROR_CERT_PWD_EMPTY                -73
#define XINGAPI_ERROR_CERT_PWD_EMPTY_MSG                @"공인인증서 비밀번호를 입력하세요."
#define XINGAPI_ERROR_DATA_SIZE_SHORTER             -74
#define XINGAPI_ERROR_DATA_SIZE_SHORTER_MSG             @"요청한 데이타의 길이가 계좌길이보다 짫습니다."
#define XINGAPI_ERROR_ACNT_NOT_MATCH                -75
#define XINGAPI_ERROR_ACNT_NOT_MATCH_MSG                @"요청하신 계좌를 찾지 못 했습니다."
#define XINGAPI_ERROR_USER_ID_EMPTY                 -76
#define XINGAPI_ERROR_USER_ID_EMPTY_MSG                 @"아이디를 입력하세요."
#define XINGAPI_ERROR_USER_PWD_EMPTY                -77
#define XINGAPI_ERROR_USER_PWD_EMPTY_MSG                @"비밀번호를 입력하세요"
#define XINGAPI_ERROR_USER_CERT_PWD_EMPTY           -78
#define XINGAPI_ERROR_USER_CERT_PWD_EMPTY_MSG           @"공인인증서 비밀번호를 입력하세요."
#define XINGAPI_ERROR_NOT_REG_HANDLE                -79
#define XINGAPI_ERROR_NOT_REG_HANDLE_MSG                @"핸들이 등록되지 않았습니다."
#define XINGAPI_ERROR_NOT_INSTALL_FIDO_APP          -80
#define XINGAPI_ERROR_NOT_INSTALL_FIDO_APP_MSG          @"바이오인증공동앱이 설치되지 않았습니다."
#define XINGAPI_ERROR_CAN_NOT_USE_TOUCHID           -81
#define XINGAPI_ERROR_CAN_NOT_USE_TOUCHID_MSG           @"TouchID가 지원되지 않는 단말입니다."
#define XINGAPI_ERROR_EMPTY_CALLBACK_URL            -82
#define XINGAPI_ERROR_EMPTY_CALLBACK_URL_MSG            @"callbackURL 값을 입력하세요."
#define XINGAPI_ERROR_NOT_ABLE_FIDO_LOGIN           -83
#define XINGAPI_ERROR_NOT_ABLE_FIDO_LOGIN_MSG           @"지문인증 로그인이 일시적으로 정상적이지 않습니다. 반복적으로 로그인이 안되면 공인인증서를 이용해 접속하세요."
#define XINGAPI_ERROR_NOT_REG_PHONE                 -84
#define XINGAPI_ERROR_NOT_REG_PHONE_MSG                 @"지문인증이 등록되지 않은 단말기 입니다. 아이디로 로그인 후 바이오인증센터에서 지문등록 후 이용하세요."
#define XINGAPI_ERROR_NEED_RE_REG_FP                -85
#define XINGAPI_ERROR_NEED_RE_REG_FP_MSG                @"지문정보 변경에 따라 지문 해지 후 재등록이 필요합니다. 공인인증 또는 공동인증 로그인하여 해지 후 재등록해주시기 바랍니다."
#define XINGAPI_ERROR_FIDO_104_ERROR                -86
#define XINGAPI_ERROR_FIDO_104_ERROR_MSG                @"FIDO 응답을 정상적으로 받지 못 했습니다."
#define XINGAPI_ERROR_FIDO_106_ERROR                -87
#define XINGAPI_ERROR_FIDO_106_ERROR_MSG                @"FIDO 데이터가 비어있습니다."
#define XINGAPI_ERROR_FIDO_ADD_OK                   -89
#define XINGAPI_ERROR_FIDO_ADD_OK_MSG                   @"공동 FIDO 등록에 성공하였습니다."
#define XINGAPI_ERROR_FIDO_ADD_FAILE                -90
#define XINGAPI_ERROR_FIDO_ADD_FAILE_MSG                @"공동 FIDO 등록에 실패하였습니다."
#define XINGAPI_ERROR_FIDO_DEL_OK                   -91
#define XINGAPI_ERROR_FIDO_DEL_OK_MSG                   @"FIDO 삭제가 성공하였습니다."
#define XINGAPI_ERROR_FIDO_CANCEL_FAIL              -1203
#define XINGAPI_ERROR_FIDO_CANCEL_FAIL_MSG              @"인증 취소 실패했습니다."
#define XINGAPI_ERROR_FIDO_REG_ERROR                -1302
#define XINGAPI_ERROR_FIDO_REG_ERROR_MSG                @"지문등록 정보에 오류가 있습니다. 지문인증 해지 후 재등록하여 이용해주시기 바랍니다."
#define XINGAPI_ERROR_FIDO_RE_REG_FP                -1402
#define XINGAPI_ERROR_FIDO_RE_REG_FP_MSG                @"바이오인증 공동앱 재설치하면 지문 인증 정보가 초기화되어 지문 재등록이 필요합니다. 공인인증서로 로그인하여 지문 인 해지후 재등록하여 이용하세요."
#define XINGAPI_ERROR_FIDO_CHANGED_FP               -1260
#define XINGAPI_ERROR_FIDO_CHANGED_FP_MSG               @"지문정보 변경에 따라 바이오인증 해지 후 재등록이 필요합니다. 공인인증서로 로그인하여 지문 인증 해지 후 재등록하 이용하세요"
#define XINGAPI_ERROR_CHAIN_2002_ERROR              -100
#define XINGAPI_ERROR_CHAIN_2002_ERROR_MSG             @"접속ID 로그인 후 [공인인증센터] 에서 발급이 가능합니다."
#define XINGAPI_ERROR_CHAIN_LOW_VERSION             -101
#define XINGAPI_ERROR_CHAIN_LOW_VERSION_MSG            @"단말기 버전이 낮아 이용하실 수 없습니다."
#define XINGAPI_ERROR_NOT_INSTALL_CHAIN_ID_APP      -102
#define XINGAPI_ERROR_NOT_INSTALL_CHAIN_ID_APP_MSG     @"공동인증앱이 설치되지 않았습니다."
#define XINGAPI_ERROR_CHAIN_CHECK_CERT_CONTS        -103
#define XINGAPI_ERROR_CHAIN_CHECK_CERT_CONTS_MSG       @"접속 ID 로그인 후 [공인인증센터]에서 공동인증 내역을 확인해 주시기 바랍니다."
#define XINGAPI_ERROR_CHAIN_TROUBLE                 -104
#define XINGAPI_ERROR_CHAIN_TROUBLE_MSG                @"공동인증 장애입니다."
#define XINGAPI_ERROR_CHAIN_NOT_FOUNT_CERT          -105
#define XINGAPI_ERROR_CHAIN_NOT_FOUNT_CERT_MSG         @"사용가능한 공동인증서가 없습니다. 접속 ID 로그인 후 [공동인증센터]에서 발급이 가능합니다"
#define XINGAPI_ERROR_CHAIN_TERMINATED_CERT         -106
#define XINGAPI_ERROR_CHAIN_TERMINATED_CERT_MSG        @"비밀번호 5회 오류로 인행 공동인증이 해지 되었습니다."
#define XINGAPI_ERROR_VERSION_CANT_LOGIN            -107
#define XINGAPI_ERROR_VERSION_CANT_LOGIN_MSG           @"API 모듈 버전이 맞지 않아 로그인 할 수 없습니다."
#define XINGAPI_ERROR_VERSION_USE_NEW_VER           -108
#define XINGAPI_ERROR_VERSION_USE_NEW_VER_MSG          @"최신 버전의 API 모듈을 사용하세요. 반드시 버전을 확인하세요"

#endif /* InoutDefine_h */
