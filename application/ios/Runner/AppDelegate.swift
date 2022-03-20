import UIKit
import Flutter
import XingAPIMobile

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, XingAPIDelegate {
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let eBESTAPI: XingAPI = XingAPI.getInstance()
        eBESTAPI.initAPI()
        eBESTAPI.setNetworkDelegate(self)
        var m_apihandle = eBESTAPI.initView(self, name:"AppDelegate")

        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let platformChannel = FlutterMethodChannel(name: "com.itlabxor.soup/xingapi", binaryMessenger: controller.binaryMessenger)
        platformChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              switch(call.method) {
                case "loginEbestSign":
                  if m_apihandle > 0 {
                      var loginData = LOGIN_DATA(m_apihandle, connect_server: SERVER_TYPE.API_SERVER)
                      loginData.showLoginView = true
                      
                      let pubCertList = eBESTAPI.getSignList();
                      if pubCertList.count > 0 {
                          loginData.pubCertIdx = 0
                          loginData.pubCertPwd = ""
                          loginData.showLoginView = false
                          eBESTAPI.login(controller, loginData: loginData)
                          
                      } else {
                          if loginData.showLoginView {
                              //1. 공인인증 로그인 화면
                              eBESTAPI.login(controller, loginData: loginData)
                          } else {
                              //2. 인증서 가져오기
                              eBESTAPI.copyPubCert(controller, handle: m_apihandle)
                          }
                      }
                  }

                  result(true)
              default:
                  break;
            }
        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    //연결종료
    func onDisconnect() {
        print("onDisconnect");
    }

    //연결시도
    func onRetryConnnect(_ count: Int) {
        print("onRetryConnnect : \(count)");
    }

    func onReceiveData(_ data: ReceiveData!) {
    }

    func onReceiveMessage(_ msg: ReceiveMessage!) {
    }

    func onReceiveError(_ msg: ReceiveMessage!) {
    }

    func onReleaseData(_ rqID: Int, code: String!) {
    }

    func onTimeOut(_ rqID: Int, code: String!) {
    }

    func onReceiveRealData(_ bcCode: String!, key: String!, data: Data!) {
    }
}

