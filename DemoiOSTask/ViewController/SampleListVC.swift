//
//  SampleListVC.swift
//  DemoiOSTask
//
//  Created by Snehal Garbhe on 2/23/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


enum ModelType {
    case genralCellType
    case imageCellType
    case videoCellType
}

class SampleListVC: UIViewController {
    
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var sampleTableView: UITableView!
    
    let colorArr: [UIColor] = [UIColor.init(hexString: "fb2631"),UIColor.init(hexString: "00f9ff"),UIColor.init(hexString: "89c503"),UIColor.init(hexString: "f0ff00")]
    var modelType: ModelType = .genralCellType
    var model : DataSetModel?
    var titleStr : String?
    var strArr = [String]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.updateUI()
    }
    
    private func updateUI() {

        DispatchQueue.main.async {
            
            if self.canOpenURL(self.model?.points) {
                if self.isValidYoutubeLink(urlStr: self.model?.points ?? "") {
                    self.modelType = .videoCellType
                }else {
                    self.modelType = .imageCellType
                }
            } else {
                let strArr = self.model?.points!.split(separator: "▪")
                for item in strArr! {
                    self.strArr.append(String(item))
                }
                self.modelType = .genralCellType
            }
  
            self.navItem.title = self.titleStr
            self.sampleTableView.isHidden = false
            self.sampleTableView.delegate = self
            self.sampleTableView.dataSource = self
            self.sampleTableView.estimatedRowHeight = 60
            self.sampleTableView.rowHeight = UITableView.automaticDimension
            self.sampleTableView.reloadData()
        }

    }
    
    private func isValidYoutubeLink(urlStr: String) -> Bool {
        var isValid = false
        if let url = URL(string: urlStr) {
            if url.absoluteString.range(of: "youtube.com") != nil {
                isValid = true
            }
        }
        return isValid
    }
    
}

extension SampleListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.model?.description
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.modelType == .genralCellType {
            return self.strArr.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       
        if self.modelType == .genralCellType {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as? TextCell else {
                return TextCell()
            }
            cell.textLbl?.numberOfLines = 0
            cell.textLbl?.lineBreakMode = .byWordWrapping
            cell.textLbl?.text = self.strArr[indexPath.row]
            cell.textLbl.backgroundColor = .clear
            DispatchQueue.main.async {
                cell.cardVW?.backgroundColor =  self.colorArr[indexPath.row]
            }

            return cell

        } else if self.modelType == .imageCellType {
                guard let imgcell = tableView.dequeueReusableCell(withIdentifier: "ImgCellID") as? ImageCell else {
                    return ImageCell()
                }
            
                imgcell.imgView.kf.setImage(with: URL(string: (self.model?.points)!))
                return imgcell
                
        } else {
            guard let videoCell = tableView.dequeueReusableCell(withIdentifier: "VideoCellID") as? VideoCell else {
                return VideoCell()
            }
            
            let url = URL(string: (self.model?.points)!)
            DispatchQueue.main.async {
                videoCell.wkWebKit.load(URLRequest(url: url!))
                videoCell.wkWebKit.contentMode = .scaleAspectFit
            }
            
            return videoCell
        }
       

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if self.modelType == .genralCellType {
            return UITableView.automaticDimension
        }else {
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
      
        if self.modelType == .genralCellType {
            return UITableView.automaticDimension
        }else {
            return 300
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func canOpenURL(_ string: String?) -> Bool {
        guard let urlString = string,
            let url = URL(string: urlString)
            else { return false }
        
        if !UIApplication.shared.canOpenURL(url) { return false }
        
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
}

