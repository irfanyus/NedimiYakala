//
//  ViewController.swift
//  CatchTheNedim
//
//  Created by irfan bağcı on 16.11.2020.
//

import UIKit

class ViewController: UIViewController {

    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var nedimArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var nedim1: UIImageView!
    @IBOutlet weak var nedim2: UIImageView!
    @IBOutlet weak var nedim3: UIImageView!
    @IBOutlet weak var nedim4: UIImageView!
    @IBOutlet weak var nedim5: UIImageView!
    @IBOutlet weak var nedim6: UIImageView!
    @IBOutlet weak var nedim7: UIImageView!
    @IBOutlet weak var nedim8: UIImageView!
    @IBOutlet weak var nedim9: UIImageView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        //highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil{
            highScore = 0
            highscoreLabel.text = "Highscore \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore \(highScore)"
        }
        
        
        
        //Images
        nedim1.isUserInteractionEnabled = true
        nedim2.isUserInteractionEnabled = true
        nedim3.isUserInteractionEnabled = true
        nedim4.isUserInteractionEnabled = true
        nedim5.isUserInteractionEnabled = true
        nedim6.isUserInteractionEnabled = true
        nedim7.isUserInteractionEnabled = true
        nedim8.isUserInteractionEnabled = true
        nedim9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        nedim1.addGestureRecognizer(recognizer1)
        nedim2.addGestureRecognizer(recognizer2)
        nedim3.addGestureRecognizer(recognizer3)
        nedim4.addGestureRecognizer(recognizer4)
        nedim5.addGestureRecognizer(recognizer5)
        nedim6.addGestureRecognizer(recognizer6)
        nedim7.addGestureRecognizer(recognizer7)
        nedim8.addGestureRecognizer(recognizer8)
        nedim9.addGestureRecognizer(recognizer9)
        
        nedimArray = [nedim1,nedim2, nedim3, nedim4, nedim5, nedim6, nedim7, nedim8, nedim9]
        
        
        
        //Timers
        counter = 30
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(hideNedim), userInfo: nil, repeats: true)
        
        
        hideNedim()
    }
    
    
    @objc func hideNedim(){
        for nedim in nedimArray {
            nedim.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(nedimArray.count-1)))
        nedimArray[random].isHidden = false
        
    }
    
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            for nedim in nedimArray {
                nedim.isHidden = true
            }
            
            let alert = UIAlertController(title: "Süre Doldu", message: "Tekrar oyna", preferredStyle: UIAlertController.Style.alert)
            
            let notokButton = UIAlertAction(title: "Hayır", style: UIAlertAction.Style.cancel, handler: nil)
        
            let replayButton = UIAlertAction(title: "Evet", style: UIAlertAction.Style.default) { (_UIAlertAction) in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.hideNedim), userInfo: nil, repeats: true)
                
            }
            
            
            alert.addAction(notokButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
            
            //highscore saklama
            
            if self.score > self.highScore{
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highscore")
                
            }
            
        }
        
    }

    
    
}

