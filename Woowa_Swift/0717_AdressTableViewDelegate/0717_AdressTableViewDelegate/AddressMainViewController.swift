//
//  AddressMainViewController.swift
//  0717_AdressTableViewDelegate
//
//  Created by woowabrothers on 2017. 7. 17..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import AVFoundation

class AddressMainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let synthesizer = AVSpeechSynthesizer()
    var nameArray = [
        [ "ᄀ": ["김다인", "김수완", "김준영", "김하은", "김형종"] ],
        [ "ᄇ": ["박예준", "박진수"]],
        [ "ᄉ": ["서동욱", "송통일"]],
        [ "ᄋ": ["양재형", "오세훈", "이단비", "이미정", "이정웅", "이준범"]],
        [ "ᄌ": ["전한나"]],
        [ "ᄎ": ["최송이", "최혜선"]],
        [ "ᄒ": ["한민호", "한지웅", "홍성호", "홍창남", "황예린"]]]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func speakSomething(name: String) {
        synthesizer.stopSpeaking(at: .immediate)
        let mutableName: NSMutableString = NSMutableString.init(string: name)
        CFStringTransform(mutableName, nil, kCFStringTransformToLatin, Bool(0))
        let utterance = AVSpeechUtterance(string: String(mutableName))
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
}

extension AddressMainViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return nameArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].first!.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = nameArray[indexPath.section].first!.value[indexPath.row]
//        let holdToDelete = UILongPressGestureRecognizer(target: self, action: #selector(longPressDelete));

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return nameArray[section].first?.key
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        self.speakSomething(name: nameArray[indexPath.section].first!.value[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 50
        } else {
            return 40
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let key = nameArray[indexPath.section].keys.first else { return }
            nameArray[indexPath.section][key]?.remove(at: indexPath.row)
            if nameArray[indexPath.section][key]?.count == 0 {
                nameArray.remove(at: indexPath.section)
            }
            //reloadData를 호출하면 delegate가 자동으로 호출되어 갱신된다
            //reloadData는 CollectionView에서 데이터 변경 후 호출해주면 된다.
            tableView.reloadData()
            print(nameArray)
        }
    }
}
