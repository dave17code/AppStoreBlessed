//
//  ViewController.swift
//  Blessed
//
//  Created by woonKim on 2023/12/20.
//

import UIKit

class ViewController: UIPageViewController {
    
    private var pages = [UIViewController]()
    private var initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupPage() {
        
        var wordData = wordData().words
        
        let firstKey = wordData.randomElement()!.key
        let firstValue = wordData.randomElement()!.value
        let page1 = PageContentsViewController(wordChapter: firstKey, word: firstValue)
        wordData[firstKey] = nil
        
        let secondKey = wordData.randomElement()!.key
        let secondValue = wordData.randomElement()!.value
        let page2 = PageContentsViewController(wordChapter: secondKey, word: secondValue)
        wordData[secondKey] = nil
        
        let thirdKey = wordData.randomElement()!.key
        let thirdValue = wordData.randomElement()!.value
        let page3 = PageContentsViewController(wordChapter: thirdKey, word: thirdValue)
        wordData[secondKey] = nil
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
    }
    
    private func setupUI() {
        // ⭐️ dataSource 화면에 보여질 뷰컨트롤러들을 관리합니다 ⭐️
        self.dataSource = self
        // UIPageViewController에서 처음 보여질 뷰컨트롤러 설정 (첫 번째 page)
        self.setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
}

// MARK: - DataSource

extension ViewController: UIPageViewControllerDataSource {
    // 이전 뷰컨트롤러를 리턴 (우측 -> 좌측 슬라이드 제스쳐)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 현재 VC의 인덱스를 구합니다.
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        guard currentIndex > 0 else { return nil }
        return pages[currentIndex - 1]
    }
    
    // 다음 보여질 뷰컨트롤러를 리턴 (좌측 -> 우측 슬라이드 제스쳐)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        guard currentIndex < (pages.count - 1) else { return nil }
        return pages[currentIndex + 1]
    }
}
