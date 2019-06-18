//
//  ViewController.swift
//  stopWatch
//
//  Created by Ayo Olabode on 2019-06-04.
//  Copyright © 2019 Phidgets. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var SelectedSoundFileName : String = "alarm"
    
    
    
    // variable for AudioPlayer/ Sound Arrays
    var player: AVAudioPlayer?

    //Variables to start off with
    var isPlaying = true
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    
    
    
    @IBOutlet weak var label: UILabel!
   
    //This is the function that plays a sound
    func playSound() {
        let url =
            Bundle.main.url(forResource: SelectedSoundFileName, withExtension: "wav")
        
        do {
            player = try
                AVAudioPlayer(contentsOf: url!)
            guard let player =
                player else {return}
            
            player.prepareToPlay()
            player.play()
        }
        catch let error as NSError {
            print (error)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = timeString(time: TimeInterval(seconds))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   
    // Plays sound when button pressed and changes immage to pause and vice versa
    @IBAction func runAcion(_ sender: Any) {
        if isTimerRunning == false {
            runTimer()
            runButton.setImage(UIImage(named:"pause"), for: .normal)
        } else {
            isTimerRunning = false
            timer.invalidate()
            runButton.setImage(UIImage(named:"play"), for: .normal)
        }
        
    }
    
    //stops sound and reset timer
    @IBAction func resetAction(_ sender: Any) {
        timer.invalidate()
        player?.stop()
        player?.currentTime = 0
        isTimerRunning = false
        runButton.setImage(UIImage(named: "play"), for: .normal)
        seconds = 60
        label.text = timeString(time: TimeInterval(seconds))
        } 
    
    //run timer function
    func runTimer  () {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    
    }
     //function to update the numerical values of the timer
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
              playSound()
           //send alert (timer ran out)
        } else {
            seconds -= 1
            label.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    

        
    


        
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
        
    }

    
   
        
      
        
    
    
    
    
    
    
  


    }
