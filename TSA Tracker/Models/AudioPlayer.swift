//
//  AudioPlayer.swift
//  TSA Tracker
//
//  Created by Emmanuel Onouha on 6/26/22.
//

import Foundation

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            //uncomment for size
            //audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            //audioPlayer?.play()
            
        }
        catch
        {
            print("Could not play sound file.")
        }
    }
}
