import UIKit
import Flutter
import XingAPIMobile

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, XingAPIDelegate {
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let platformChannel = FlutterMethodChannel(name: "com.itlabxor.soup/xingapi", binaryMessenger: controller.binaryMessenger)
    platformChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
      // Handle battery messages.
    })

    let eBESTAPI: XingAPI = XingAPI.getInstance()
    eBESTAPI.initAPI()
    eBESTAPI.setNetworkDelegate(self)

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

