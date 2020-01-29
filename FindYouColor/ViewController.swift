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
    
    func dateToColorcode(date: Date) -> String{
        let calendar = Calendar.current
        let day    = Int(calendar.component(.day, from: date))
        let hour   = Int(calendar.component(.hour, from: date))
        let minute = Int(calendar.component(.minute, from: date)) //のちに扱いやすいよう整数型にしておく
        let out_1 = day * hour
        let out_2 = hour * minute
        let out_3 = day * minute
        
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
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
//        let now = Date()
//        let nowColor = dateToColorcode(date: now)
//        print(nowColor)
//        cell.backgroundColor = UIColor(hex: nowColor)
//        return cell
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width / 2
        let height = collectionView.bounds.size.height / 4
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let now = Date()
        let nowColor = dateToColorcode(date: now)
        collectionView.backgroundColor = UIColor(hex: nowColor)
    }


}

