//
//  UIView+HSExtension.swift
//  HSEther
//
//  Created by 永芯 on 2019/8/20.
//  Copyright © 2019 com.houshuai. All rights reserved.
//

//import Foundation
import UIKit

extension UIView {
    //获取视图的X坐标
    public var x:CGFloat{
        get{ return self.frame.origin.x }
        set{
            var frames = self.frame;
            frames.origin.x = newValue
            self.frame = frames;
        }
    }
    
    //获取视图的Y坐标
    public var y:CGFloat{
        get{ return self.frame.origin.y }
        set{
            var frames = self.frame;
            frames.origin.y = newValue
            self.frame = frames;
        }
    }
    var size:CGSize{
        get{ return self.frame.size }
        set{
            self.frame.size = newValue
        }
    }
    //获取视图的宽
    public var width:CGFloat{
        get{ return self.frame.size.width }
        
        set{
            var frames = self.frame;
            frames.size.width = newValue
            self.frame = frames;
        }
    }
    
    //获取视图的高
    public var height:CGFloat{
        get{ return self.frame.size.height }
        
        set{
            var frames = self.frame;
            frames.size.height = newValue
            self.frame = frames;
        }
    }
    
    //获取最大的y坐标
    public var bottom:CGFloat{
        get{ return self.y + self.height }
        
        set{
            var frames = self.frame;
            frames.origin.y = CGFloat(newValue - self.height)
            self.frame = frames;
        }
    }
    
    //获取最大的X坐标
    public var right:CGFloat{
        get{ return self.x + self.width }
        
        set{
            var frames = self.frame;
            frames.origin.x = CGFloat(newValue - self.width)
            self.frame = frames;
        }
    }
    
    //中心点X坐标
    public var centerX:CGFloat{
        get{ return self.center.x }
        set{
            self.center = CGPoint(x:CGFloat(newValue),y:self.center.y)
        }
    }
    
    //中心点Y坐标
    public var centerY:CGFloat{
        get{ return self.center.y }
        set{
            self.center = CGPoint(x:self.center.x,y:newValue)
        }
    }
    


}

extension UIView {
    
    // MARK: - layer 尺寸裁剪相关
    /// 添加圆角  radius: 圆角半径  UILabel, UIView, UITextField, UIImageView 不产生产生离屏渲染
    @IBInspectable public var radius:CGFloat{
        get{
            return self.layer.cornerRadius;
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
    /// 添加圆角  radius: 圆角半径  masksToBounds = true 会触发离屏渲染
    @IBInspectable public var radiusBounds:CGFloat{
        get{ return self.layer.cornerRadius }
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    /// 添加部分圆角(有问题右边切不了) corners: 需要实现为圆角的角，可传入多个 radius: 圆角半径
    func addRounded(radius:CGFloat, corners: UIRectCorner) {
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
            self.layer.masksToBounds = true

        } else {
            let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer;
        }
    }
    // MARK: - 添加边框
    
    /// 添加边框
    /// - Parameter width: 边框宽度 默认黑色
    func addBorder(width : CGFloat) { // 黑框
        self.layer.borderWidth = width;
        self.layer.borderColor = UIColor.black.cgColor;
    }
    
    /// 添加边框 width: 边框宽度 borderColor:边框颜色
    func addBorder(width : CGFloat, borderColor : UIColor) { // 颜色自己给
        self.layer.borderWidth = width;
        self.layer.borderColor = borderColor.cgColor;
    }

    /// 添加圆角和阴影
    /// - Parameters:
    ///   - offset: 当width为正数时，向右偏移，为负数时，向左偏移,当height为正数时，向下偏移，为负数时，向上偏移
    func addRoundedOrShadow(radius:CGFloat, offset:CGSize, color: UIColor = .lightGray)  {
        self.layer.cornerRadius = radius
        self.layer.shadowColor = color.cgColor

        self.layer.shadowOpacity = 0.2 // 不透明度
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
    }
    
    /// 绘制虚线
    func drawDashLine(_ strokeColor: UIColor, lineWidth: CGFloat = 1, lineLength: Int = 5, lineSpacing: Int = 5) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        
        //每一段虚线长度 和 每两段虚线之间的间隔
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        
        let path = CGMutablePath()
//        let y = lineView.layer.bounds.height - lineWidth
        let x = self.layer.bounds.width - lineWidth
        path.move(to: CGPoint(x: x, y: 0))
        path.addLine(to: CGPoint(x: x, y: self.layer.bounds.height))
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    

    //MARK: - uiview转uiimage
    func getImageFromView() -> UIImage {
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        self.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

extension UIView {
    /// 删除所有的子视图
    func removeAllSubView() -> Void {
        for view : UIView in self.subviews{
            view.removeFromSuperview();
        }
    }
    ///通过响应者链获取当前视图所在的控制器
    func viewController() -> UIViewController? {
        var next = self.next
        repeat{
            if next is UIViewController {
                return next as? UIViewController
            }
            next = next?.next
        } while next != nil
        return nil
    }
    
    //MARK:- ***** Private tapGesture *****
    
    func addTapGes(action:@escaping (_ view: UIView) -> ()) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureAction))
        self.isUserInteractionEnabled = true
        self.action = action
        self.addGestureRecognizer(gesture)
    }
    
    typealias addBlock = (_ view: UIView) -> Void
    private struct AssociatedKeys {
        static var actionKey = "actionBlock"
    }
    private var action: addBlock? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? addBlock
        }
        set (newValue){
            objc_setAssociatedObject(self, &AssociatedKeys.actionKey, newValue!, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    @objc private func tapGestureAction(sender: UITapGestureRecognizer) {
        guard let actionBlock = self.action else {
            return
        }
        
        if sender.state == .ended {
            actionBlock(self)
        }
    }
    
    ///      Demo： UIView.loadFromNib(XXView)
    class func loadFromNib<T>(_ aClass: T.Type) -> T {
        let name = String(describing: aClass)
        if Bundle.main.path(forResource: name, ofType: "nib") != nil {
            return UINib(nibName: name, bundle:nil).instantiate(withOwner: nil, options: nil)[0] as! T
        } else {
            fatalError("\(String(describing: aClass)) nib is not exist")
        }
    }

    
}

extension UIView {
    
    //MARK:- ***** 加红点 *****
    
    private struct BadgeViewKeys {
        static var badgeViewKey = "badgeViewKey"
    }
    
    func showBadge(top magin:CGFloat) {
        if self.badge == nil {
            let pointWidth : CGFloat = 6
            badge = UIView.init(frame: CGRect(x: self.bounds.width, y: magin, width: pointWidth, height: pointWidth))
//            badge?.backgroundColor = UIColor.init(hex: 0xff5153)
            badge?.radius = pointWidth/2.0
            self.addSubview(badge!)
            self.bringSubviewToFront(badge!)
        }
    }
    func hidenBadge() {
        self.badge?.removeFromSuperview()
    }
    
    private var badge: UIView? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &(BadgeViewKeys.badgeViewKey), newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
        get {
            return objc_getAssociatedObject(self, &(BadgeViewKeys.badgeViewKey)) as? UIView
        }
    }

}

// 协议
protocol NibLoadable {
    // 具体实现写到extension内
}
// 加载nib
extension NibLoadable where Self : UIView {
    static func loadFromNib(_ nibname : String? = nil) -> Self {
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}
