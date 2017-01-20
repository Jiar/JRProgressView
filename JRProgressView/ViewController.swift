//
//  ViewController.swift
//  JRProgressView
//
//  Created by Jiar on 2017/1/20.
//  Copyright © 2017年 Jiar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let progress = JRProgressView(frame: CGRect(x: 20, y: 80, width: 320, height: 320))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress.center = CGPoint.init(x: UIScreen.main.bounds.width/2, y: 240)
        progress.backgroundColor = .black
        progress.outerRadius = 154  // 外圈半径
        progress.innerRadius = 140  // 内圈半径
        progress.beginAngle = 0    // 起始角度
        progress.blockAngle = 5   // 每个进度块的角度
        progress.gapAngle = 1     // 两个进度块的间隙的角度
        progress.progressColor = .green // 进度条填充色
        progress.trackColor    = .red   // 进度条痕迹填充色
        progress.outlineColor  = .gray  // 进度条边框颜色
        progress.outlineWidth  = 0                    // 进度条边框线宽
        
        progress.blockCount = 60   // 进度块的数量
        progress.minValue = 1      // 进度条最小数值
        progress.maxValue = 60     // 进度条最大数值
        progress.currentValue = 1  // 进度条当前数值
        
        progress.showShadow = false    // 是否显示阴影
        progress.shadowOuterRadius = 0 // 阴影外圈半径
        progress.shadowInnerRadius = 0 // 阴影内圈半径
        //    progress.shadowFillColor = [[UIColor grayColor] colorWithAlphaComponent:0.3]
        progress.shadowFillColor = .clear   // 阴影颜色
        progress.autoAdjustAngle = true     // 自动调整角度

        view.addSubview(progress)
        
    }
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBAction func addAction(_ sender: Any) {
        let value = progress.currentValue
        progress.currentValue = value+1
        progressLabel.text = String.init(format: "%.0lf", progress.currentValue)
    }

}

