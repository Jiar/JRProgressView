//
//  JRProgressView.swift
//  JRProgressView
//
//  Created by Jiar on 2017/1/20.
//  Copyright © 2017年 Jiar. All rights reserved.
//

import UIKit

/**
 *  角度转弧度
 *
 */
fileprivate func degreesToRadians(_ angle: Float) -> Float {
    return angle/180*Float.pi
}

/**
 *  弧度转角度
 *
 */
fileprivate func radiansToDegrees(_ radians: Float) -> Float {
    return radians*(180/Float.pi)
}

class JRProgressView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        `default`()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        `default`()
    }
    
    func `default`() {
        outerRadius = min(min(Float(bounds.width), Float(bounds.height)), 220)/2
        innerRadius = max(outerRadius-12, 0)
        beginAngle = 145
        blockAngle = 8
        gapAngle = 2
        progressColor = .green
        trackColor = .gray
        outlineColor = .clear
        outlineWidth = 0
        blockCount = 26
        minValue = 0
        maxValue = 100
        currentValue = 50
        showShadow = false
        shadowOuterRadius = max(innerRadius-5, 0)
        shadowInnerRadius = 10
        shadowFillColor = UIColor.gray.withAlphaComponent(0.3)
        autoAdjustAngle = true
    }

    // 重设默认层
    override class var layerClass: Swift.AnyClass {
        return JRProgressLayer.self
    }
    
    // 重新布局视图
    override func layoutSubviews() {
        let ilayer = layer as! JRProgressLayer
        ilayer.setNeedsDisplay()
    }
    
    // 外圈半径
    var outerRadius: Float {
        set {
            let ilayer = layer as! JRProgressLayer
            if ilayer.outerRadius != newValue {
                ilayer.outerRadius = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.outerRadius
        }
    }
    
    // 内圈半径
    var innerRadius: Float {
        set {
            let ilayer = layer as! JRProgressLayer
            if ilayer.innerRadius != newValue {
                ilayer.innerRadius = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.innerRadius
        }
    }
    
    // 起始角度
    var beginAngle: Float {
        set {
            let ilayer = layer as! JRProgressLayer
            let radians = degreesToRadians(newValue)
            if ilayer.beginAngle != radians {
                ilayer.beginAngle = radians
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return radiansToDegrees(ilayer.beginAngle)
        }
    }
    
    // 每个进度块的角度
    var blockAngle: Float {
        set {
            let ilayer = layer as! JRProgressLayer
            let radians = degreesToRadians(newValue)
            if ilayer.blockAngle != radians {
                ilayer.blockAngle = radians
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return radiansToDegrees(ilayer.blockAngle)
        }
    }
    
    // 两个进度块的间隙的角度
    var gapAngle: Float {
        set {
            let ilayer = layer as! JRProgressLayer
            let radians = degreesToRadians(newValue)
            if ilayer.gapAngle != radians {
                ilayer.gapAngle = radians
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return radiansToDegrees(ilayer.gapAngle)
        }
    }
    
    // 进度条填充色
    var progressColor: UIColor {
        set {
            let ilayer = layer as! JRProgressLayer
            if !ilayer.progressColor.isEqual(newValue) {
                ilayer.progressColor = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.progressColor
        }
    }
    
    // 进度条痕迹填充色
    var trackColor: UIColor {
        set {
            let ilayer = layer as! JRProgressLayer
            if !ilayer.trackColor.isEqual(newValue) {
                ilayer.trackColor = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.trackColor
        }
    }
    
    // 进度条边框颜色
    var outlineColor: UIColor {
        set {
            let ilayer = layer as! JRProgressLayer
            if !ilayer.outlineColor.isEqual(newValue) {
                ilayer.outlineColor = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.outlineColor
        }
    }
    
    // 进度条边框线宽
    var outlineWidth: Float {
        set {
            let ilayer = layer as! JRProgressLayer
            if ilayer.outlineWidth != newValue {
                ilayer.outlineWidth = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.outlineWidth
        }
    }
    
    // 进度块的数量
    var blockCount: Int {
        set {
            let ilayer = layer as! JRProgressLayer
            if ilayer.blockCount != newValue {
                ilayer.blockCount = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.blockCount
        }
    }
    
    // 进度条最小数值
    var minValue: Float {
        set {
            let ilayer = layer as! JRProgressLayer
            if ilayer.minValue != newValue {
                ilayer.minValue = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.minValue
        }
    }
    
    // 进度条最大数值
    var maxValue: Float {
        set {
            let ilayer = layer as! JRProgressLayer
            if ilayer.maxValue != newValue {
                ilayer.maxValue = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.maxValue
        }
    }
    
    // 进度条当前数值
    var currentValue: Float {
        set {
            let ilayer = layer as! JRProgressLayer
            if ilayer.currentValue != newValue {
                ilayer.currentValue = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.currentValue
        }
    }
    
    // 是否显示阴影
    var showShadow: Bool {
        set {
            let ilayer = layer as! JRProgressLayer
            if ilayer.showShadow != newValue {
                ilayer.showShadow = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.showShadow
        }
    }
    
    // 阴影外圈半径
    var shadowOuterRadius: Float {
        set {
            let ilayer = layer as! JRProgressLayer
            if ilayer.shadowOuterRadius != newValue {
                ilayer.shadowOuterRadius = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.shadowOuterRadius
        }
    }
    
    // 阴影内圈半径
    var shadowInnerRadius: Float {
        set {
            let ilayer = layer as! JRProgressLayer
            if ilayer.shadowInnerRadius != newValue {
                ilayer.shadowInnerRadius = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.shadowInnerRadius
        }
    }
    
    // 阴影颜色
    var shadowFillColor: UIColor {
        set {
            let ilayer = layer as! JRProgressLayer
            if !ilayer.shadowFillColor.isEqual(newValue) {
                ilayer.shadowFillColor = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.shadowFillColor
        }
    }
    
    // 自动调整角度，使进度条开口向下并且左右对称
    var autoAdjustAngle: Bool {
        set {
            let ilayer = layer as! JRProgressLayer
            if ilayer.autoAdjustAngle != newValue {
                ilayer.autoAdjustAngle = newValue
                ilayer.setNeedsDisplay()
            }
        }
        get {
            let ilayer = layer as! JRProgressLayer
            return ilayer.autoAdjustAngle
        }
    }

}
