//
//  AppDelegate.swift
//  Continuum
//
//  Created by DevMountain on 2/11/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    checkAccountStatus { (success) in
      let fetchedUserStatment = success ? "Successfully retrieved a logged in user" : "Failed to retrieve a logged in user"
       print(fetchedUserStatment)
    }
    return true
  }

  func checkAccountStatus(completion: @escaping (Bool) -> Void) {
    CKContainer.default().accountStatus { (status, error) in
      if let error = error {
        print("Error accountStatus \(error) \(error.localizedDescription)")
        completion(false); return
      } else {
        DispatchQueue.main.async {
          let tabBarController = self.window?.rootViewController
          let errrorText = "Sign into iCloud"
          switch status {
          case .available:
            completion(true);
          case .noAccount:
            tabBarController?.presentSimpleAlertWith(title: errrorText, message: "Couldn't  find account")
            completion(false)
          case .couldNotDetermine:
            tabBarController?.presentSimpleAlertWith(title: errrorText, message: "There was an error fetching Account")
            completion(false)
          case .restricted:
            tabBarController?.presentSimpleAlertWith(title: errrorText, message: "This account is restricted")
            completion(false)
          }
        }
      }
    }
  }
}
