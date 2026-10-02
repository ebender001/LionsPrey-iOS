//
//  LionAnimation.swift
//  Lions Prey
//
//  Created by Edward Bender on 8/31/21.
//

import SwiftUI

struct LionAnimation: UIViewRepresentable {
    
    var images: [UIImage]  {
        var allImages = [UIImage]()
        for x in 1...17 {
            allImages.append(UIImage(named: "img\(x)")!)
        }
        return allImages
    }
    func makeUIView(context: Context) -> some UIImageView {
        let v = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 64))
        v.clipsToBounds = true
        v.contentMode = .scaleAspectFit
        v.animationImages = images
        v.startAnimating()
        return v
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
