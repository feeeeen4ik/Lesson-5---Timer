//
//  ViewController.swift
//  Lesson 5 - Timer
//
//  Created by Феликс on 06.10.2025.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet weak var firstDatePicker: UIDatePicker!
    @IBOutlet weak var secondDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TimerVC" {
             if let timerVC = segue.destination as? TimerViewController {
                 timerVC.firstDate = firstDatePicker.date
                 timerVC.secondDate = secondDatePicker.date
            }
        }
    }
}

