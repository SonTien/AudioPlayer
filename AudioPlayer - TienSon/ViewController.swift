//
//  ViewController.swift
//  AudioPlayer - TienSon
//
//  Created by HoangHai on 6/16/16.
//  Copyright © 2016 Tien Son. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var sld_Duration: UISlider!
    @IBOutlet weak var lbl_TimeTotal: UILabel!
    @IBOutlet weak var lbl_TimePlayed: UILabel!
    @IBOutlet weak var btn_Play: UIButton!
    var audio = AVAudioPlayer()
    var playMusic : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: ".mp3")!))
        audio.prepareToPlay()
        addThumbImg()
        playMusic = false
        let _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(updateTimePlayed), userInfo: nil, repeats: true)
        totalTime()
        audio.delegate = self
    }
    
      func addThumbImg() {
        sld_Volume.setThumbImage(UIImage(named: "thumbHighLight.png"), forState: .Highlighted)
        sld_Duration.setThumbImage(UIImage(named: "duration.png"), forState: .Normal)
        sld_Duration.setThumbImage(UIImage(named: "duration.png"), forState: .Highlighted)
    }
    
    func updateTimePlayed() {
        let soPhut = Int(audio.currentTime/60)
        let soDu = Int(audio.currentTime) - soPhut*60
        self.lbl_TimePlayed.text = String(format: "\(soPhut):\(soDu)", audio.currentTime)
        self.sld_Duration.value = Float(audio.currentTime/audio.duration)
    }
    
    func totalTime() {
        lbl_TimeTotal.text = String(audio.duration)
        let soPhut2 = Int(audio.duration/60)
        let soDu2 = Int(audio.duration) - soPhut2*60
        self.lbl_TimeTotal.text = String(format: "\(soPhut2):\(soDu2)", audio.duration)
    }
    @IBOutlet weak var sld_Volume: UISlider!
    @IBAction func action_Play(sender: UIButton) {
        if playMusic == true {
            btn_Play.setImage(UIImage(named: "play.png"), forState: .Normal)
            audio.stop()
            playMusic = false
        }
        else {
            btn_Play.setImage(UIImage(named: "pause.png"), forState: .Normal)
            audio.play()
            playMusic = true
        }
    }
    @IBAction func sld_Volume(sender: UISlider) {
        audio.volume = sender.value
    }
    @IBAction func sld_Duration(sender: UISlider) {
        audio.currentTime = Double(sender.value) * audio.duration
    }

    @IBAction func `switch`(sender: UISwitch) {
        if (sender.on == true) {
            audio.numberOfLoops = -1
        }
        else {
            audio.numberOfLoops = 0
        }
      }

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        btn_Play.setImage(UIImage(named: "play.png"), forState: .Normal)
        }
}

