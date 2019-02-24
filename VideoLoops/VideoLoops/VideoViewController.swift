//
//  VideoViewController.swift
//  VideoLoops
//
//  Created by Ghislain Leblanc on 2019-02-23.
//  Copyright © 2019 Ghislain Leblanc. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    var viewModel: VideoViewControllerViewModel?

    override func viewDidLoad() {
        if let layer = viewModel?.viewLayer {
            layer.frame = view.layer.frame
            view.layer.insertSublayer(layer, at: 1)

            viewModel?.play()
        }
    }

    @IBAction private func didTap() {
        viewModel?.play()
    }
}
