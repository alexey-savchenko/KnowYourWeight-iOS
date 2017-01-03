//
//  VideoPlaylistTableViewController.swift
//  KnowYourWeight
//
//  Created by Alexey Savchenko on 02.01.17.
//  Copyright © 2017 Alexey Savchenko. All rights reserved.
//

import UIKit

class VideoPlaylistTableViewController: UITableViewController {
  
  // MARK: PROPERITIES
  
  var videoArray: [Video] = [Video]()
  var selectedVideo: Video?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(videoArray.count)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return videoArray.count
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let _cell = cell as? VideoPlaylistTableViewCell{
      DispatchQueue.global().async {
        let imgData = try? Data(contentsOf: self.videoArray[indexPath.row].videoThumbnailURL)
        DispatchQueue.main.async {
          _cell.videoPreview.image = UIImage(data: imgData!)
        }
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "videoPlaylistCell", for: indexPath) as! VideoPlaylistTableViewCell
    
    cell.videoTitle.text = videoArray[indexPath.row].videoTitle
    DispatchQueue.global().async {
      let imgData = try? Data(contentsOf: self.videoArray[indexPath.row].videoThumbnailURL)
      DispatchQueue.main.async {
        cell.videoPreview.image = UIImage(data: imgData!)
      }
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.selectedVideo = self.videoArray[indexPath.row]
    performSegue(withIdentifier: "toVideoView", sender: self)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let videoView = segue.destination as! VideoViewController
    videoView.selectedVideo = self.selectedVideo
  }
  
  
}
