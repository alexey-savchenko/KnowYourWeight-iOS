//
//  VideoTypeSelectViewController.swift
//  KnowYourWeight
//
//  Created by Alexey Savchenko on 02.01.17.
//  Copyright © 2017 Alexey Savchenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VideoTypeSelectViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  let YOUTUBE_URL = "https://www.googleapis.com/youtube/v3/playlistItems"
  let MOTIVATIONAL_PLAYLIST_ID = "PLA32772AF41E997C7"
  let BODYBUILDING_PLAYLIST_ID = "PLLXmeIOBkPXQf90lP_tgEllyiLF4GospB"
  let FITNESS_PLAYLIST_ID = "PL5lPziO_t_VihSUj6jvYDHpt4ZcPhV2bg"
  let API_KEY = "AIzaSyBOvrjh20W_RViLrB_11o6xIC-tbnRiOsg"
  
  var videoArray: [Video] = [Video]()
		
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    activityIndicator.isHidden = true
    videoArray.removeAll()
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    videoArray.removeAll()
  }
  
  func fetchVideo(from playlist: String){
    
    self.activityIndicator.isHidden = false
    self.activityIndicator.startAnimating()
    
    Alamofire.request(YOUTUBE_URL,
                      method: HTTPMethod.get,
                      parameters: ["part": "snippet",
                                   "playlistId": playlist,
                                   "key": API_KEY,
                                   "maxResults": 20],
                      encoding: URLEncoding.queryString,
                      headers: nil)
      .responseJSON { response in
        if let req = response.request{
          print("\n\(req)\n")
        }
        if let value = response.result.value {
          let json = JSON(value)
          //print(json)
          for videoItem in json["items"].array!{
            
            //Parse json response to gather video information
            let videoTitle = videoItem["snippet"]["title"].string!
            let videoId = videoItem["snippet"]["resourceId"]["videoId"].string!
            let thumbnailURL = URL(string: videoItem["snippet"]["thumbnails"]["high"]["url"].string!)!
            
            //print("\n\(videoTitle) - \(videoId) - \(thumbnailURL)\n")
            //Construct Video instance
            let video = Video(title: videoTitle,
                              id: videoId,
                              thumbnailURL: thumbnailURL)
            self.videoArray.append(video)
          }
        }
        self.activityIndicator.isHidden = true
        self.performSegue(withIdentifier: "toVideoPlaylist", sender: self)
    }
}
  
  @IBAction func selectMotivationalVideoPlaylist(_ sender: UIButton) {
    fetchVideo(from: MOTIVATIONAL_PLAYLIST_ID)
  }
  
  @IBAction func selectBodybuildingVideoPlaylist(_ sender: UIButton) {
    fetchVideo(from: BODYBUILDING_PLAYLIST_ID)
  }
  
  @IBAction func selectFitnessPlaylist(_ sender: UIButton) {
    fetchVideo(from: FITNESS_PLAYLIST_ID)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let videoPlaylistViewController = segue.destination as? VideoPlaylistTableViewController{
      videoPlaylistViewController.videoArray = videoArray
    }
  }
  
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
    
  }
}
