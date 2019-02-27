//
//  BaseVC.swift
//  DemoiOSTask
//
//  Created by Snehal Garbhe on 27/02/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    class func vcFactory(_ SB: String, SBVC: String) -> UIViewController {
        return UIStoryboard(name: SB, bundle: nil).instantiateViewController(withIdentifier: SBVC)
    }
}


