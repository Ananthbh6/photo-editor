//
//  PhotoEditor+UITextView.swift
//  Pods
//
//  Created by Mohamed Hamed on 6/16/17.
//
//

import Foundation
import UIKit

extension PhotoEditorViewController: UITextViewDelegate {
    
    func textToImage(drawText text: String, inImage image: UIImage?, atPoint point: CGPoint, color: UIColor, font: UIFont?) -> UIImage {
        
        guard let textFont = font, let image = image else { return imageView.image! }
        
        let textColor = color
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            ] as [NSAttributedStringKey : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    
    public func textViewDidChange(_ textView: UITextView) {
        let rotation = atan2(textView.transform.b, textView.transform.a)
        if rotation == 0 {
            let oldFrame = textView.frame
            let sizeToFit = textView.sizeThatFits(CGSize(width: oldFrame.width, height:CGFloat.greatestFiniteMagnitude))
            textView.frame.size = CGSize(width: oldFrame.width, height: sizeToFit.height)
        }
    }
    public func textViewDidBeginEditing(_ textView: UITextView) {
        isTyping = true
        lastTextViewTransform =  textView.transform
        lastTextViewTransCenter = textView.center
        lastTextViewFont = textView.font!
        activeTextView = textView
        textView.superview?.bringSubview(toFront: textView)
        textView.font = UIFont(name: "Helvetica", size: 30)
        UIView.animate(withDuration: 0.3,
                       animations: {
                        textView.transform = CGAffineTransform.identity
                        textView.center = CGPoint(x: UIScreen.main.bounds.width / 2,
                                                  y:  UIScreen.main.bounds.height / 5)
        }, completion: nil)
        
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        guard lastTextViewTransform != nil && lastTextViewTransCenter != nil && lastTextViewFont != nil
            else {
                return
        }
        activeTextView = nil
        textView.font = self.lastTextViewFont!
        UIView.animate(withDuration: 0.3,
                       animations: {
                        textView.transform = self.lastTextViewTransform!
                        textView.center = self.lastTextViewTransCenter!
        }, completion: nil)
    }
    
}
