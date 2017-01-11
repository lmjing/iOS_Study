//
//  MeetingRoomsListViewController.swift
//  MeetingRooms
//
//  Created by 이미정 on 2017. 1. 11..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class MeetingRoomsListViewController: UITableViewController {
    
    //1단계 : 딕셔너리 선언 후 해당 데이터 값 한 섹션에 순서 상관 없이 표시
    //var MeetingRooms:[String:Int] = ["Banksy":4,"Rivera":8,"Kahlo":8,"Picasso":10,"Cezanne":20,"Matisse":30,"Renoir":40]
    //2단계 : 2중 딕셔너리(?) 제작하여 섹션 나누어 줄 예정 ( 순서에 대한걸 전혀 다루지 않았는데, 결과 값이 다름. 무슨 차이인지 모르겠음 )
    var MeetingRooms:[String:[String:Int]] = ["Meeting":["Banksy":4,"Rivera":8,"Kahlo":8,"Picasso":10],"Seminar":["Cezanne":20,"Matisse":30,"Renoir":40]]
    /*
     * 3단계 : header & footer 생성
     * option키 + 단어 누르면 해당 레퍼런스 페이지로 이동 가능
     * header, footer은 필수는 아니지만 선택적인 사항으로 필요할 경우 선언하여 사용하면 된다.
     */

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //1단계 : 섹션 하나
        //return 1
        
        //2단계 : 딕셔너리의 개수 = 섹션 개수
        return MeetingRooms.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //1단계 : 배열의 개수 = 총 row의 개수
        //return MeetingRooms.count
        
        //2단계 : 섹션 별 개수가 다르기 때문에 각각의 개수 반환
        let categoryValues = Array(MeetingRooms.values)[section] // 딕셔너리의 value(방 정보)만 따로 배열 형태로 가져오고, 각 섹션 인덱스 값으로 찾는다.
        return categoryValues.count // 해당 섹션의 value 개수 반환
    }

    //원래 주석 처리 되어있었는데 풀어 주었음.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //스토리보드의 cell에 identifier에 이름을 부여하고 해당 이름을 호출하여 연결해주었다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)

        /* 1단계
        let roomNames = Array(MeetingRooms.keys) // key값들 (=방 이름)만 따로 가져옴
        let roomName = roomNames[indexPath.row] // indexPath.row => 각 row의 인덱스인듯하다.
        // MyCell의 Style이 Left or Right Detail인 경우에 textLabel, detailTextLabel이 자동 생성된다. 이 둘은 언래핑 반드시 필요.
        cell.textLabel?.text = roomName // 각각의 줄에 해당하는 방이름 표시
        if let capacity:Int = MeetingRooms[roomName]{ // 딕셔너리에서 key의 값으로 value를 찾을 경우, 값이 없을 때 nil 반환 = 즉, 옵셔널 이므로 언래핑 해주어야 함.
            cell.detailTextLabel?.text = "\(capacity)" // 각각의 줄에 해당하는 수용 개수 표시
        }
        */
        
        //2단계
        let categoryValues = Array(MeetingRooms.values)[indexPath.section] //각 섹션의 방 정보들 배열 형식으로 가져옴
        let roomName = Array(categoryValues.keys)[indexPath.row] // 방 이름 = 방 정보의 key값
        let capacity = Array(categoryValues.values)[indexPath.row] // 방 수용 개수 = 방 정보의 value값
        
        cell.textLabel?.text = roomName
        cell.detailTextLabel?.text = "\(capacity)"

        return cell
    }
    
    //3단계 : header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String? {
        return Array(MeetingRooms.keys)[section] // 딕셔너리에 선언해둔 섹션 이름 가져와 선언
    }
    
    //3단계 : footer
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let rowCount = Array(MeetingRooms.values)[section].count
        return "\(rowCount) rooms"
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
