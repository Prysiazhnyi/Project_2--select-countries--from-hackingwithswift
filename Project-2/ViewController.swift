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
    var scoreMax = 0
    var scoreMaxTemp = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Добавляем кнопку "Назад" слева
        let backButton = UIBarButtonItem(title:"Ⓧ", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
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
        
        loadScores()
    }
    
    // Действие при нажатии на кнопку "Назад"
    @objc func backButtonTapped() {
        // Переводим приложение в фоновый режим
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
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
        
        // Анимация уменьшения и подпрыгивания
          UIView.animate(withDuration: 0.5, animations: {
              // Уменьшаем кнопку до 80% от её исходного размера
              sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
          }) { _ in
              // Возвращаемся к исходному размеру с легким подпрыгиванием
              UIView.animate(withDuration: 0.5,
                             delay: 0,
                             usingSpringWithDamping: 0.5,  // Сила пружины, чем меньше значение, тем сильнее эффект подпрыгивания
                             initialSpringVelocity: 0.2,  // Начальная скорость анимации
                             options: [],
                             animations: {
                  sender.transform = .identity
              })
          }
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
        
        if scoreMax < score {
            scoreMax = score
            saveScore()
            alert(title: "Вітаємо", message:  "Ваш новий рекорд: \(scoreMax).")
        }
        
        alert(title: title, message:  "Ваш рахунок: \(score).")
    }
    
    func saveScore() {
        
        let defaults = UserDefaults.standard
        defaults.set(scoreMax, forKey: "scoreMax")
        defaults.set(scoreMaxTemp, forKey: "scoreMaxTemp")
        print("Cохранение \(scoreMax) и \(scoreMaxTemp)")
    }
    
    func alert(title: String, message:  String) {
        let ac = UIAlertController(title: title, message: message , preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Продовжити", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    func loadScores() {
        
        let defaults = UserDefaults.standard
        
        if let savedScoreMax = defaults.object(forKey: "scoreMax") as? Int {
            scoreMax = savedScoreMax
            print("Загрузка scoreMax: \(scoreMax)")
        }
        
        if let savedScoreMaxTemp = defaults.object(forKey: "scoreMaxTemp") as? Int {
            scoreMaxTemp = savedScoreMaxTemp
            print("Загрузка scoreMaxTemp: \(scoreMaxTemp)")
        }
        
        if scoreMax > scoreMaxTemp {
            scoreMaxTemp = scoreMax
            // alert(title: "Вітаємо", message:  "Ваш рекорд в попередніх іграх: \(scoreMax).")
            saveScore()
            
            let ac = UIAlertController(title: "Вітаємо", message: "Ваш рекорд в попередніх іграх: \(scoreMax)." , preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Продовжити", style: .default, handler: nil))
            present(ac, animated: true)
        }
    }
}

