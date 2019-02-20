//
//  ZFSlider.swift
//  DBY1VNUI
//
//  Created by 钟凡 on 2019/1/5.
//  Copyright © 2019 钟凡. All rights reserved.
//

import UIKit

protocol ZFSliderDelegate: NSObjectProtocol {
    func progressDidChange(owner: ZFSlider, value:Float)
    func progressEndChange(owner: ZFSlider, value:Float)
}

class ZFSlider: UIView {
    //MARK: - 加载xib代码
    var contentView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView!.frame = bounds
    }
    func xibSetup() {
        contentView = loadViewFromNib()
        addSubview(contentView!)
    }
    func loadViewFromNib() -> UIView {
        let classType = type(of:self)
        let bundle = Bundle(for: classType)
        let nib = UINib(nibName: "\(classType)", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    //MARK: - 实现代码
    var value: Float = 0 // default 0.0. this value will be pinned to min/max
    
    var minValue: Float = 0 // default 0.0. the current value may change if outside new min value
    
    var maxValue: Float = 1 // default 1.0. the current value may change if outside new max value
    
    var shouldUpdate:Bool = false
    
    weak var delegate:ZFSliderDelegate?
    
    @IBOutlet weak var sliderBar: UIImageView!
    @IBOutlet weak var progressBackView: UIView!
    @IBOutlet weak var progressView: UIView!

    @IBOutlet weak var sliderLeft: NSLayoutConstraint!
    @IBOutlet weak var progressViewWidth: NSLayoutConstraint!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first?.location(in: self) {
            if sliderBar.frame.contains(point) {
                shouldUpdate = true
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if shouldUpdate == false {
            return
        }
        if let point = touches.first?.location(in: self) {
            sliderLeft.constant = point.x - sliderBar.bounds.width * 0.5
        }
        if sliderLeft.constant < 0 {
            sliderLeft.constant = 0
        }
        let sliderMaxX:CGFloat = self.bounds.width - sliderBar.bounds.width
        if sliderLeft.constant > sliderMaxX {
            sliderLeft.constant = sliderMaxX
        }
        let progress = sliderLeft.constant / sliderMaxX
        progressViewWidth.constant = progress * progressBackView.bounds.width
        value = Float(progress) * (maxValue - minValue)
        delegate?.progressDidChange(owner: self, value: value)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if shouldUpdate == false {
            return
        }
        shouldUpdate = false
        delegate?.progressEndChange(owner: self, value: value)
    }
    func setProgress(_ value:Float) {
        self.value = value
        let progress:CGFloat = CGFloat(value / (maxValue - minValue))
        let sliderMaxX:CGFloat = self.bounds.width - sliderBar.bounds.width
        sliderLeft.constant = progress * sliderMaxX
        progressViewWidth.constant = progress * progressBackView.bounds.width
    }
}
