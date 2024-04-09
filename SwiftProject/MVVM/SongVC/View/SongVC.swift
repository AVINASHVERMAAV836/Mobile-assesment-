//
//  SongVC.swift
//  SwiftProject
//
//  Created by Admin on 03/04/24.
//

import UIKit
import AVFoundation

//MARK: @IBOutlet.........................
class SongVC: UIViewController {
    
    @IBOutlet weak var songCV: UICollectionView!
    @IBOutlet weak var backgroundBlurImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButtion: UIButton!
    @IBOutlet weak var previousButtion: UIButton!
    @IBOutlet weak var songCurrentDuration: UILabel!
    @IBOutlet weak var songOverallDuration: UILabel!
    @IBOutlet weak var playbackSlider: UISlider!
    
    var songResponseData: [ForyouResponseData]?
    var selectedIndex = 0
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var songAsset: AVAsset?
    var timer: Timer?
    var count:Int = 0
    var totalDuration:Int = 0
    var progress = 0
    
}

//MARK: View Controller life Cycle......................
extension SongVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        songCV.register(UINib(nibName: "SongCVCell", bundle: nil), forCellWithReuseIdentifier: "SongCVCell")
        backgroundBlurImage.applyBlurEffect()
        playbackSlider.minimumValue = 0
        playTrack(at: selectedIndex)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
        AudioPlayer.shared.stop()
        AudioPlayer.shared.player = nil
    }
    
}

extension SongVC{
    
    @IBAction func playActBtn(_ sender: UIButton){
//        if AudioPlayer.shared.player?.rate == 0
//        AudioPlayer.shared.stop()
    }
    
    @IBAction func previousActBtn(_ sender: UIButton){
        
    }
    
    @IBAction func nextActBtn(_ sender: UIButton){
        
    }
    

    func secondsToMinuteSecond(seconds: Int) -> (Int,Int){
        return (((seconds % 3600) / 60) , ((seconds % 3600) % 60))
    }
    
    func makeTimeString(minutes: Int, seconds: Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    func stopTimer() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
    }
    @objc func timerCounter() -> Void{
//        player?.play()
//        let progress = (100/totalDuration)
//        self.progress += progress
//        self.playbackSlider.value = Float(self.progress)
        count = count + 1
        print(count)
       
        self.playbackSlider.value = (Float(count)*0.01)
        self.playbackSlider.isContinuous = true
        
        if totalDuration == count{
            stopTimer()
            AudioPlayer.shared.stop()
            AudioPlayer.shared.player = nil
            let time  = secondsToMinuteSecond(seconds: count)
            let timeString = makeTimeString(minutes: time.0, seconds: time.1)
            songCurrentDuration.text = timeString
        }else {
            let time  = secondsToMinuteSecond(seconds: count)
            let timeString = makeTimeString(minutes: time.0, seconds: time.1)
            songCurrentDuration.text = timeString
        }
    }
    
    func playTrack(at index: Int){
        stopTimer()
        AudioPlayer.shared.stop()
        self.songName.text = songResponseData?[index].name ?? ""
        self.artistName.text = songResponseData?[index].artist ?? ""
        let url = URL(string: songResponseData?[index].url ?? "")!
        AudioPlayer.shared.play(url: url)
//        playerItem = AVPlayerItem(url: url)
//        player = AVPlayer(playerItem: playerItem)
        let asset = AVAsset(url: url)
        let duration = CMTime(value: CMTimeValue(asset.duration.seconds), timescale: 1)
        let totalSeconds = duration.seconds
        totalDuration = Int(totalSeconds)
        
        let minutes = Int(totalSeconds.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        let mediaDuration = makeTimeString(minutes: minutes, seconds: seconds)
        songOverallDuration.text = mediaDuration
        
//        player?.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        playbackSlider.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
    {
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        AudioPlayer.shared.player!.seek(to: targetTime)
        
        if AudioPlayer.shared.player!.rate == 0
        {
            AudioPlayer.shared.player?.play()
        }
    }
    
}

//MARK: UICollectionView Delegate and Datasource......................
extension SongVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songResponseData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = songCV.dequeueReusableCell(withReuseIdentifier: "SongCVCell", for: indexPath) as? SongCVCell else{
            return UICollectionViewCell()
        }
        
        let coverId = songResponseData?[selectedIndex].cover ?? ""
        let url = URL(string: "\(imageUrl)\(coverId)")
        cell.coverImage?.sd_setImage(with: url)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: songCV.frame.size.width, height: songCV.frame.size.height )
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        //Calculate leftInset and rightInset
//        let leftInset: CGFloat = (collectionView.frame.width * 0.5) - (330 * 0.5)
//        let rightInset: CGFloat = (collectionView.frame.width * 0.5) - (330 * 0.5)
//        
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        self.snapToNearestCell(scrollView: scrollView)
//    }
//    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.snapToNearestCell(scrollView: scrollView)
    }

    
    func snapToNearestCell(scrollView: UIScrollView) {
        let middlePoint = Int(scrollView.contentOffset.x + UIScreen.main.bounds.width / 2)
        if let indexPath = self.songCV.indexPathForItem(at: CGPoint(x: middlePoint, y: 0)) {
            self.songCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//            AudioPlayer.shared.stop()
//            AudioPlayer.shared.player = nil
            selectedIndex = indexPath.row
            playTrack(at: selectedIndex)
        }
    }
    
    
    
    
    
}


extension UIImageView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
