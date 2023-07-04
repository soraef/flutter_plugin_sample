import Flutter
import UIKit
import Alamofire

public class FlutterPluginSamplePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_plugin_sample", binaryMessenger: registrar.messenger())
    let instance = FlutterPluginSamplePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    // result("iOS " + UIDevice.current.systemVersion)
    switch call.method {
    case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)
    case "sumInt":
        let args = call.arguments as! [String: Any]
        let a = args["a"] as! Int
        let b = args["b"] as! Int
        result(a + b)
    case "httpGetStatus":
        let args = call.arguments as! [String: Any]
        let url = args["url"] as! String

        AF.request("https://tech.amefure.com/api/article").response { response in
            do {
               let statusCode = response.response?.statusCode
                result(statusCode)
            } catch {
                result("error: \(error.localizedDescription)")
            }
        }
        // let request = URLRequest(url: URL(string: url)!)
        // let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //     if let error = error {
        //         result("error: \(error.localizedDescription)")
        //     } else if let httpResponse = response as? HTTPURLResponse {
        //         result(httpResponse.statusCode)
        //     }
        // }
        // task.resume()
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}
