//
//  SelectionBorderView.swift
//  TextStrock
//
//  Created by PosterMaker on 9/10/23.
//

import UIKit

class SelectionBorderView: UIView {
    var leftCircelView = UIView()
    private var leftCircelMiddleView = UIView()
    
    var rightCircelView = UIView()
    private var rightCircelMiddleView = UIView()
    private let offset = CGFloat(10)
    
    private let selectedCircleColor = UIColor.white
    private let selectedCircleBorderColor = UIColor.lightGray
    
    private let deselectCircleColor = UIColor.lightGray
    private let deselectCircleBorderColor = UIColor.white
    
    private let minimumScale:CGFloat = 0.25

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let pathRect = CGRect(origin: CGPoint(x: offset, y: offset), size: CGSize(width: rect.width - 2*offset, height: rect.height - 2*offset))
        let path = UIBezierPath(rect: pathRect)
        UIColor.white.set()
        let pattern: [CGFloat] = [5.0, 5.0]
        path.setLineDash(pattern, count: 2, phase: 0.0)
        path.lineWidth = 1.2
        path.stroke()
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetUp()
    }
    
    func viewSetUp(){
        self.backgroundColor = .clear
        self.clipsToBounds = false
        addSubview(rightCircelView)
        addSubview(leftCircelView)
        
        rightCircelView.backgroundColor = .clear
        rightCircelView.clipsToBounds = false
        rightCircelView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(offset*4)
            make.width.equalTo(offset*4)
            make.centerX.equalTo(self.snp.right).offset(-offset)
            make.centerY.equalTo(self.snp.centerY)
        }
        rightCircelView.layer.cornerRadius = offset
        
        rightCircelView.addSubview(rightCircelMiddleView)
        rightCircelMiddleView.backgroundColor = deselectCircleColor
        rightCircelMiddleView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.rightCircelView.snp.left)
            make.right.equalTo(self.rightCircelView.snp.right)
            make.top.equalTo(self.rightCircelView.snp.top)
            make.bottom.equalTo(self.rightCircelView.snp.bottom)
        }
        rightCircelMiddleView.layer.cornerRadius = offset*2
        rightCircelMiddleView.layer.borderWidth = 2.0
        rightCircelMiddleView.layer.borderColor = deselectCircleBorderColor.cgColor
        rightCircelMiddleView.transform = CGAffineTransform(scaleX: minimumScale, y: minimumScale)
        
        //left
        leftCircelView.backgroundColor = .clear
        leftCircelView.clipsToBounds = false
        leftCircelView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(offset*4)
            make.width.equalTo(offset*4)
            make.centerX.equalTo(self.snp.left).offset(offset)
            make.centerY.equalTo(self.snp.centerY)
        }
        leftCircelView.layer.cornerRadius = offset
        
        leftCircelView.addSubview(leftCircelMiddleView)
        leftCircelMiddleView.backgroundColor = deselectCircleColor
        leftCircelMiddleView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.leftCircelView.snp.left)
            make.right.equalTo(self.leftCircelView.snp.right)
            make.top.equalTo(self.leftCircelView.snp.top)
            make.bottom.equalTo(self.leftCircelView.snp.bottom)
            
        }
        leftCircelMiddleView.layer.cornerRadius = offset*2
        leftCircelMiddleView.layer.borderWidth = 2.0
        leftCircelMiddleView.layer.borderColor = deselectCircleBorderColor.cgColor
        leftCircelMiddleView.transform = CGAffineTransform(scaleX: minimumScale, y: minimumScale)
    }
    
    private func viewSelectState(view:UIView){
        UIView.animate(withDuration: 0.3, animations: {
            view.backgroundColor = self.selectedCircleColor
            view.layer.borderColor = self.selectedCircleBorderColor.cgColor
            view.transform = CGAffineTransform(scaleX: self.minimumScale*2, y: self.minimumScale*2)
        })
        
    }
    
    private func viewDeselectState(view:UIView){
        UIView.animate(withDuration: 0.3, animations: {
            view.backgroundColor = self.deselectCircleColor
            view.layer.borderColor = self.deselectCircleBorderColor.cgColor
            view.transform = CGAffineTransform(scaleX: self.minimumScale, y: self.minimumScale)
        })
        
    }
    
    func leftViewSelect(){
        viewSelectState(view: leftCircelMiddleView)
    }
    func leftViewDeselect(){
        viewDeselectState(view: leftCircelMiddleView)
    }
    
    func rightViewSelect(){
        viewSelectState(view: rightCircelMiddleView)
    }
    func rightViewDeselect(){
        viewDeselectState(view: rightCircelMiddleView)
    }
    
}
