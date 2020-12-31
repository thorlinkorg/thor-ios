//
//  UIImage+HSExtension.swift
//  MySwiftDemo
//
//  Created by 永芯 on 2019/12/5.
//  Copyright © 2019 永芯. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 图片压缩
    func compactScale() -> UIImage {
        let imageSize = self.size //取出要压缩的image尺寸
        var width = imageSize.width
        var height = imageSize.height

        //1.宽高大于800(宽高比不按照2来算，按照1来算)
        if width > 800 || height > 800 {
            if width > height {
                let scale = height/width
                width = 800;
                height = width*scale
            }else{
                let scale = width/height
                height = 800;
                width = height*scale
            }
        //2.宽大于800高小于800
        }
        else if width > 800 || height < 800 {
            let scale = height/width
            width = 800
            height = width*scale
            //3.宽小于800高大于800
        }
        else if width < 800 || height > 800 {
            let scale = width/height
            height = 800
            width = height*scale
            //4.宽高都小于800
        }else{
        }
        //进行尺寸重绘
        UIGraphicsBeginImageContext(CGSize.init(width: width, height: height))
        self.draw(in: CGRect.init(x: 0, y: 0, width: width, height: height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    //MARK: -传进去字符串,生成二维码图片
    
    ///生成二维码
    static func setupQRCodeImage(_ text: String, image: UIImage? = nil, size:CGFloat) -> UIImage {
        //创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        //将url加入二维码
        filter?.setValue(text.data(using: String.Encoding.utf8), forKey: "inputMessage")
        //取出生成的二维码（不清晰）
        if let outputImage = filter?.outputImage {
            //生成清晰度更好的二维码
            let qrCodeImage = setupHighDefinitionUIImage(outputImage, size:size)
            //如果有一个头像的话，将头像加入二维码中心
            if var image = image {
                //给头像加一个白色圆边（如果没有这个需求直接忽略）
                image = circleImageWithImage(image, borderWidth: 2, borderColor: UIColor.white)
                //合成图片
                let newImage = syntheticImage(qrCodeImage, iconImage: image, width: 100, height: 100)
                
                return newImage
            }
            
            return qrCodeImage
        }
        
        return UIImage()
    }

    /// 生成高清的UIImage
    private static func setupHighDefinitionUIImage(_ image: CIImage, size: CGFloat) -> UIImage {
        let integral: CGRect = image.extent.integral
        let proportion: CGFloat = min(size/integral.width, size/integral.height)
        
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion);
        bitmapRef.draw(bitmapImage, in: integral);
        let image: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: image)
    }

    /// image: 二维码 iconImage:头像图片 width: 头像的宽 height: 头像的宽
    private static func syntheticImage(_ image: UIImage, iconImage:UIImage, width: CGFloat, height: CGFloat) -> UIImage{
        //开启图片上下文
        UIGraphicsBeginImageContext(image.size)
        //绘制背景图片
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let x = (image.size.width - width) * 0.5
        let y = (image.size.height - height) * 0.5
        iconImage.draw(in: CGRect(x: x, y: y, width: width, height: height))
        //取出绘制好的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        //返回合成好的图片
        if let newImage = newImage {
            return newImage
        }
        return UIImage()
    }

    /// 生成边框
    private static func circleImageWithImage(_ sourceImage: UIImage, borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
         let imageWidth = sourceImage.size.width + 2 * borderWidth
         let imageHeight = sourceImage.size.height + 2 * borderWidth
         
         UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 0.0)
         UIGraphicsGetCurrentContext()
         
         let radius = (sourceImage.size.width < sourceImage.size.height ? sourceImage.size.width:sourceImage.size.height) * 0.5
         let bezierPath = UIBezierPath(arcCenter: CGPoint(x: imageWidth * 0.5, y: imageHeight * 0.5), radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
         bezierPath.lineWidth = borderWidth
         borderColor.setStroke()
         bezierPath.stroke()
         bezierPath.addClip()
         sourceImage.draw(in: CGRect(x: borderWidth, y: borderWidth, width: sourceImage.size.width, height: sourceImage.size.height))
         
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         
         return image!
     }
    
    ///颜色转为图片
    public static func imageFromColor(color: UIColor, viewSize: CGSize) -> UIImage{
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        
        context.fill(rect)
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsGetCurrentContext()
        
        return image!
        
    }
    
        
    public static func imageFromView(view: UIView) -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(view.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        view.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!

    }
    
    func quickSet(cornerRadius:CGFloat) {
//        self.image =
    }
    
    

}

// MARK: 图片设置圆角
extension UIImage {
    
    public func roundImage(byRoundingCorners: UIRectCorner = UIRectCorner.allCorners, cornerRadi: CGFloat) -> UIImage? {
          return imageAddCorne(byRoundingCorners: byRoundingCorners, radius: cornerRadi)
      }
    
    private func imageAddCorne(byRoundingCorners: UIRectCorner = UIRectCorner.allCorners, radius:CGFloat) -> UIImage?  {
        let imageRect = CGRect.init(origin: .zero, size: CGSize(width: radius, height: radius))
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        defer {
            UIGraphicsEndImageContext()
        }
        let contextRef = UIGraphicsGetCurrentContext()
        guard contextRef != nil else {
            return nil
        }
        contextRef?.setShouldAntialias(true)
        let bezierPath = UIBezierPath(roundedRect: imageRect,
                                      byRoundingCorners: byRoundingCorners,
                                      cornerRadii: CGSize(width: radius, height: radius))
        bezierPath.close()
        bezierPath.addClip()
        self.draw(in: imageRect)
        return UIGraphicsGetImageFromCurrentImageContext()

    }
}
