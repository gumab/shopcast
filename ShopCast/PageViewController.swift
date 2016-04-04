//
//  PageViewController.swift
//  ShopCast
//
//  Created by guma on 2016. 2. 11..
//  Copyright © 2016년 Guma. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var userNo:Int!
    var userName:String!
    var pageViewController:UIPageViewController!
    var pageTitles:NSArray!
    var imageFiles:NSArray!
    var nextIndex:Int!
    @IBOutlet var panRecognizer: UIPanGestureRecognizer!
    var currentIndex:Int! = 0
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var subView: UIView!
    
    
    @IBAction func swipeDown(sender: AnyObject) {
        //self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func panAction(sender: AnyObject) {
        NSLog("%f / %f",panRecognizer.velocityInView(self.view).x, panRecognizer.velocityInView(self.view).y)
        //panRecognizer.
        
        //let redis = Swidis()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        let startVC = self.viewControllerAtIndex(0) as PageContentViewController
        let viewControllers = NSArray(object: startVC)
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 0,self.subView.frame.width, self.subView.frame.size.height)
        self.addChildViewController(self.pageViewController)
        self.subView.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }

    @IBAction func closeAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func viewControllerAtIndex(index:Int)-> PageContentViewController{
        if((self.pageTitles.count == 0)||(index>=self.pageTitles.count)){
            return PageContentViewController()
        }
        
        let vc:PageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController
        
        vc.titleText = pageTitles[index] as! String
        vc.imageFile = imageFiles[index] as! String
        vc.pageIndex = index
        refreshPage()
        return vc
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        
        if(index == 0 || index == NSNotFound){
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        
        if(index == NSNotFound || index == self.pageTitles.count - 1){
            return nil
        }
        
        index++
        return self.viewControllerAtIndex(index)
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        let controller:PageContentViewController = pendingViewControllers.first as! PageContentViewController
        //self.nextIndex = self.pageViewController.childViewControllers.indexOf(controller)
        self.nextIndex = controller.pageIndex
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if(completed){
            self.currentIndex = self.nextIndex
            NSLog((currentIndex as NSNumber).stringValue)
            refreshPage()
        }
        self.nextIndex = 0
    }
    
    func refreshPage(){
        self.textView.text = pageTitles[self.currentIndex] as! String
    }
}
