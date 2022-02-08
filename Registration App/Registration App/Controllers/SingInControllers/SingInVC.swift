import UIKit
import AVFoundation

class SingInVC: UIViewController {
    var player: AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundVideo()
    }

    @IBAction func unwindToViewController(_ unwindSegue: UIStoryboardSegue) {}

    func playBackgroundVideo() {
        let path: String?
        path = Bundle.main.path(forResource: "handsKeyboard", ofType: ".mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        player!.seek(to: CMTime.zero)
        player!.play()
        player?.isMuted = true
    }

    @objc func playerItemDidReachEnd() {
        player!.seek(to: CMTime.zero)
    }
}

