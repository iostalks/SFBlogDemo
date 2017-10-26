//
//  ViewController.swift
//  BugTest
//
//  Created by bong on 2017/10/23.
//  Copyright © 2017年 Smallfly. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let url = URL(fileURLWithPath: LocalFile.LandingVedio.path())
            player = AVPlayer(url: url)
            NotificationCenter.default.addObserver(
                self, selector: #selector(playToEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        player?.play()
    }
    
    @objc func playToEnd(_ notification: Notification) {
        print("play to end")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var filp: UIButton!
    @IBAction func flip(_ sender: Any) {
        let collectionview = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CollectionViewController")
        UIApplication.shared.keyWindow?.rootViewController = collectionview
    }
}


enum LocalFile: String {
    case LandingVedio = "LandingMV"
    
    func path() -> String {
        return Bundle.main.path(forResource: self.rawValue, ofType: "mp4")!
    }
}
