//
//  Video.swift
//  KnowYourWeight
//
//  Created by Alexey Savchenko on 03.01.17.
//  Copyright © 2017 Alexey Savchenko. All rights reserved.
//

import Foundation
import UIKit

class Video {
  
  var videoTitle: String
  var videoId: String
  var videoThumbnailURL: URL
  
  init(title: String, id: String, thumbnailURL: URL) {
    self.videoTitle = title
    self.videoId = id
    self.videoThumbnailURL = thumbnailURL
  }
}
