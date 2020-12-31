//
//  HSTableViewProtocol.swift
//  MySwiftDemo
//
//  Created by 永芯 on 2019/11/27.
//  Copyright © 2019 永芯. All rights reserved.
//
// 学习协议的使用

import UIKit

public protocol HSTableViewProtocol { }

public extension HSTableViewProtocol {
    
    private func configIdentifier(_ identifier: inout String) -> String {
        var index = identifier.firstIndex(of: ".")
        guard index != nil else { return identifier }
        index = identifier.index(index!, offsetBy: 1)
        identifier = String(identifier[index! ..< identifier.endIndex])
        return identifier
    }
    
    func registerCell(_ tableView: UITableView, _ cellCls: AnyClass) {
        var identifier = NSStringFromClass(cellCls)
        identifier = configIdentifier(&identifier)
        tableView.register(cellCls, forCellReuseIdentifier: identifier)
    }
    func registerNibCell(_ tableView: UITableView, _ cellCls: AnyClass) {
        var identifier = NSStringFromClass(cellCls)
        identifier = configIdentifier(&identifier)
        tableView.register(UINib.init(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    func registerHeaderFooter(_ tableView: UITableView, _ viewCls: AnyClass) {
        var identifier = NSStringFromClass(viewCls)
        identifier = configIdentifier(&identifier)
        tableView.register(viewCls, forHeaderFooterViewReuseIdentifier: identifier)
    }
    func registerNibHeaderFooter(_ tableView: UITableView, _ viewCls: AnyClass) {
        var identifier = NSStringFromClass(viewCls)
        identifier = configIdentifier(&identifier)
        tableView.register(UINib.init(nibName: identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
    }
    func headerFooterWithTableView<T: UIView>(_ tableView: UITableView) -> T {
        var identifier = NSStringFromClass(T.self)
        identifier = configIdentifier(&identifier)
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
//        }
        return cell as! T
    }
    
    func cellWithTableView<T: UITableViewCell>(_ tableView: UITableView) -> T {
        var identifier = NSStringFromClass(T.self)
        identifier = configIdentifier(&identifier)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell!.selectionStyle =  .none
        return cell as! T
    }
    
    func tableViewConfig(_ frame: CGRect ,_ delegate: UITableViewDelegate?, _ dataSource: UITableViewDataSource?, _ style: UITableView.Style?) -> UITableView  {
        let tableView = UITableView(frame: frame, style: style ?? .plain)
//        tableView.backgroundColor = vcBackgroundColor
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.separatorColor = vcBackGreyColor
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
//        tableView.estimatedSectionHeaderHeight = 60
//        tableView.estimatedSectionFooterHeight = 60

        return tableView
    }
}
