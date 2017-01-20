//
//  JRProgressLayer.swift
//  JRProgressView
//
//  Created by Jiar on 2017/1/20.
//  Copyright © 2017年 Jiar. All rights reserved.
//

import UIKit

fileprivate extension Float {
    
    fileprivate static var pi2: Float {
        return 2*Float.pi
    }
    
}

class JRProgressLayer: CALayer {
    
    var outerRadius: Float = 0.0       // 外圈半径
    var innerRadius: Float = 0.0       // 内圈半径
    var beginAngle: Float = 0.0        // 起始角度
    var blockAngle: Float = 0.0        // 每个进度块的角度
    var gapAngle: Float = 0.0          // 两个进度块的间隙的角度
    var progressColor: UIColor = .magenta  // 进度条填充色
    var trackColor: UIColor = .white       // 进度条痕迹填充色
    var outlineColor: UIColor = .clear     // 进度条边框颜色
    var outlineWidth: Float = 0.0      // 进度条边框线宽
    var blockCount: Int = 0            // 进度块的数量
    var minValue: Float = 0.0          // 进度条最小数值
    var maxValue: Float = 0.0          // 进度条最大数值
    var currentValue: Float = 0.0      // 进度条当前数值
    
    var showShadow: Bool = false       // 是否显示阴影
    var shadowOuterRadius: Float = 0.0 // 阴影外圈半径
    var shadowInnerRadius: Float = 0.0 // 阴影内圈半径
    var shadowFillColor: UIColor = .clear  // 阴影颜色
    
    var autoAdjustAngle: Bool = false  // 自动调整角度，使进度条开口向下并且左右对称
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     *  指定属性改变时，layer刷新
     *
     *  @param key 属性名
     *
     *  @return 刷新：YES；  不刷新：NO
     */
    override class func needsDisplay(forKey key: String) -> Bool {
        switch key {
        case "outerRadius", "innerRadius", "beginAngle", "blockAngle", "gapAngle", "progressColor", "trackColor", "outlineColor", "outlineWidth", "blockCount", "minValue", "maxValue", "currentValue", "showShadow", "shadowOuterRadius", "shadowInnerRadius", "shadowFillColor", "autoAdjustAngle":
            return true
        default:
            return false
        }
    }
    
    /**
     *  绘制层
     *
     *  @param ctx 设备上下文
     */
    override func draw(in ctx: CGContext) {
        if autoAdjustAngle {
            let totalAngle = Float.pi2-(blockAngle+gapAngle)*Float(blockCount)-gapAngle
            beginAngle = Float.pi2*0.25+totalAngle*0.5
        }
        let center = CGPoint.init(x: bounds.width/2, y: bounds.height/2)
        drawProgression(in: ctx, at: center)
    }
    
    /**
     *  绘制进度条
     *
     *  @param ctx    设备上下文
     *  @param center 绘制中心点
     */
    func drawProgression(in ctx: CGContext, at center: CGPoint) {
        // 计算当前进度显示到第几块
        let currentBlock = Int(currentValue)
        
        // 第一块的起始角度和终止角度
        var blockBeginAngle = beginAngle
        var blockEndAngle = beginAngle + blockAngle
        
        // 绘制进度块
        var isFill = false
        
        for i in 1...blockCount {
            if i <= currentBlock {
                isFill = true
            } else {
                isFill = false
            }
            // 绘制块
            drawBlock(in: ctx, at: center, startAngle: blockBeginAngle, endAngle: blockEndAngle, isFill: isFill)
            // 绘制阴影
            if showShadow {
                drawBlockShadow(in: ctx, at: center, startAngle: blockBeginAngle, endAngle: blockEndAngle)
            }
            // 下一块的起始角度和终止角度
            let temp = blockAngle + gapAngle
            blockBeginAngle += temp
            blockEndAngle += temp
        }
    }
    
    /**
     *  绘制进度块，按照顺时针绘制
     *
     *  @param ctx        设备上下文
     *  @param center     进度条中心点
     *  @param startAngle 块起始角度
     *  @param endAngle   块终止角度
     *  @param isFill     块是否被填充
     */
    func drawBlock(in ctx: CGContext, at center: CGPoint, startAngle: Float, endAngle: Float, isFill: Bool) {
        // 绘制扇形
        ctx.addArc(center: center, radius: CGFloat(outerRadius), startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: false)
        ctx.addArc(center: center, radius: CGFloat(innerRadius), startAngle: CGFloat(endAngle), endAngle: CGFloat(startAngle), clockwise: true)
        ctx.closePath()
        var fillColor = trackColor
        if isFill {
            fillColor = progressColor
        }
        // 设置绘制参数
        ctx.setLineWidth(CGFloat(outlineWidth))
        ctx.setStrokeColor(outlineColor.cgColor)
        ctx.setFillColor(fillColor.cgColor)
        // 绘制
        ctx.drawPath(using: .fillStroke)
    }
    
    /**
     *  绘制进度块阴影
     *
     *  @param ctx        设备上下文
     *  @param center     进度条中心点
     *  @param startAngle 块起始角度
     *  @param endAngle   块终止角度
     */
    func drawBlockShadow(in ctx: CGContext, at center: CGPoint, startAngle: Float, endAngle: Float) {
        // 绘制扇形
        ctx.addArc(center: center, radius: CGFloat(shadowOuterRadius), startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: false)
        ctx.addArc(center: center, radius: CGFloat(shadowInnerRadius), startAngle: CGFloat(endAngle), endAngle: CGFloat(startAngle), clockwise: true)
        ctx.closePath()
        ctx.setFillColor(shadowFillColor.cgColor)
        ctx.fillPath()
    }

}
