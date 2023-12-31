//
//  FirstPageVC.swift
//  Blessed
//
//  Created by woonKim on 2023/12/23.
//

import UIKit

class FirstPageVC: UIViewController {
    
    var wordData: WordData = WordData()
    
    @IBOutlet weak var viewForContent: UIView!
    @IBOutlet weak var wordLbl: UILabel!
    @IBOutlet weak var wordChapterLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        wordLbl.font = UIFont(name: "Kefa", size: 22)
        wordLbl.textAlignment = .center
        wordLbl.numberOfLines = 0
        wordLbl.text = Array(wordData.wordDictionary.values)[0]

        wordChapterLbl.font = UIFont(name: "Kefa", size: 16)
        wordChapterLbl.textAlignment = .center
        wordChapterLbl.text = Array(wordData.wordDictionary.keys)[0]
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetWordLbl(_:)), name: Notification.Name("resetWordLblFirstPageVC"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetWordChapterLbl(_:)), name: Notification.Name("resetWordChapterLblFirstPageVC"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(wordLblColorToBlack(_:)), name: Notification.Name("wordLblColorToBlack"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(wordChapterLblColorToBlack(_:)), name: Notification.Name("wordChapterLblColorToBlack"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(wordLblColorToWhite(_:)), name: Notification.Name("wordLblColorToWhite"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(wordChapterLblColorToWhite(_:)), name: Notification.Name("wordChapterLblColorToWhite"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(viewBackgroundColorChange(_:)), name: Notification.Name("viewBackgroundColorChange"), object: nil)
    }
    
    private func vcInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    @objc func resetWordLbl(_ notification: Notification) {
        viewForContent.fadeOut()
        if let text = notification.object as? String {
            wordLbl.text = text
        }
        viewForContent.fadeIn()
    }
    
    @objc func resetWordChapterLbl(_ notification: Notification) {
        viewForContent.fadeOut()
        if let text = notification.object as? String {
            wordChapterLbl.text = text
        }
        viewForContent.fadeIn()
    }
    
    @objc func wordLblColorToBlack(_ notification: Notification) {
        viewForContent.fadeOut()
        wordLbl.textColor = .black
        viewForContent.fadeIn()
    }
    
    @objc func wordChapterLblColorToBlack(_ notification: Notification) {
        viewForContent.fadeOut()
        wordChapterLbl.textColor = .black
        viewForContent.fadeIn()
    }
    
    @objc func wordLblColorToWhite(_ notification: Notification) {
        viewForContent.fadeOut()
        wordLbl.textColor = .white
        viewForContent.fadeIn()
    }
    
    @objc func wordChapterLblColorToWhite(_ notification: Notification) {
        viewForContent.fadeOut()
        wordChapterLbl.textColor = .white
        viewForContent.fadeIn()
    }
    
    @objc func viewBackgroundColorChange(_ notification: Notification) {
    
        if let color = notification.object as? String {
            print(color)
            self.view.backgroundColor = UIColor(named: color)
        }
    }
}




