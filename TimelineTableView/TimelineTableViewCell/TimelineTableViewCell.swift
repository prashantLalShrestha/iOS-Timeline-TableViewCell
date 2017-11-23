//
//  TimelineTableViewCell.swift
//  TimelineTableView
//
//  Created by ram on 11/22/17.
//  Copyright © 2017 ram. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleInfoLabel: UILabel!
    @IBOutlet weak var timeInfo: UILabel!
    @IBOutlet weak var tagImage: UIImageView!
    
    // Point Variables
    var pointPosition: CGPoint!
    let pointDiameter: CGFloat = 6.0
    let color = UIColor.black
    
    // Line Variables
    let lineWidth: CGFloat = 2.0
    let offset: CGFloat = 16
    var (lineStart, lineMiddle, lineEnd) = (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0))
    
    // Bubble Variables
    let cornerRadius: CGFloat = 6.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        
        for layer in self.contentView.layer.sublayers! {
            if layer is CAShapeLayer {
                layer.removeFromSuperlayer()
            }
        }
                
        pointPosition = CGPoint(x: (titleInfoLabel.frame.origin.x - offset + timeInfo.frame.maxX) / 2, y: titleInfoLabel.frame.origin.y + titleInfoLabel.intrinsicContentSize.height / 2 - pointDiameter / 2)
        
        lineStart = CGPoint(x: pointPosition.x + pointDiameter / 2, y: 0)
        lineMiddle = CGPoint(x: lineStart.x, y: pointPosition.y)
        lineEnd = CGPoint(x: lineStart.x, y: self.bounds.size.height)
        
        drawLine(from: lineStart, to: lineMiddle, color: color)
        drawLine(from: lineMiddle, to: lineEnd, color: color)
        
        
        drawPoint()
        
        if let title = titleInfoLabel.text, !title.isEmpty {
            drawBubble()
        }
    }
    
    fileprivate func drawPoint() {
        let path = UIBezierPath(ovalIn: CGRect(x: pointPosition.x, y: pointPosition.y, width: pointDiameter, height: pointDiameter))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        
        self.contentView.layer.addSublayer(shapeLayer)
    }
    
    fileprivate func drawBubble() {
        
        let bubbleRect = CGRect(
            x: titleInfoLabel.frame.origin.x - offset / 2,
            y: titleInfoLabel.frame.origin.y - offset / 2,
            width: titleInfoLabel.intrinsicContentSize.width + offset,
            height: titleInfoLabel.intrinsicContentSize.height + offset)
        
        let path = UIBezierPath(roundedRect: bubbleRect, cornerRadius: cornerRadius)
        let startPoint = CGPoint(x: bubbleRect.origin.x, y: bubbleRect.origin.y + bubbleRect.height / 2 - 8)
        path.move(to: startPoint)
        path.addLine(to: startPoint)
        path.addLine(to: CGPoint(x: bubbleRect.origin.x - 8, y: bubbleRect.origin.y + bubbleRect.height / 2))
        path.addLine(to: CGPoint(x: bubbleRect.origin.x, y: bubbleRect.origin.y + bubbleRect.height / 2 + 8))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.lightGray.cgColor
        
        self.contentView.layer.insertSublayer(shapeLayer, below: titleInfoLabel.layer)
    }
    
    fileprivate func drawLine(from: CGPoint, to: CGPoint, color: UIColor) {
        let path = UIBezierPath()
        path.move(to: from)
        path.addLine(to: to)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        
        self.contentView.layer.addSublayer(shapeLayer)
    }
    
    func configureCellData(timeInfo: String, title: String, description: String, timeRemaining: String, tag: String) {
        self.timeInfo.text = timeInfo
        self.titleInfoLabel.text = title
        self.descriptionLabel.text = description
        self.timeRemainingLabel.text = timeRemaining
        self.tagImage.image = UIImage(named: tag)
    }
    
}
