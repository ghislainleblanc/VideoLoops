//
//  ViewController.swift
//  VideoLoops
//
//  Created by Ghislain Leblanc on 2019-02-23.
//  Copyright © 2019 Ghislain Leblanc. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    private var player: AVQueuePlayer!
    private var playerLayer: AVPlayerLayer!
    private var playerItem: AVPlayerItem!
    private var playerLooper: AVPlayerLooper!

    private let videos = ["stock-footage-abstract-forms",
                          "stock-footage-flowing-red-particles-red-liquid-creating-smoke",
                          "stock-footage-lotus-root-silk-sugar-a-traditional-chinese-candy-food-in-the-history-now-few-people-will-do-this",
                          "stock-footage-old-cinematic-tape",
                          "stock-footage-scooping-ice-cream-with-ice-cream-scoop-from-the-tub",
                          "stock-footage-textiles-fabric-backgrounds"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: videos[2], ofType: "mp4")
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

