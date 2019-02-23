//
//  VideoViewController.swift
//  VideoLoops
//
//  Created by Ghislain Leblanc on 2019-02-23.
//  Copyright © 2019 Ghislain Leblanc. All rights reserved.
//

import UIKit
import AVKit

struct VideoViewControllerViewModel {
    var filename: String
}

class VideoViewController: UIViewController {
    var viewModel: VideoViewControllerViewModel?

    private var player: AVQueuePlayer!
    private var playerLayer: AVPlayerLayer!
    private var playerItem: AVPlayerItem!
    private var playerLooper: AVPlayerLooper!

    override func viewDidLoad() {
        let path = Bundle.main.path(forResource: viewModel?.filename, ofType: "mp4")
        let pathURL = URL(fileURLWithPath: path!)

        player = AVQueuePlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerItem = AVPlayerItem(url: pathURL)
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem,
                                      timeRange: CMTimeRange(start: CMTime.zero, end: CMTimeMake(value: 6, timescale: 1)) )
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.frame = view.layer.bounds
        view.layer.insertSublayer(playerLayer, at: 1)

        player.play()
    }
}
