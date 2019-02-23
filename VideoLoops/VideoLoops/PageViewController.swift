//
//  PageViewController.swift
//  VideoLoops
//
//  Created by Ghislain Leblanc on 2019-02-23.
//  Copyright © 2019 Ghislain Leblanc. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    private let videos = ["stock-footage-abstract-forms",
                          "stock-footage-flowing-red-particles-red-liquid-creating-smoke",
                          "stock-footage-lotus-root-silk-sugar-a-traditional-chinese-candy-food-in-the-history-now-few-people-will-do-this",
                          "stock-footage-old-cinematic-tape",
                          "stock-footage-scooping-ice-cream-with-ice-cream-scoop-from-the-tub",
                          "stock-footage-textiles-fabric-backgrounds"]

    fileprivate var orderedViewControllers = [VideoViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self

        videos.forEach {
            orderedViewControllers.append(videoViewController(fileName: $0))
        }

        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }

    fileprivate func videoViewController(fileName: String) -> VideoViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let videoViewController = storyboard.instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController

        videoViewController.viewModel = VideoViewControllerViewModel(filename: fileName)

        return videoViewController
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let videoViewController = viewController as? VideoViewController, let viewControllerIndex = orderedViewControllers.index(of: videoViewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let videoViewController = viewController as? VideoViewController, let viewControllerIndex = orderedViewControllers.index(of: videoViewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }

        guard orderedViewControllersCount > nextIndex else {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first as? VideoViewController,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }

        return firstViewControllerIndex
    }
}
