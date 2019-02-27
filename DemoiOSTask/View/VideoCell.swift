//
//  VideoCell.swift
//  DemoiOSTask
//
//  Created by Snehal Garbhe on 2/23/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import UIKit
import WebKit


class VideoCell: UITableViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var wkWebKit: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wkWebKit.navigationDelegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
 
}

extension VideoCell : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showActivityIndicator()

    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         self.hideActivityIndicator()
    }
    
    
    //MARK:- show Hide Activity Indicator
    
    private func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.activityIndicator.hidesWhenStopped = false
        }
    }
    
    private func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
        }
    }
    
}
