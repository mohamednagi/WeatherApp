import UIKit
@IBDesignable

class MyButton: UIButton {

    @IBInspectable var CornerRadius:CGFloat = 0{
        didSet{
         self.layer.cornerRadius = CornerRadius
        }
    }
    @IBInspectable var BorderWidth:CGFloat = 0{
        didSet{
            self.layer.borderWidth = BorderWidth
        }
    }
    @IBInspectable var BorderColor:UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
    

}
