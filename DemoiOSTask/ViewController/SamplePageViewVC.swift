//
//  SamplePageViewVC.swift
//  DemoiOSTask
//
//  Created by Snehal Garbhe on 2/23/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import Foundation
import UIKit

class SamplePageViewVC: UIViewController {

    var dataSetArr: [DataSetModel] = [DataSetModel(title: "This is title", description: "This is short description", points: """
this is long long long long long long long long long long long long long description
1
▪ this is long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long description also, with url http://cmile.in
▪ this is long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long description 3
▪ this is long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long long long long long long long long long long long
long long long long long long description 4
"""),DataSetModel(title: "Title 2", description: "Below there is image", points: "https://cdn.lifehack.org/wp-content/uploads/2016/12/08230522/best-motivational-quotes-dont-limit-challenges.png"),DataSetModel(title: "Last One", description: "How's the josh?", points: "https://www.youtube.com/embed/mj2asf2to7k")]

    private var pageController = UIPageViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        pageController = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.pageCurl, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: [:])
        pageController.delegate = self
        pageController.dataSource = self
        
        let viewCOntrollr = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sampleVCID") as! SampleListVC
        viewCOntrollr.titleStr = self.dataSetArr.first?.title
        viewCOntrollr.modelType = .genralCellType
        viewCOntrollr.model = self.dataSetArr.first
        pageController.setViewControllers([viewCOntrollr], direction: .forward, animated: false, completion: nil)
        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.didMove(toParent: self)
    }
    
}

extension SamplePageViewVC: UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let modelObj = (viewController as? SampleListVC)?.model
        let currentIndex = dataSetArr.index(where: { $0.title == modelObj?.title })
        if currentIndex! > 0 {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sampleVCID") as! SampleListVC
            vc.model = self.dataSetArr[currentIndex!-1]
            vc.titleStr = self.dataSetArr[currentIndex!-1].title
            return vc
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let modelObj = (viewController as? SampleListVC)?.model
        let currentIndex = dataSetArr.index(where: { $0.title == modelObj?.title })
        if currentIndex! < self.dataSetArr.count - 1 {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sampleVCID") as! SampleListVC
            vc.model = self.dataSetArr[currentIndex!+1]
            vc.titleStr = self.dataSetArr[currentIndex!+1].title
            return vc
        }
        
        return nil
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return (dataSetArr.count)
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
