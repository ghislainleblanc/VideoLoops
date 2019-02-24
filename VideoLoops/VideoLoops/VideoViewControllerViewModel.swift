//
//  VideoViewControllerViewModel.swift
//  VideoLoops
//
//  Created by Ghislain Leblanc on 2019-02-24.
//  Copyright © 2019 Ghislain Leblanc. All rights reserved.
//

import AVFoundation

class VideoViewControllerViewModel {
    private var player: AVQueuePlayer!
    private var playerLayer: AVPlayerLayer!
    private var playerItem: AVPlayerItem!
    private var playerLooper: AVPlayerLooper!
    private var filename: String
    private var playIntroState = true

    var viewLayer: AVPlayerLayer {
        let path = Bundle.main.path(forResource: filename, ofType: "mp4")
        let pathURL = URL(fileURLWithPath: path!)

        player = AVQueuePlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerItem = AVPlayerItem(url: pathURL)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill

        return playerLayer
    }

    init(filename: String) {
        self.filename = filename
    }

    func play() {
        if playIntroState == true {
            playIntro()
            playIntroState = false
        } else {
            playFull()
            playIntroState = true
        }
    }

    private func playIntro() {
        player.removeAllItems()
        let range = CMTimeRange(start: CMTime.zero, end: CMTimeMake(value: 6, timescale: 1))
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem, timeRange: range)
        player.play()
    }

    private func playFull() {
        player.removeAllItems()
        let range = CMTimeRange(start: CMTime.zero, end: playerItem!.asset.duration)
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem, timeRange: range)
        player.play()
    }
}
