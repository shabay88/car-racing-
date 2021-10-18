//  ViewController.swift
//  car racing
//
//  Created by Роман Шабаев on 25.09.2021.

import UIKit

class ViewController: UIViewController {
    private lazy var usernameLabel = UILabel()
    private lazy var carImage = UIImage(named: "car")
    private lazy var carImageView = UIImageView(image: carImage)
    private lazy var dividingStripView = UIView()
    var user: String?
    var gameSpeedParams: Int?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeSetupForViews()
    }
    
    private func makeSetupForViews() {
        makeRoadView()
        makeStripView()
        makeCarSettings()
        setBorderOfRoad()
        makeUserName()
        setTimer()
    }
    
    private func setTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
        timer.fire()
        timer.tolerance = 0.2
    }
    
    private func makeRoadView() {
        let roadView = UIView()
        roadView.backgroundColor = .gray
        roadView.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        view.addSubview(roadView)
    }
    
    private func makeCarSettings() {
        carImageView.frame = CGRect(x: view.frame.midX - 30, y: view.frame.origin.y + 400, width: 65, height: 135)
        view.addSubview(carImageView)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    private func makeUserName() {
        usernameLabel.frame = CGRect(x: carImageView.frame.midX - 20, y: carImageView.frame.midY + 30, width: carImageView.frame.width, height: 100)
        usernameLabel.text = "\(user ?? "")"
        usernameLabel.font = .boldSystemFont(ofSize: 15)
        view.addSubview(usernameLabel)
    }
    
    private func makeStripView() {
        dividingStripView.backgroundColor = .white
        dividingStripView.frame = CGRect(x: view.frame.midX - 5, y: -200, width: 15, height: 120)
        makeStripAnimationFast(dividingStripView)
        view.addSubview(dividingStripView)
    }
    
    private func makeStoneView() {
        let stoneImage = UIImage(named: "stone")
        let stoneView = UIImageView(image: stoneImage)
        let randomSize = makeRandomSize()
        stoneView.frame.origin = CGPoint(x: .random(in: 20...view.frame.width - 55), y: -100)
        stoneView.frame.size = randomSize
        view.addSubview(stoneView)
        makeStoneAnimation(stoneView)
    }
    
    private func setBorderOfRoad() {
        let leftBorderView = UIView()
        leftBorderView.backgroundColor = .orange
        leftBorderView.frame = CGRect(x: leftBorderView.frame.origin.y - 10, y: leftBorderView.frame.origin.y, width: view.frame.width - 390, height: view.frame.height)
        view.addSubview(leftBorderView)
        let rightBorderView = UIView()
        rightBorderView.backgroundColor = .orange
        rightBorderView.frame = CGRect(x: rightBorderView.frame.origin.x + 400, y: rightBorderView.frame.origin.y, width: view.frame.width - 390, height: view.frame.height)
        view.addSubview(rightBorderView)
    }
    
    private func makeRandomSize() -> CGSize {
        CGSize(width: .random(in: 50...70), height: .random(in: 50...70))
    }
    
    private func makeCarAnimation(_ targetView: UIView) {
        UIView.animateKeyframes(withDuration: 1,
                                delay: 0,
                                options: [ .repeat ],
                                animations:
                                    { self.carImageView.frame.origin = CGPoint(x: targetView.frame.origin.x,
                                                                               y: targetView.frame.origin.y) },
                                completion: nil)
    }
    
    private func makeStripAnimationFast(_ targetView: UIView) {
        switch gameSpeedParams {
        case 0:
            UIView.animateKeyframes(withDuration: 4,
                                    delay: 0,
                                    options: [ .repeat ],
                                    animations:
                                        { targetView.frame.origin = CGPoint(x: targetView.frame.origin.x, y: targetView.frame.origin.y + self.view.frame.height + 300) }, completion: nil)
        case 1:
            UIView.animateKeyframes(withDuration: 2.5,
                                    delay: 0,
                                    options: [ .repeat ],
                                    animations:
                                        { targetView.frame.origin = CGPoint(x: targetView.frame.origin.x, y: targetView.frame.origin.y + self.view.frame.height + 300) }, completion: nil)
        case 2:
            UIView.animateKeyframes(withDuration: 1,
                                    delay: 0,
                                    options: [ .repeat ],
                                    animations:
                                        { targetView.frame.origin = CGPoint(x: targetView.frame.origin.x, y: targetView.frame.origin.y + self.view.frame.height + 300) }, completion: nil)
        default:
            print("error")
        }
    }
    
    private func makeStoneAnimation(_ targetView: UIView) {
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: [], animations: { targetView.frame.origin = CGPoint(x: targetView.frame.origin.x, y: targetView.frame.origin.y + self.view.frame.height + 150) }, completion: {_ in targetView.removeFromSuperview()})
    }
    
    private func moveCarRight(_ targetView: UIView) {
        UIView.animateKeyframes(withDuration: 0.3,
                                delay: 0,
                                options: [],
                                animations:
                                    { targetView.frame.origin = CGPoint(x: targetView.frame.origin.x - 50,
                                                                        y: targetView.frame.origin.y) },
                                completion: nil)
    }
    
    private func moveCarLeft(_ targetView: UIView) {
        UIView.animateKeyframes(withDuration: 0.3,
                                delay: 0,
                                options:  [],
                                animations:
                                    { targetView.frame.origin = CGPoint(x: targetView.frame.origin.x + 50,
                                                                        y: targetView.frame.origin.y) },
                                completion: nil)
    }
    
    @objc private func handleTimer(_ sender: Timer){
        makeStoneView()
    }
    
    @objc private func handleRightSwipe(_ sender: UISwipeGestureRecognizer) {
        moveCarLeft(carImageView)
        moveCarLeft(usernameLabel)
    }
    
    @objc private func handleLeftSwipe(_ sender: UISwipeGestureRecognizer) {
        moveCarRight(carImageView)
        moveCarRight(usernameLabel)
    }
}
