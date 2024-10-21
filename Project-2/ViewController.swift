//
//  ViewController.swift
//  Project-2
//
//  Created by Serhii Prysiazhnyi on 20.10.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var correctLabel: UILabel!
    @IBOutlet var wrongLabel: UILabel!
    @IBOutlet var allGameFact: UILabel!
    
    var countries = [String]()
    var correctAnswers = 0
    var score = 0
    var scoreCorrect = 0
    var scoreWrong = 0
    var totalAnswers = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Ваш рахунок: 0 (0%)"
        correctLabel.text = "Правильних відповідей: 0"
        wrongLabel.text = "Не правильних відповідей: 0"
        allGameFact.text = "Всього відповідей: 0"
        
        countries += ["albania", "armenia", "azerbaijan", "belarus", "belgium", "bosnia and herzegovina", "bulgaria", "croatia", "cyprus", "czech republic", "denmark", "estonia", "finland", "france", "georgia", "germany", "greece", "hungary", "iceland", "ireland", "italy", "kazakhstan", "kyrgyzstan", "latvia", "lithuania", "luxembourg", "malta", "moldova", "monaco", "netherlands", "nigeria", "norway", "poland", "portugal", "romania", "russia", "san marino", "serbia", "slovakia", "slovenia", "spain", "sweden", "switzerland", "turkey", "ukraine", "united kingdom", "usa", "uzbekistan"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        // UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0)
        button1.layer.borderColor =  UIColor.lightGray.cgColor
        button2.layer.borderColor =  UIColor.lightGray.cgColor
        button3.layer.borderColor =  UIColor.lightGray.cgColor
        countries.shuffle()
        askQuestion(action: nil)
    }
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswers = Int.random(in: 0...2)
        title = countries[correctAnswers].uppercased()
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswers {
            title = "Правильно \u{1F60A}"
            score += 1
            scoreCorrect += 1
        } else {
            title = "Помилка \u{1F61E}\n Правильна відповідь: \(correctAnswers + 1)"
            score -= 1
            scoreWrong += 1
        }
        
        if score < 0 {
            score = 0
        }
        
        totalAnswers += 1
        
        scoreLabel.text = "Ваш рахунок: \(score) (\(scoreCorrect * 100 / totalAnswers)%)"
        correctLabel.text = "Правильних відповідей: \(scoreCorrect)"
        wrongLabel.text = "Не правильних відповідей: \(scoreWrong)"
        allGameFact.text = "Всього відповідей: \(totalAnswers)"
        
        let ac = UIAlertController(title: title, message: "Ваш рахунок: \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Продовжити", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
}

