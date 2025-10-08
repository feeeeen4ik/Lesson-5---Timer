//
//  TimerViewController.swift
//  Lesson 5 - Timer
//
//  Created by Феликс on 06.10.2025.
//

import UIKit

final class TimerViewController: UIViewController {

    @IBOutlet weak var firstDateLabel: UILabel!
    @IBOutlet weak var secondDateLabel: UILabel!
    @IBOutlet weak var timerTextLabel: UILabel!
    
    var firstDate = Date()
    var secondDate = Date()
    var timerDate = Date()
    var isTimerRunning = false
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerDate = firstDate
        
        firstDateLabel.text = dateToString(firstDate)
        secondDateLabel.text = dateToString(secondDate)
        timerTextLabel.text = dateToString(timerDate)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        firstDateLabel.layer.cornerRadius = firstDateLabel.frame.height / 2
        secondDateLabel.layer.cornerRadius = secondDateLabel.frame.height / 2
        timerTextLabel.layer.cornerRadius = timerTextLabel.frame.height / 2
        
        firstDateLabel.layer.masksToBounds = true
        secondDateLabel.layer.masksToBounds = true
        timerTextLabel.layer.masksToBounds = true
    }
    

    @IBAction func startTimer(_ sender: Any) {
        if isTimerRunning {
            return
        }
        
        let normalizedFirstDate = normalizeDate(timerDate)
        let normalizedSecondDate = normalizeDate(secondDate)
        
        if normalizedFirstDate >= normalizedSecondDate {
            timerTextLabel.text = "Неверные даты"
            return
        }
        
        
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(countTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        isTimerRunning = false
        timer.invalidate()
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        timer.invalidate()
        isTimerRunning = false
        timerDate = firstDate
        timerTextLabel.text = dateToString(timerDate)
    }
    
    @objc private func countTimer() {
        // не получилось реализовать сравнение именно по Date т.к. не понял как исключить милисекунды
        // по этому сравниваю значение строк
        // пробовал через Calendar и abs(timerDate.timeIntervalSince(secondDate)) < 1, но безрезультатно
//        if timerTextLabel.text == secondDateLabel.text {
//            timer.invalidate()
//            timerTextLabel.text = "всё!"
//            return
//        }
        
        // второе решение
        let normalizedTimerDate = normalizeDate(timerDate)
        let normalizedSecondDate = normalizeDate(secondDate)
        
        if normalizedTimerDate >= normalizedSecondDate {
            timer.invalidate()
            timerTextLabel.text = "всё!"
            return
        } else {
            timerTextLabel.text = dateToString(timerDate)
            timerDate = Calendar.current.date(byAdding: .hour, value: 1, to: timerDate)!
        }
    }
    
    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy, EEE HH:mm"
        return formatter.string(from: date)
    }
    
    func normalizeDate(_ date: Date) -> Date {
        var components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date
        )
        components.nanosecond = 0
        return Calendar.current.date(from: components)!
    }
}
