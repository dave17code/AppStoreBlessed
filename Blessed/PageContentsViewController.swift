//
//  PageContentsViewController.swift
//  Blessed
//
//  Created by woonKim on 2023/12/21.
//

import UIKit
import SnapKit
import Then

class PageContentsViewController: UIViewController {
    
    private var wordLayoutView = UIView()
    private var wordChapter = UILabel()
    private var word = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(wordChapter: String, word: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.wordChapter.text = wordChapter
        self.word.text = word
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
    }
        
}
