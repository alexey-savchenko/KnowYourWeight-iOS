//
//  VideoViewController.swift
//  KnowYourWeight
//
//  Created by Alexey Savchenko on 03.01.17.
//  Copyright © 2017 Alexey Savchenko. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
  
  
  var selectedVideo: Video?
  
  @IBOutlet weak var webView: UIWebView!
  @IBOutlet weak var videoTitle: UILabel!
  
  @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.automaticallyAdjustsScrollViewInsets = false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let vid = self.selectedVideo{
      
      videoTitle.text = vid.videoTitle
      
      let width = self.view.frame.size.width
      let height = width/320 * 180
      
      self.webViewHeightConstraint.constant = height
      
      let videoEmbedString = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"\(height)\" width=\"\(width)\" src=\"http://www.youtube.com/embed/" + vid.videoId + "?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
      self.webView.loadHTMLString(videoEmbedString, baseURL: nil)
    }
    
    
  }
  
  
}
