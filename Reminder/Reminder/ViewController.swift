//
//  ViewController.swift
//  Reminder
//
//  Created by 山中力仁 on 2017/09/29.
//  Copyright © 2017年 yamayoshi. All rights reserved.
//

import UIKit

private let unSelectedRow = -1

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var memoList: UITableView!
    @IBOutlet weak var memoField: UITextField!
    
    var inMemoList: [String] = []   //メモ内容を保持
    var editRow = unSelectedRow     //編集中の行番号を保持
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //TableViewのセルを識別するIDの登録処理
        memoList.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func evBtn(_ sender: UIButton) {
        applyMemo()
    }
    
    //TableViewが表示する行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return inMemoList.count
    }
    //メモ一覧が表示する内容を返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        if indexPath.row >= inMemoList.count {
            return cell
        }
        cell.textLabel?.text = String(indexPath.row + 1) + ": " + inMemoList[indexPath.row]    //行番号に対応したメモを表示させる
        return cell
    }
    
    //メモ一覧のセルが選択されたイベント
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.row >= inMemoList.count {
            return
        }
        editRow = indexPath.row                 //選択された行番号を保持
        memoField.text = inMemoList[editRow]    //選択したセルの文字をテキストフィールドに反映
    }
    
    //テキストフィールドで改行がクリックされたイベント
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        applyMemo()
        return false    //改行を反映しない
    }
    
    func applyMemo(){
        //入力チェック
        if memoField.text == ""{
            view.endEditing(true)
            return
        }else if memoField.text == " "{
            view.endEditing(true)
            return
        }else if memoField.text == "　"{
            view.endEditing(true)
            return
        }
        
        if editRow == unSelectedRow {
            inMemoList.append(memoField.text!) //テキストをメモリストに追加
        }else{
            inMemoList[editRow] = memoField.text!
        }
        memoField.text = ""     //入力欄を初期化
        editRow = unSelectedRow //初期位置に戻す
        memoList.reloadData()   //TableViewの更新
        view.endEditing(true)   //キーボードを下げる
    }

    

}

