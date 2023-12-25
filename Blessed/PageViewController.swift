//
//  PageViewController.swift
//  Blessed
//
//  Created by woonKim on 2023/12/23.
//

import UIKit
import SnapKit
import Then

class PageViewController: UIPageViewController {
    
    var wordDataInPageVC: WordData = WordData()
    
    let pageControl = UIPageControl().then {
        _ in
    }
    
    lazy var vcArray: [UIViewController] = {
        return [self.vcInstance(name: "FirstPageVC"),
                self.vcInstance(name: "SecondPageVC"),
                self.vcInstance(name: "ThirdPageVC")]
    }()
    
    let resetWordBtn = UIButton().then {
        $0.backgroundColor = .yellow
        $0.addTarget(self, action: #selector(resetWordBtnTapped(_:)), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = vcArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        view.addSubview(pageControl)
        pageControl.isEnabled = false
        pageControl.numberOfPages = vcArray.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        
        pageControl.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(170)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(resetWordBtn)
        resetWordBtn.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(100)
            $0.bottom.equalToSuperview().inset(300)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()

        }
    }
    
    private func vcInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    @objc func resetWordBtnTapped(_ sender: Any) {
        
        wordDataInPageVC.wordsShuffle()
        wordDataInPageVC.wordChapterShuffle()
        
        print(wordDataInPageVC.wordChapter)
        
        NotificationCenter.default.post(name: Notification.Name("resetWordLblFirstPageVC"), object: wordDataInPageVC.words[0])
        NotificationCenter.default.post(name: Notification.Name("resetWordChapterLblFirstPageVC"), object: wordDataInPageVC.wordChapter[0])
        
        NotificationCenter.default.post(name: Notification.Name("resetWordLblSecondPageVC"), object: wordDataInPageVC.words[1])
        NotificationCenter.default.post(name: Notification.Name("resetWordChapterLblSecondPageVC"), object: wordDataInPageVC.wordChapter[1])
        
        NotificationCenter.default.post(name: Notification.Name("resetWordLblThirdPageVC"), object: wordDataInPageVC.words[2])
        NotificationCenter.default.post(name: Notification.Name("resetWordChapterLblThirdPageVC"), object: wordDataInPageVC.wordChapter[2])
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 배열에서 현재 페이지의 컨트롤러를 찾아서 해당 인덱스를 현재 인덱스로 기록
        guard let vcIndex = vcArray.firstIndex(of: viewController) else {
            return nil
        }
        
        // 이전 페이지 인덱스
        let prevIndex = vcIndex - 1
        
        // 인덱스가 0 이상이라면 그냥 놔둠
        guard prevIndex >= 0 else {
            return nil
        }
        
        // 인덱스는 vcArray.count 이상이 될 수 없음
        guard vcArray.count > prevIndex else { return nil }
        
        return vcArray[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
        
        // 다음 페이지 인덱스
        let nextIndex = vcIndex + 1
        
        guard nextIndex < vcArray.count else {
            return nil
        }
        
        guard vcArray.count > nextIndex else { return nil }
        
        return vcArray[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = vcArray.firstIndex(of: pageContentViewController)!
    }
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
