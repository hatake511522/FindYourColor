//
//  ViewController.swift
//  FindYouColor
//
//  Created by 畑洋樹 on 2020/01/29.
//  Copyright © 2020 畑洋樹. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //日付を与えると6桁の16進数の文字列を返す処理
    func dateToColorcode(date: Date) -> String{
        let calendar = Calendar.current
        let day    = Int(calendar.component(.day, from: date))
        let hour   = Int(calendar.component(.hour, from: date))
        let minute = Int(calendar.component(.minute, from: date)) //のちに扱いやすいよう整数型にしておく
        
        let out_1 = day * hour % 256
        let out_2 = hour * minute % 256
        let out_3 = day * minute % 256 //比較的大きい数になりやすいので2桁の16進数の最大値である255+1(255はOKなので)で剰余を求める
        
        var red = 0 //定数ではなく変数を使用すること
        var green = 0
        var blue = 0
        
        if (out_1 > 255) { red = 255 }   else { red = out_1 }
        if (out_2 > 255) { green = 255 } else { green = out_2 }
        if (out_3 > 255) { blue = 255 }  else { blue = out_3 }
        
        let output = String(red, radix:16) + String(green, radix:16) + String(blue, radix: 16) //整数を16進数の文字列へと変換
        return output
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return UICollectionViewCell()
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func button(_ sender: Any) {
        (sender as AnyObject).setTitle("更新", for: .normal) //なぜか起動時はbuttonのまま、、、ボタンが押されないとこの処理は走らない？
        (sender as AnyObject).setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func ButtonTouchDown(_ sender: Any) {
        self.loadData()
    }
    func loadData(){
        let now = Date()
        let nowColor = dateToColorcode(date: now)
        collectionView.backgroundColor = UIColor(hex: nowColor)
        let label = UILabel()
        let screenWidth  = self.view.bounds.width
        let screenHeight = self.view.bounds.width // screen size の取得
        
        label.frame = CGRect(x: 50, y: 50, width: screenWidth*0.8, height: screenHeight*0.2)
        label.center = self.view.center
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name:"Courier-Bold", size: 10.5)
        label.backgroundColor = .white //storyboardによるUIの変更がなれないのでコードでUIをいじります
        label.textColor = UIColor.black
        label.text = "Today's your color is...  #\(nowColor)"
        self.view.addSubview(label)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        self.loadData()
    }



}

