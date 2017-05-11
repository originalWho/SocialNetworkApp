import UIKit

class ChatPageViewController: UIPageViewController {

    // MARK: - Private properties

    fileprivate var pageControl = UIPageControl()
    fileprivate lazy var orderedViewControllers: [UIViewController] = {
        return self.instantiateViewControllers()
    }()

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        guard let firstViewController = orderedViewControllers.first else {
            return
        }

        setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        configurePageControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .clear
    }
}

// MARK: - UIPageViewControllerDelegate protocol

extension ChatPageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let pageContentViewController = pageViewController.viewControllers?[0] else {
            return
        }

        pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }

}

// MARK: - UIPageViewControllerDataSource protocol

extension ChatPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0, orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1

        guard orderedViewControllers.count != nextIndex, orderedViewControllers.count > nextIndex else {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }

}

// MARK: - Private methods

fileprivate extension ChatPageViewController {

    func instantiateViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        guard let historyViewController = storyboard?.instantiateViewController(withIdentifier: "TranslateHistoryViewController"),
            let dictViewController = storyboard?.instantiateViewController(withIdentifier: "DictionaryViewController") else {
                return viewControllers
        }

        viewControllers.append(historyViewController)
        viewControllers.append(dictViewController)

        return viewControllers
    }

    func configurePageControl() {
        let screenBounds = UIScreen.main.bounds
        let frame = CGRect(x: 0, y: screenBounds.maxY - 50, width: screenBounds.width, height: 50)
        pageControl = UIPageControl(frame: frame)
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .black
        self.view.addSubview(pageControl)
    }

}
