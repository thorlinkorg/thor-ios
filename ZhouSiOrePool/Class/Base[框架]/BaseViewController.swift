//
//  BaseViewController.swift
//  MySwiftDemo
//
//  Created by 永芯 on 2019/12/4.
//  Copyright © 2019 永芯. All rights reserved.
//

import UIKit
//import GTMRefresh
import MJRefresh

class BaseViewController: UIViewController {
        
    //    weak var refreshView: UIScrollView?
        
        override func viewDidLoad() {
            super.viewDidLoad()

            DebugLog("进入 \(type(of: self).hs_className)")
            self.view.backgroundColor = vcBackLightGrayColor

        }
        
    //    override func viewWillAppear(_ animated: Bool) {
    //        setNavBackgroundColor(.white)
    //        setNavTintColor(defaultTextColor)
    //    }
        
        // MARK: - Refresh

        // 顶部刷新
        lazy var header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        // 底部刷新
        lazy var footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMore))
         
        var curPage = 1

        func addRefresh(refreshView : UIScrollView) {
            
    //        self.refreshView = refreshView
            header.lastUpdatedTimeLabel?.textColor = textFPlaceholderLabelTextColor
            header.stateLabel?.textColor = textFPlaceholderLabelTextColor
            
            footer.stateLabel?.textColor = textFPlaceholderLabelTextColor
            footer.setTitle("", for: MJRefreshState.init(rawValue: 5)!)
            footer.setTitle("", for: MJRefreshState.init(rawValue: 5)!)
            refreshView.mj_header = self.header
            refreshView.mj_footer = self.footer
            
            
    //        refreshView.mj_footer?.endRefreshingWithNoMoreData()

    //        refreshView.gtm_addRefreshHeaderView { [weak self] in
    //            self?.headerRefresh()
    //        }
    //
    //        refreshView.gtm_addLoadMoreFooterView { [weak self] in
    //            self?.loadMore()
    //        }
            sendNetRequest()
        }

        // 写在 self.curPage += 1 之后
        func mjFooterData(refreshView: UIScrollView, listCount: Int, max:Int = 10) {
            if listCount < max {
                refreshView.mj_footer?.endRefreshingWithNoMoreData()
                if curPage != 1 {
                    curPage -= 1
                }
            } else {
                refreshView.mj_footer?.resetNoMoreData()
            }
            
        }
        
        
        func endRefresh(refreshView : UIScrollView) {
    //        refreshView.endRefreshing()
            if self.curPage == 1 {
                refreshView.mj_header?.endRefreshing()
            }
            refreshView.mj_footer?.endRefreshing()
        }
        
        @objc func headerRefresh() {
            curPage = 1
            sendNetRequest()
        }
        @objc func loadMore(){
            sendNetRequest()
        }
        
        func sendNetRequest() {
            
        }
        
        func hide_showEmptyView(_ tableView:UIScrollView,_ count:Int){
            if count == 0{
                tableView.ly_showEmptyView()
            }else{
                tableView.ly_hideEmptyView()
            }
             
        }
        
        
        //自定义空数据界面显示
        func setupMyEmptyView(tableView : UIScrollView)  {
              let emptyV:HDEmptyView = HDEmptyView.emptyActionViewWithImageStr(imageStr: "no_data_tip", titleStr: "暂无数据", detailStr: "", btnTitleStr: "") {
                     print("点击刷新按钮")
                 }
            emptyV.backgroundColor = .clear
            emptyV.contentViewOffset = -100
            emptyV.titleLabFont = UIFont.systemFont(ofSize: 18)
            emptyV.titleLabTextColor = UIColor.init(0x999999)
            emptyV.autoShowEmptyView = false
            tableView.ly_emptyView = emptyV
                 
                 tableView.ly_emptyView?.tapContentViewBlock = {
                     print("点击界面空白区域")
                 }
                 tableView.ly_endLoading()
        }
        
        
        // MARK: - 状态栏

        ///在需要修改的地方直接给ifStatusBarHidden赋值
        var ifStatusBarHidden = false {
            didSet {
                setNeedsStatusBarAppearanceUpdate()
            }
        }
        ///在需要修改的控制器中重写下面方法
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .default
        }
        
        override var prefersStatusBarHidden: Bool {
            return ifStatusBarHidden
        }
        
        deinit {
            DebugLog("\(type(of: self).hs_className) 销毁了")
        }

    }

    extension BaseViewController {
        
    // MARK: - 添加导航按钮  下次使用闭包处理导航按钮回调
        
        func addRightNavItem(_ title: String) {
            //按钮间的空隙
    //        let space = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil,action: nil)
    //        space.width = 15;
            let barButtonItem = UIBarButtonItem.init(title: title, style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickRightItem))
            barButtonItem.tintColor = .black
            self.navigationItem.rightBarButtonItem = barButtonItem
        }
        
        func addRightNavImgItem(_ name: String) {
            let img = UIImage(named: name)?.withRenderingMode(.alwaysOriginal)
            let barButtonItem = UIBarButtonItem.init(image: img, style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickRightItem))
            self.navigationItem.rightBarButtonItem = barButtonItem
        }
        
        func addLeftNavItem(_ title: String) {
            let barButtonItem = UIBarButtonItem.init(title: title, style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickLeftItem))
            barButtonItem.tintColor = defaultTextColor
            self.navigationItem.leftBarButtonItem = barButtonItem
        }
        
        func addLeftNavImgItem(_ name: String) {
            let img = UIImage(named: name)?.withRenderingMode(.alwaysOriginal)
            let barButtonItem = UIBarButtonItem.init(image: img, style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickLeftItem))
            self.navigationItem.leftBarButtonItem = barButtonItem
        }
        
        func addLeftNavImgsItem(_ name: String,_ nameT: String) {
            let img = UIImage(named: name)?.withRenderingMode(.alwaysOriginal)
            let imgT = UIImage(named: nameT)?.withRenderingMode(.alwaysOriginal)
    //        let barButtonItem = UIBarButtonItem.init(image: img, style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickLeftItem))
    //        let barButtonItemT = UIBarButtonItem.init(image: imgT, style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickLeftItem))
            let bview = UIView.init(frame: CGRect(x: 0, y: 0, width: 82, height: kStatusBarHeight))
            let btn1 = UIButton.init(frame: CGRect(x: 0, y: 0, width: 15, height: kStatusBarHeight))
            let btn2 = UIButton.init(frame: CGRect(x: 20, y: 0, width: 62, height: kStatusBarHeight))
            btn1.addTarget(self, action: #selector(clickLeftItem), for: .touchUpInside)
            btn2.addTarget(self, action: #selector(clickLeftItem), for: .touchUpInside)
            btn1.setImage(img, for: .normal)
            btn2.setImage(imgT, for: .normal)
            bview.addSubview(btn1)
            bview.addSubview(btn2)
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: bview)
    //        self.navigationItem.leftBarButtonItems = [barButtonItem,barButtonItemT]
        }
        
        @objc func clickRightItem() {
    //        DebugLog("BaseViewController clickRightItem")
        }
        
        @objc func clickLeftItem() {
    //        DebugLog("BaseViewController clickLeftItem")
            if self.navigationController?.topViewController == self {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
            
        
        /// 设置导航栏背景色
        func setNavBackgroundColor(_ color: UIColor) {
            if color == UIColor.clear {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: .any, barMetrics: .default)
            }else{
                let backImg = UIImage.imageFromColor(color:color, viewSize: CGSize(width: kScreenWidth, height: 1))
                self.navigationController?.navigationBar.setBackgroundImage(backImg, for: .any, barMetrics: .default)

            }
    //        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        }
        /// 设置导航栏字体颜色
        func setNavTintColor(_ color: UIColor) {
            let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: color]
            navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : Any]
    //        navigationController?.navigationBar.tintColor = color
            if self.navigationController?.viewControllers.count ?? 1 > 1 {
                
            }
            
        }

    }

