//
//  PleerViewController.swift
//  Lesson 6. UISlider and Player
//
//  Created by Anton Rubenchik on 15.05.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
/*
 Плеер.
1+ Громче/тише
2+ Перемотка
3- Like
4+ Next/Prev
5+ Circle/Random/Line
6+ Список песен, с возможностью выбрать
7+ 0.5x 2x rate
8+ Название песни
9+ Play|Pause
 */
import UIKit
import AVFoundation
class PleerViewController: UIViewController {

    var numberActiveSong = 0
    var typePlayArray = ["Line","Repeat","Random"]
    var segmentControl = UISegmentedControl()
    
    @IBOutlet weak var titleVolume: UILabel!
    
    @IBOutlet weak var positionSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var speedButton: UIButton!
    @IBOutlet weak var lowSpeedButton: UIButton!
    @IBOutlet weak var highSpeedButton: UIButton!

    @IBOutlet weak var songOneButton: UIButton!
    @IBOutlet weak var songTwoButton: UIButton!
    @IBOutlet weak var songThreeButton: UIButton!
    @IBOutlet weak var songFourButton: UIButton!
    
    var songArray : [(String,String,String)] = [
        ("Kino1","Группа крови",""),
        ("Kino2","Хочу перемен",""),
        ("Alisa","Всё это rock-n-roll",""),
        ("Letov","Всё идёт по плану","")]
    
    var pleer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        volumeSlider.minimumValue = 0.0
        volumeSlider.maximumValue = 1.0
        speedButton.setTitleColor(UIColor.blue, for: .normal)
        songOneButton.setTitleColor(UIColor.blue, for: .normal)
        
        segmentControl = UISegmentedControl(items: typePlayArray)
        segmentControl.frame = CGRect(x: view.frame.midX-100, y: 369, width: 200, height: 44)
        view.addSubview(segmentControl)
        segmentControl.selectedSegmentIndex = 0

        createArray()
        newSong()
        var timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    func createArray() {
        var nameFile = String()
        var nameSong = String()
        var audioPath = String()
        
        for i in 0...songArray.count-1 {
            (nameFile,nameSong,_) = songArray[i]
            audioPath = Bundle.main.path(forResource: nameFile, ofType: "mp3")!
            songArray[i] = (nameFile,nameSong,audioPath)
            switch i {
            case 0: songOneButton.setTitle(nameSong, for: .normal)
            case 1: songTwoButton.setTitle(nameSong, for: .normal)
            case 2: songThreeButton.setTitle(nameSong, for: .normal)
            case 3: songFourButton.setTitle(nameSong, for: .normal)
            default:
                break
            }
        }
    }
    
    func newSong() {
        var audioPath = String()
        (_,_,audioPath) = songArray[numberActiveSong]
        do { try pleer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath)) }
        catch { }
        positionSlider.maximumValue = Float(pleer.duration)
        self.pleer.volume = self.volumeSlider.value
        pleer.enableRate = true
        (_,titleVolume.text!,_) = songArray[numberActiveSong]
        flashButton()
        lowSpeedButton.setTitleColor(UIColor.black, for: .normal)
        speedButton.setTitleColor(UIColor.blue, for: .normal)
        highSpeedButton.setTitleColor(UIColor.black, for: .normal)
        pleer.rate = 1
        pleer.delegate = self
    }
    
    func flashButton() {
        songOneButton.setTitleColor(UIColor.black, for: .normal)
        songTwoButton.setTitleColor(UIColor.black, for: .normal)
        songThreeButton.setTitleColor(UIColor.black, for: .normal)
        songFourButton.setTitleColor(UIColor.black, for: .normal)
        
        switch numberActiveSong {
        case 0: songOneButton.setTitleColor(UIColor.blue, for: .normal)
        case 1: songTwoButton.setTitleColor(UIColor.blue, for: .normal)
        case 2: songThreeButton.setTitleColor(UIColor.blue, for: .normal)
        case 3: songFourButton.setTitleColor(UIColor.blue, for: .normal)
        default:
            break
        }
    }

    @objc func update() {
        // Something cool
        if pleer.isPlaying {
            let x = Float(pleer.currentTime)
            positionSlider.setValue(x, animated: false)
        }
    }
    
    @IBAction func volumeSlider(_ sender: Any) {
        self.pleer.volume = self.volumeSlider.value
    }
    
    @IBAction func positionSlider(_ sender: Any) {
        pleer.currentTime = TimeInterval(positionSlider.value)
    }
    
    @IBAction func playButton(_ sender: Any) {
        self.pleer.play()
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        self.pleer.pause()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if numberActiveSong == songArray.count - 1 { numberActiveSong = 0 }
        else { numberActiveSong += 1}
        newSong()
        self.pleer.play()
        
    }
    
    @IBAction func prevButton(_ sender: Any) {
        if numberActiveSong == 0 { numberActiveSong = songArray.count - 1 }
        else { numberActiveSong -= 1}
        newSong()
        self.pleer.play()
    }
    
    @IBAction func lowSpeedButton(_ sender: Any) {
        lowSpeedButton.setTitleColor(UIColor.blue, for: .normal)
        speedButton.setTitleColor(UIColor.black, for: .normal)
        highSpeedButton.setTitleColor(UIColor.black, for: .normal)
        pleer.rate = 0.5
    }
    
    @IBAction func speedButton(_ sender: Any) {
        lowSpeedButton.setTitleColor(UIColor.black, for: .normal)
        speedButton.setTitleColor(UIColor.blue, for: .normal)
        highSpeedButton.setTitleColor(UIColor.black, for: .normal)
        pleer.rate = 1
    }
    
    @IBAction func highSpeedButton(_ sender: Any) {
        lowSpeedButton.setTitleColor(UIColor.black, for: .normal)
        speedButton.setTitleColor(UIColor.black, for: .normal)
        highSpeedButton.setTitleColor(UIColor.blue, for: .normal)
        pleer.rate = 2
    }
    
    @IBAction func chooseFirstSongButton(_ sender: Any) {
        numberActiveSong = 0
        newSong()
        self.pleer.play()
    }
    
    @IBAction func chooseSecondSongButton(_ sender: Any) {
        numberActiveSong = 1
        newSong()
        self.pleer.play()
    }
    
    @IBAction func chooseThirdSongButton(_ sender: Any) {
        numberActiveSong = 2
        newSong()
        self.pleer.play()
    }
    
    @IBAction func chooseForthSongButton(_ sender: Any) {
        numberActiveSong = 3
        newSong()
        self.pleer.play()
    }
}

extension PleerViewController :AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) { //Song is the end
        if segmentControl.selectedSegmentIndex != 1 { //Not Repeat
            
            if segmentControl.selectedSegmentIndex == 2 { //Random
                numberActiveSong = Int(arc4random_uniform(4))
            }
            else { //Line
                if numberActiveSong == songArray.count - 1 { numberActiveSong = 0 }
                else { numberActiveSong += 1}
            }
        }
        
        newSong()
        self.pleer.play()        
    }
}

