//
//  CustomLockView.swift
//  KisiBeacon
//
//  Created by Suyash Taneja on 05/11/17.
//  Copyright © 2017 Suyash Taneja. All rights reserved.
//

import UIKit

@IBDesignable class CustomLockView: UIView {
    
    private struct Constants {
        static let lineWidth: CGFloat = 4.0
        static let smallRoundedRectangleWidth: CGFloat = 60.0
        static let smallRoundedRectangleHeight: CGFloat = 20.0
        static let smallCircleRadius: CGFloat = 15.0
        static let handleRotationAngle: CGFloat = 0.85
    }
    
    var squareLayer = CAShapeLayer()
    var semiCircleLayer = CAShapeLayer()
    var smallRoundedRectangleLayer = CAShapeLayer()
    var circleLayer = CAShapeLayer()
    let circleRadius = 5.0
    
    private var isCurrentlyAnimating: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func lockDoor() {
        animateSmallCircleLock()
    }
    
    func unlockDoor() {
        animateSemiCircleUnlockAndLock()
        animateSmallCircleUnlock()
        lockDoor()
    }
    
    private func animateSmallCircleLock() {
        let translationAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        translationAnimation.values = [30.0, 20.0, 10.0, 5.0, 1.0, 0]
        translationAnimation.keyTimes = [0, 0.2, 0.4, 0.9, 0.92, 1.0]
        translationAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale.x")
        scaleAnimation.values =     [1, 1.1, 1.2, 1, 0.95, 0.9, 1.1, 1.15, 1.0]
        scaleAnimation.keyTimes = [0, 0.1, 0.4, 0.7, 0.94, 0.95, 0.96, 0.98, 1.0]
        scaleAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        
        let fadeAnimation = CAKeyframeAnimation(keyPath: "fillColor")
        fadeAnimation.values = [UIColor.white.cgColor, UIColor.white.cgColor, UIColor.redBackgroundColor.cgColor]
        fadeAnimation.keyTimes = [0, 0.9, 1.0]
        fadeAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)]
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [translationAnimation, scaleAnimation, fadeAnimation]
        groupAnimation.duration = 0.8
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.beginTime = CACurrentMediaTime() + 2.0
    
        circleLayer.add(groupAnimation, forKey: "circleMoveAnimation")
    }
    
    private func animateSemiCircleUnlockAndLock() {
        let springHandleAnimation = CASpringAnimation(keyPath: "transform.rotation")
        springHandleAnimation.fromValue = 0
        springHandleAnimation.byValue = CGFloat.pi * 0.25
        springHandleAnimation.duration = 1.5
        springHandleAnimation.damping = 4
        springHandleAnimation.mass = 0.5
        springHandleAnimation.fillMode = kCAFillModeForwards
        springHandleAnimation.isRemovedOnCompletion = false
        
        let springHandleAnimationLock = CABasicAnimation(keyPath: "transform.rotation")
        springHandleAnimationLock.fromValue = CGFloat.pi * 0.25
        springHandleAnimationLock.toValue = 0
        springHandleAnimationLock.duration = 0.2
        springHandleAnimationLock.fillMode = kCAFillModeForwards
        springHandleAnimationLock.isRemovedOnCompletion = false
        springHandleAnimationLock.beginTime = 1.9
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [springHandleAnimation, springHandleAnimationLock]
        groupAnimation.duration = 2.1
        groupAnimation.beginTime = CACurrentMediaTime() + 0.6
        semiCircleLayer.add(groupAnimation, forKey: "handleRotationAnimation")
    }
    
    private func animateSmallCircleUnlock() {
        let translationAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        translationAnimation.values = [0.0, 2.0, 10.0, 20.0, 32.0, 34.0, 32.0, 30.0]
        translationAnimation.keyTimes = [0, 0.2, 0.3, 0.4, 0.9, 0.93, 0.98, 1.0]
        translationAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)]
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale.x")
        scaleAnimation.values =     [1, 1.10, 1.20, 1.25, 1.0, 0.85, 0.8, 0.9, 1.0]
        scaleAnimation.keyTimes =   [0, 0.1, 0.2, 0.7, 0.85, 0.90, 0.96, 0.98, 1.0]
        scaleAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        
        let fadeAnimation = CAKeyframeAnimation(keyPath: "fillColor")
        fadeAnimation.values = [UIColor.redBackgroundColor.cgColor, UIColor.redBackgroundColor.cgColor, UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.white.cgColor]
        fadeAnimation.keyTimes = [0, 0.5, 0.8, 0.95]
        fadeAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)]
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [translationAnimation, scaleAnimation, fadeAnimation]
        groupAnimation.duration = 1.0
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = kCAFillModeForwards
        circleLayer.add(groupAnimation, forKey: nil)
    }
    
    func configure() {
        configureSquareLayer()
        configureSemiCircleLayer()
        configureSmallRoundedRectangleLayer()
        configureSmallCircleLayer()
    }
    
    private func configureSmallRoundedRectangleLayer() {
        smallRoundedRectangleLayer.path = smallRectanglePath()
        smallRoundedRectangleLayer.fillColor = UIColor.clear.cgColor
        smallRoundedRectangleLayer.strokeColor = UIColor.white.cgColor
        smallRoundedRectangleLayer.lineWidth = Constants.lineWidth
        layer.insertSublayer(smallRoundedRectangleLayer, below: circleLayer)
    }
    
    private func configureSmallCircleLayer() {
        circleLayer.path = smallCirclePath()
        circleLayer.fillColor = UIColor.redBackgroundColor.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = Constants.lineWidth
        layer.insertSublayer(circleLayer, above: smallRoundedRectangleLayer)
        circleLayer.bounds = smallCirclePath().boundingBoxOfPath
        circleLayer.position = CGPoint(x: bounds.width/2 - Constants.smallRoundedRectangleWidth/2 + Constants.smallCircleRadius , y: bounds.height * 0.7)
    }
    
    private func configureSquareLayer() {
        squareLayer.lineWidth = Constants.lineWidth
        squareLayer.strokeColor = UIColor.white.cgColor
        squareLayer.fillColor = UIColor.redBackgroundColor.cgColor
        layer.addSublayer(squareLayer)
    }
    
    private func configureSemiCircleLayer() {
        semiCircleLayer.path = semiCirclePath()
        semiCircleLayer.lineWidth = Constants.lineWidth
        semiCircleLayer.strokeColor = UIColor.white.cgColor
        semiCircleLayer.fillColor = UIColor.clear.cgColor
        layer.insertSublayer(semiCircleLayer, below: squareLayer)
        semiCircleLayer.bounds = semiCirclePath().boundingBoxOfPath
        setRotationPointForSemiCircleLayer()
    }
    
    private func setRotationPointForSemiCircleLayer() {
        let rotationPoint = CGPoint(x: bounds.width * 0.5 + bounds.height * 0.13, y: 0.4 * bounds.height)
        
        let minX = semiCircleLayer.bounds.minX
        let minY = semiCircleLayer.bounds.minY
        let width = semiCircleLayer.bounds.width
        let height = semiCircleLayer.bounds.height
        let anchorPoint = CGPoint(x: (rotationPoint.x - minX) / width, y: (rotationPoint.y-minY)/height)
        
        semiCircleLayer.anchorPoint = anchorPoint
        semiCircleLayer.position = rotationPoint
    }
    
    private func smallRectanglePath() -> CGPath {
        return UIBezierPath(roundedRect: CGRect(x: bounds.width/2 - Constants.smallRoundedRectangleWidth/2, y: 0.7 * bounds.height - Constants.smallRoundedRectangleHeight/2, width: Constants.smallRoundedRectangleWidth, height: Constants.smallRoundedRectangleHeight), cornerRadius: 10.0).cgPath
    }
    
    private func smallCirclePath() -> CGPath {
        return UIBezierPath(ovalIn: CGRect(x: bounds.width/2 - Constants.smallRoundedRectangleWidth/2, y: 0.7 * bounds.height - Constants.smallCircleRadius, width: Constants.smallCircleRadius * 2.0 , height: Constants.smallCircleRadius * 2.0)).cgPath
    }
    
    private func roundedSquarePath() -> CGPath {
        return  UIBezierPath(roundedRect: CGRect(x: (bounds.width - 0.6 * bounds.height)/2.0, y: bounds.height * 0.4, width: bounds.height * 0.6, height: bounds.height * 0.6), cornerRadius: 20).cgPath
    }
    
    private func semiCirclePath() -> CGPath {
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: bounds.width / 2.0 , y: 0.4 * bounds.height), radius: 0.20 * bounds.height, startAngle: .pi, endAngle: 2 * .pi, clockwise: true)
        path.addLine(to: CGPoint(x: bounds.width/2.0 + 0.2 * bounds.height, y: 0.4 * bounds.height))
        path.addArc(withCenter: CGPoint(x: bounds.width / 2.0 , y: 0.4 * bounds.height), radius: 0.13 * bounds.height, startAngle: 0, endAngle: .pi, clockwise: false)
        path.close()
        return path.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        squareLayer.path = roundedSquarePath()
        semiCircleLayer.path = semiCirclePath()
        smallRoundedRectangleLayer.path = smallRectanglePath()
        circleLayer.path = smallCirclePath()
    }
}

extension CustomLockView: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}
