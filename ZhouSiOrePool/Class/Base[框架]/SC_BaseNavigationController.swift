//
//  SC_BaseNavigationController.swift
//  SwiftNavigation&TabBar
//
//  Created by odin on 2020/9/22.
//
import UIKit

class SC_BaseNavigationController: UINavigationController, UINavigationControllerDelegate {

    var arrayScreenshot = [UIImage]()
    var popDelegate:UIGestureRecognizerDelegate?
//    var webURL : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
//        self.navigationBar.isTranslucent = true
        //背景颜色
        self.navigationBar.setBackgroundImage(UIImage.imageFromColor(color: UIColor.white, viewSize: CGSize(width: kScreenWidth, height: 1)), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        
        //设置底部线的颜色
        self.navigationBar.shadowImage = UIImage()
        
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.init(ciColor: .black)]
        self.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : Any]
        
      //返回手势
             self.popDelegate = self.interactivePopGestureRecognizer?.delegate
             self.delegate = self
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
     // UIGestureRecognizerDelegate代理
        func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
            //实现滑动返回的功能
            //清空滑动返回手势的代理就可以实现
            if viewController == self.viewControllers[0]{
                self.interactivePopGestureRecognizer?.delegate = self.popDelegate
            }else{
                self.interactivePopGestureRecognizer?.delegate = nil
            }
        }
            
    //    拦截跳转事件
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            if self.children.count > 0{
                viewController.hidesBottomBarWhenPushed = true
                viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_icon"), style: .plain, target: self, action: #selector(navigationBack))
            }
            super.pushViewController(viewController, animated: true)
        }
        /// 返回上一控制器
        @objc private func navigationBack() {
            popViewController(animated: true)
        }
    
        
        
        /// 调用setNeedsStatusBarAppearanceUpdate时，系统会调用容器控制器即根视图的preferred方法，一般我们用UINavigationController或UITabBarController做根视图容器时，系统根本就不会调用子视图控制器(UIViewController)方法，自定义导航控制器，重写下面方法：

        override var childForStatusBarStyle: UIViewController? { // 状态栏颜色
            return self.topViewController
        }
           
        override var childForStatusBarHidden: UIViewController? { // 状态栏隐藏与否
            return self.topViewController
        }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
       

    
    
    
    
}
