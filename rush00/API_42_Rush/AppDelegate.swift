//
//  AppDelegate.swift
//  API_42_Rush
//
//  Created by Quentin MOINAT on 1/13/18.
//  Copyright © 2018 Quentin MOINAT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let key = "96f2a961af427fff5a6a431e1c6b085316c107bfece732b313ff2076320c2f8b"
    let secret = "82c83d5c99c23bb0846483aa263aff62affceafd8fca9b041852fefdb76063dc"

    var window: UIWindow?
    var token : String!
    var id_user: String!
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let urlPath : String = url.path as String!
        
         if(urlPath == "/inner"){
            let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
            for queryItem in (components?.queryItems!)! {
                if queryItem.name == "code" {
                    if let code = queryItem.value {
                        //print(code)
                        APITokenRequest(code)
                    }
                }
            }
        }
        else if (urlPath == "/about") {
            print("Error about")
        }
        
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func APITokenRequest(_ code: String)
    {
        let url = "https://api.intra.42.fr/oauth/token"
        let callbackUrl = "apprushurlequivalent%3A%2F%2Fhost%2Finner"
        let params: String = "?grant_type=authorization_code&client_id=" + key + "&client_secret=" + secret + "&code=" + code + "&redirect_uri=" + callbackUrl
        let request = NSMutableURLRequest(url: (URL(string : url + params) as! URL))
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: d, options: []) as! NSDictionary {
                        //print(json["access_token"]!)
                            self.token = json["access_token"]! as! String
                            self.APIUserRequest(json["access_token"]! as! String)
                        }
                    DispatchQueue.main.async {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        //                            let innerPage: InnerPageViewController = mainStoryboard.instantiateViewController(withIdentifier: "InnerPageViewController") as! InnerPageViewController
                        let innerPage: StartNavigationController = mainStoryboard.instantiateViewController(withIdentifier:"StartNavigationController") as! StartNavigationController
                        
                        //                            innerPage.token = json["access_token"]! as! String
                        self.window?.rootViewController = innerPage
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    func APIUserRequest(_ token: String)
    {
        let url = "https://api.intra.42.fr/v2/me?access_token=" + token
        let request = NSMutableURLRequest(url: (URL(string : url) as! URL))
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: d, options: []) as! NSDictionary {
                        print("APIUserRequest: id=\(json["id"]!)")
                        self.id_user = String(describing: json["id"]!)
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

