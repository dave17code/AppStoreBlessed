//
//  PageViewController.swift
//  Blessed
//
//  Created by woonKim on 2023/12/23.
//

import UIKit

class ViewController: UIViewController {
        
    var wordData: WordData = WordData()
    
    @IBOutlet weak var bibleAnimation: UIImageView!
    @IBOutlet weak var wordLbl: UILabel!
    @IBOutlet weak var wordChapterLbl: UILabel!
    @IBOutlet weak var wordContentView: UIView!
    @IBOutlet weak var wordResetBtn: UIButton!
    @IBOutlet weak var wordContentColorToBlack: UIButton!
    @IBOutlet weak var wordContentColorToWhite: UIButton!
    
//    var colorWell: UIColorWell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        wordLbl.text = Array(wordData.wordDictionary
            .values)[0]
        wordChapterLbl.text = Array(wordData.wordDictionary.keys)[0]
        wordContentColorToBlack.layer.cornerRadius = 17.5
        wordContentColorToWhite.layer.cornerRadius = 17.5
    }
    
    @IBAction func wordRestBtn(_ sender: Any) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        // pi = 180도
        rotation.toValue = Double.pi
        // 1바퀴 도는데 걸리는 시간
        rotation.duration = 0.5
        // 반복 횟수 = infinity(무한대)
        rotation.repeatCount = 1
        wordResetBtn.layer.add(rotation, forKey: "rotationAnimation")
        
        wordData.resetWordDictionaryData = Dictionary(uniqueKeysWithValues: wordData.wordDictionary.shuffled())
        
        wordContentView.fadeOut()
        wordLbl.text = Array(wordData.resetWordDictionaryData.values)[0]
        wordChapterLbl.text = Array(wordData.resetWordDictionaryData.keys)[0]
        wordContentView.fadeIn()
    }
    

    
    @objc func wordLblTextColorToBlack(_ sender: Any) {
    }
    
    @objc func wordChapterLblTextColorToBlack(_ sender: Any) {
    }
    
    @objc func wordLblTextColorToWhite(_ sender: Any) {
    }
    
    @objc func wordChapterLblTextColorToWhite(_ sender: Any) {
    }
    
//    func addColorWell() {
//        colorWell = UIColorWell(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
//        self.customizeColorStackView.addSubview(colorWell)
//        colorWell.addTarget(self, action: #selector(viewBackgroundColorChange(_:)), for: .valueChanged)
//    }
//
//    @objc func viewBackgroundColorChange(_ sender: Any) {
//        self.view.backgroundColor = colorWell.selectedColor
//    }
}

public extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
}
