//
//  image.swift
//  Sony 360 RA
//
//  Created by Andrija Milovanovic on 6/24/21.
//

import Foundation
import UIKit

extension UIImage {
    func resizeImage(to newSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            let hScale = newSize.height / size.height
            let vScale = newSize.width / size.width
            let scale = max(hScale, vScale) // scaleToFill
            let resizeSize = CGSize(width: size.width*scale, height: size.height*scale)
            var middle = CGPoint.zero
            if resizeSize.width > newSize.width {
                middle.x -= (resizeSize.width-newSize.width)/2.0
            }
            if resizeSize.height > newSize.height {
                middle.y -= (resizeSize.height-newSize.height)/2.0
            }
            
            draw(in: CGRect(origin: middle, size: resizeSize))
        }
    }
	
	func cropCenter(size:CGSize) -> UIImage?
	{
		let x = ((self.size.width - size.width) / 2)
		let y = ((self.size.height - size.height) / 2)
		return crop(rect: CGRect(x: x, y: y, width: size.width, height: size.height))
	}
	func crop(rect:CGRect) -> UIImage?
	{
		if let imageRef = self.cgImage!.cropping(to: rect) {
			return UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
		}

		return nil
	}
}
