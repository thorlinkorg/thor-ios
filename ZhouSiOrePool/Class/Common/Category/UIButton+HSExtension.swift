//
//  UIButton+HSExtension.swift
//  HSEther
//
//  Created by 永芯 on 2019/8/20.
//  Copyright © 2019 com.houshuai. All rights reserved.
//

import UIKit

/// 按钮点击间隔时间，防止重复点击
private var _interval: TimeInterval = 0.5

/**
 UIButton图像文字同时存在时---图像相对于文字的位置
 - top:    图像在上
 - left:   图像在左
 - right:  图像在右
 - bottom: 图像在下
 */
enum ButtonImageEdgeInsetsStyle:Int {
    case top, left, right, bottom
}
// MARK: - 快速设置按钮 并监听点击事件

typealias buttonClick = (()->()) // 定义数据类型(其实就是设置别名)

extension UIButton{
    
    /// 快速创建
    convenience init(action:@escaping buttonClick){
         self.init()
         self.addTarget(self, action:#selector(tapped(button:)) , for:.touchUpInside)
         self.actionBlock = action
         self.sizeToFit()
    }
    convenience init(setImage:String, action:@escaping buttonClick){
        self.init()
        self.frame = frame
        self.setImage(UIImage(named:setImage), for: .normal)
        self.addTarget(self, action:#selector(tapped(button:)) , for:.touchUpInside)
        self.actionBlock = action
        self.sizeToFit()
    }
    convenience init(frame: CGRect = .zero, font: UIFont = .systemFont(ofSize: 17), text: String? = nil, textColor: UIColor? = nil ,action:@escaping buttonClick) {
        self.init(frame: frame)
        titleLabel?.font = font
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
        self.addTarget(self, action:#selector(tapped(button:)) , for:.touchUpInside)
        self.actionBlock = action
//        self.sizeToFit()
    }
    
    /// 设置image 位置和文字间距
    func imagePosition(at style: ButtonImageEdgeInsetsStyle, space: CGFloat) {
        guard let imageV = imageView else { return }
        guard let titleL = titleLabel else { return }
        //获取图像的宽和高
        let imageWidth = imageV.frame.size.width
        let imageHeight = imageV.frame.size.height
        //获取文字的宽和高
        let labelWidth  = titleL.intrinsicContentSize.width
        let labelHeight = titleL.intrinsicContentSize.height
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        //UIButton同时有图像和文字的正常状态---左图像右文字，间距为0
        switch style {
        case .left:
            //正常状态--只不过加了个间距
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
        case .right:
            //切换位置--左文字右图像
            //图像：UIEdgeInsets的left是相对于UIButton的左边移动了labelWidth + space * 0.5，right相对于label的左边移动了-labelWidth - space * 0.5
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space * 0.5, bottom: 0, right: -labelWidth - space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space * 0.5, bottom: 0, right: imageWidth + space * 0.5)
        case .top:
            //切换位置--上图像下文字
            /**图像的中心位置向右移动了labelWidth * 0.5，向上移动了-imageHeight * 0.5 - space * 0.5
             *文字的中心位置向左移动了imageWidth * 0.5，向下移动了labelHeight*0.5+space*0.5
             */
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: imageHeight + space, left: -imageWidth, bottom: 0, right: 0)
        case .bottom:
            //切换位置--下图像上文字
            /**图像的中心位置向右移动了labelWidth * 0.5，向下移动了imageHeight * 0.5 + space * 0.5
             *文字的中心位置向左移动了imageWidth * 0.5，向上移动了labelHeight*0.5+space*0.5
             */
            imageEdgeInsets = UIEdgeInsets(top: labelHeight * 0.5 + space * 0.5, left: labelWidth * 0.5, bottom: -labelHeight * 0.5 - space * 0.5, right: -labelWidth * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight * 0.5 - space * 0.5, left: -imageWidth * 0.5, bottom: imageHeight * 0.5 + space * 0.5, right: imageWidth * 0.5)
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
    
    // MARK: - button 点击事件

    private struct AssociatedKeys {
        static var countKey = "btn_countTime"
        static var timerKey = "btn_sourceTimer"
        static var actionKey = "btn_actionKey"
        static var isIgnoreEventKey = "btn_isIgnoreEventKey"
    }
    
    public class func startIntervalAction(interval: TimeInterval) {
        _interval = interval
        DispatchQueue.once(token: #function) {
            exchangeMethod(targetSel: #selector(sendAction), newSel: #selector(re_sendAction))
        }
    }
    @objc private func re_sendAction(action: Selector, to target: AnyObject?, forEvent event: UIEvent?) {
        if self.isKind(of: UIButton.classForCoder()) {
            if self.isIgnoreEvent {
                return
            } else {
                self.perform(#selector(self.resetIgnoreEvent), with: nil, afterDelay: _interval)
            }
        }
        self.isIgnoreEvent = true
        self.re_sendAction(action: action, to: target, forEvent: event)
        
    }
    
    @objc private func resetIgnoreEvent() {
        self.isIgnoreEvent = false;
    }
    
    private var isIgnoreEvent: Bool! {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.isIgnoreEventKey) as? Bool) ?? false
        }
        set (newValue){
            objc_setAssociatedObject(self, &AssociatedKeys.isIgnoreEventKey, newValue!, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    
    // MARK: - button block

    // 改进写法【推荐】
    private struct RuntimeKey {
        static let actionBlock = UnsafeRawPointer.init(bitPattern: "actionBlock".hashValue)
        /// ...其他Key声明
    }
    /// 运行时关联
    private var actionBlock: buttonClick? {
        set {
            objc_setAssociatedObject(self, UIButton.RuntimeKey.actionBlock!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, UIButton.RuntimeKey.actionBlock!) as? buttonClick
        }
    }
     /// 点击回调
    @objc func tapped(button:UIButton){
        if self.actionBlock != nil {
            self.actionBlock!()
        }
    }
    
}

// MARK: - 倒计时
extension UIButton{
    // MARK:倒计时 count:多少秒 默认倒计时的背景颜色gray
    /// 倒计时 count:多少秒 默认倒计时的背景颜色gray
    public func countDown(count: Int){
        self.countDown(count: count, countDownBgColor: .white)
    }
    // MARK:倒计时 count:多少秒 countDownBgColor:倒计时背景颜色
    /// 倒计时 count:多少秒 countDownBgColor:倒计时背景颜色
    public func countDown(count: Int,countDownBgColor:UIColor){
        // 倒计时开始,禁止点击事件
        isEnabled = false
        // 保存当前的背景颜色
        let defaultColor = self.backgroundColor
        // 设置倒计时,按钮背景颜色
        backgroundColor = countDownBgColor
        var remainingCount: Int = count {
            willSet {
                self.titleLabel?.text = "\(newValue)S"
                setTitle("\(newValue)S", for: .normal)
                if newValue <= 0 {
                    self.titleLabel?.text = "获取验证码"
                    setTitle("获取验证码", for: .normal)
                }
            }
        }
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        codeTimer.setEventHandler(handler: {
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                // 每秒计时一次
                remainingCount -= 1
                // 时间到了取消时间源
                if remainingCount <= 0 {
                    self.backgroundColor = defaultColor
                    self.isEnabled = true
                    codeTimer.cancel()
                }
            }
        })
        // 启动时间源
        codeTimer.resume()
    }
}
