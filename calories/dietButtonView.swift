//
//  dietButtonView.swift
//  KnowYourWeight
//
//  Created by Alexey Savchenko on 09.12.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import UIKit

class dietButtonView: UIView {
  
  let darkOverlayView = UIView(frame: CGRect(x: 0, y: 0, width: 343, height: 75))
  
  var isSelected = false
  var timesClicked = 0
  
  func enableDarkOverlay(){
    if !isSelected {
      darkOverlayView.backgroundColor = UIColor.black
      darkOverlayView.alpha = 0.4
      self.addSubview(darkOverlayView)
    }
  }
  
  func disableDarkOverlay(){
    if self.subviews.contains(darkOverlayView){
      darkOverlayView.removeFromSuperview()
    }
  }
}
