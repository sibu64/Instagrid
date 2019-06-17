//
//  playSound.swift
//  Instagrid2
//
//  Created by Darrieumerlou on 06/06/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import Foundation
import AVFoundation

// Setting up the click's sound on layout's buttons
class PlaySound {
    private var audioPlayer: AVAudioPlayer?
    private var resource = "sf_souris_01.mp3"
    private var url: URL {
        if let path = Bundle.main.path(forResource: resource, ofType: nil) {
            return URL(fileURLWithPath: path)
        }
        return self.url
    }
    
    // intialization of the player
    init() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch let error {
            print("Error play sound: \(error)")
        }
    }
    
    func playSound() {
        audioPlayer?.play()
    }
    
}
