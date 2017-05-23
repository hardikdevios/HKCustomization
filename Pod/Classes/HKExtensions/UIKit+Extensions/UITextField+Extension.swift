//
//  UITextField+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit
extension UITextField{
    
    public func hk_setDefaultBottomBorder()->Void{
        
        let border = CALayer()
        
        let width = CGFloat(1)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.bounds.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    public func hk_setSelectedBottomBorder()->Void{
        
        let border = CALayer()
        
        let width = CGFloat(1)
        border.borderColor = MAIN_COLOR.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
   public func hk_setDefaultText(_ defaultText:String!)->Void{
        if self.text == "" ||  self.text == " " ||  self.text == nil{
            self.text = defaultText
        }
        
    }
    
    public func hk_setLeftImgView(_ imgName:String!,contentMode:UIViewContentMode = .center)->Void{
        
        self.layoutIfNeeded()
        let leftViewForImg = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.size.height))
        let imgView = UIImageView(image: UIImage(named: imgName)!)
        imgView.frame = CGRect(x: 0, y: 0, width: leftViewForImg.frame.size.width - 20, height: leftViewForImg.frame.size.height - 20)
        imgView.center = leftViewForImg.center
        imgView.contentMode = contentMode
        leftViewForImg.addSubview(imgView)
        self.leftView = leftViewForImg
        self.leftViewMode = .always
        
    }
    
    public func hk_setPlaceHolderColor(_ color:UIColor){
        
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "",
            attributes:[NSForegroundColorAttributeName:color])
        
    }
    
}

extension UITextField {
    
    public func hk_getIndexPathForTableView(for tableView:UITableView)->IndexPath?{
        
        return tableView.indexPathForRow(at: (self.superview?.convert(self.frame.origin, to:tableView))!)
        
    }
}

extension UITextField{
    
    
    public func hk_isEmpty()->Int{
        if self.text!.hk_trimWhiteSpace() != "" {
            return 0
        }
        
        if let textfield = self as? HKFloatingTextField{
            textfield.hk_setPlaceHolderColor(textfield.validationErrorColor)
        }
        self.hk_shake()
        return 1
    }
    
    public func hk_isEmail() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: .caseInsensitive)
        return regex?.firstMatch(in: self.text!.hk_trimWhiteSpace()!, options: [], range: NSMakeRange(0, self.text!.hk_trimWhiteSpace()!.characters.count)) != nil
    }
    
    public func hk_shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.10
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    public func hk_setLockViewAndDisabled(_ isLeft:Bool = false){
        
        let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30 , height: 30))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 25 ,height: 25))
        
        label.textAlignment = NSTextAlignment.center
        label.text = "🔒"
        view.addSubview(label)
        
        self.isEnabled = false
        
        if isLeft {
            self.leftView = view
            self.leftViewMode = .always
        }else{
            self.rightView = view
            self.rightViewMode = .always
        }
        
    }
    

    
}
