//
//  NowPlayingViewController.swift
//  MusicPlayerII - with persistence
//
//  Created by mlee73 on 5/3/18.
//  Copyright © 2018 mlee. All rights reserved.
//

import UIKit
import AVFoundation

class NowPlayingViewController: UIViewController {
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func favButton(_ sender: UIButton) {
        //on click, check for duplicate entries in favorites array, and append to it if not
        if favTracks.count > 0 {
            for check in 0..<favTracks.count{
                if currentTrack?.album == favTracks[check].album && currentTrack?.artist == favTracks[check].artist && currentTrack?.track == favTracks[check].track{
                    print("Duplicate entry!")
                    print(check)
                    dupeCheck = true
                    break
                }
                else{
                    print("Not a dupe")
                }
            }
            if dupeCheck == false{
                favTracks.append(currentTrack!)
                //save persistence
                save()
            }
            else {
                dupeCheck = false
            }
            
        }
        else {
            favTracks.append(currentTrack!)
            //save persistence
            save()
            
        }
    }
    
    var currentTrack: Track?
    var player = AVPlayer()
    var dupeCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        artistLabel.text = currentTrack?.artist
        trackLabel.text = currentTrack?.track
        albumLabel.text = currentTrack?.album
        
        if let albumArt = currentTrack?.artwork{
            let task = URLSession.shared.dataTask(with: URL(string: albumArt)!){data, response, error in
                print ("in data task completion handler")
                
                var displayImage:UIImage?
                if let error = error {
                    print("Error in loadImage() \(error)")
                }
                
                if let imageData = data {
                    displayImage = UIImage(data: imageData)
                }
                
                DispatchQueue.main.async {
                    self.imgView.image = displayImage
                }
            }
            task.resume()
        }
    
        
        // Do any additional setup after loading the view.
        
        //play the track
        if let previewURLString = currentTrack?.previewURL,
            let previewURL = URL(string: previewURLString){
            player = AVPlayer(url: previewURL)
            player.play()
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
