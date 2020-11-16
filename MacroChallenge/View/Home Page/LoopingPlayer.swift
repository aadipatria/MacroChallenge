//
//  LoopingPlayer.swift
//  GifImageSwiftUI
//
//  Created by Yudis Huang on 03/11/20.
//

import SwiftUI
import AVFoundation

struct LoopingPlayer: UIViewRepresentable {
    var player = QueuePlayerUIView(frame: .zero)
    func makeUIView(context: Context) -> some UIView {
        return player
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // do nothing here
    }
}

class QueuePlayerUIView : UIView {
    private var playerLayer = AVPlayerLayer()
    private var playerLooper : AVPlayerLooper?
    var tampungPlayer = AVQueuePlayer()
    
    override init(frame : CGRect){
        super.init(frame: frame)
        
        // Load Video
        let fileUrl = Bundle.main.url(forResource: "forest_bg_1", withExtension: "mov")
        let playerItem = AVPlayerItem(url: fileUrl!)
        
        // Setup Player
        let player = AVQueuePlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Looping video
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        
        // Play
        tampungPlayer = player
        playing()
    }
    func playing(){
        tampungPlayer.play()
    }
    
    
    func moveBackground(name : String){
        
        let fileUrl = Bundle.main.url(forResource: name, withExtension: "mov")
        
        let playerItem = AVPlayerItem(url: fileUrl!)
        
        tampungPlayer.replaceCurrentItem(with: playerItem)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
}

struct LoopingPlayer_Previews: PreviewProvider {
    static var previews: some View {
        LoopingPlayer()
    }
}
//a
