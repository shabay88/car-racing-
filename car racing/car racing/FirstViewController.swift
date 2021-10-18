//
//  FirstViewController.swift
//  car racing
//
//  Created by Роман Шабаев on 29.09.2021.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tittleView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShadowoVC()
        setCornerRadiusVC()
        saveSettings()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainVC = segue.destination as? ViewController else { return }
        sendSettings(to: mainVC)
    }
    
    private func sendSettings(to reciever: ViewController) {
        let name = nameTF.text
        reciever.user = name
        let segmentIndex = segmentedControl.selectedSegmentIndex
        reciever.gameSpeedParams = segmentIndex
    }
    
    private func setShadowoVC() {
        setShadow(for: tittleView)
        setShadow(for: mainView)
        setShadow(for: button)
    }
    
    private func setCornerRadiusVC() {
        tittleView.setRoundedCorners(with: 40)
        mainView.setRoundedCorners(with: 40)
        button.setRoundedCorners(with: 30)
    }
    
    private func setShadow(for view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 14
        view.layer.shadowOffset = .zero
    }
    
    @IBAction func startButton(_ sender: Any) {
        UserDefaults.standard.set(nameTF.text, forKey: Controller.nameKey)
        UserDefaults.standard.set(segmentedControl.selectedSegmentIndex, forKey: Controller.controllKey)
    }
    
    private func saveSettings() {
        nameTF.text = UserDefaults.standard.string(forKey: Controller.nameKey)
        segmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: Controller.controllKey)
    }
}

