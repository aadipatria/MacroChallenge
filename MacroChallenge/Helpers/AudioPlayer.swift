//
//  AudioPlayer.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 09/11/20.
//

import Foundation
import AVFoundation

class AudioPlayer1 {

  static var audioPlayer:AVAudioPlayer?

  static func playSounds(soundfile: String) {

      if let path = Bundle.main.path(forResource: soundfile, ofType: nil){
        

          do{

              audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
              audioPlayer?.prepareToPlay()
            do {
                  try AVAudioSession.sharedInstance().setCategory(.playback)
               } catch(let error) {
                   print(error.localizedDescription)
               }
              audioPlayer?.play()

          }catch {
              print("Error")
          }
      }
   }
    static func stopSounds(){
        audioPlayer?.stop()
    }
}

class AudioPlayer2 {

  static var audioPlayer:AVAudioPlayer?

  static func playSounds(soundfile: String) {

      if let path = Bundle.main.path(forResource: soundfile, ofType: nil){

          do{

              audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            do {
                  try AVAudioSession.sharedInstance().setCategory(.playback)
               } catch(let error) {
                   print(error.localizedDescription)
               }
              audioPlayer?.prepareToPlay()
              audioPlayer?.play()

          }catch {
              print("Error")
          }
      }
    }
    static func stopSounds(){
        audioPlayer?.stop()
    }
}
