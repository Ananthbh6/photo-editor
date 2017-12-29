//
//  UIView+Image.swift
//  Photo Editor
//
//  Created by Mohamed Hamed on 4/23/17.
//  Copyright © 2017 Mohamed Hamed. All rights reserved.
//

import UIKit

extension UIView {
    /**
     Convert UIView to UIImage
     */
    func toImage() -> UIImage {
        let width = (self.superview?.bounds.size.width)! * 0.8
        let height = (self.superview?.bounds.size.height)! * 0.8
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, self.isOpaque, 0.0)
        self.drawHierarchy(in: (self.superview?.bounds)!, afterScreenUpdates: false)
        let snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImageFromMyView!
    }
}
