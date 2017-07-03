//
//  ViewController.swift
//  CLLocation
//
//  Created by 葛建军 on 17/6/16.
//  Copyright © 2017年 HANGZHOUTEAM. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    let locationManage=CLLocationManager()
    let geocoder=CLGeocoder()
    var mapView:MKMapView!
    @IBOutlet var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.yellow
        /*
        if !CLLocationManager.locationServicesEnabled(){
            NSLog("定位服务当前可能尚未打开，请设置打开！")
        }
        //如果没有授权则请求用户授权
        if CLLocationManager.authorizationStatus()==CLAuthorizationStatus.notDetermined {
            locationManage.requestWhenInUseAuthorization()
        }else if CLLocationManager.authorizationStatus()==CLAuthorizationStatus.authorizedWhenInUse {
            //设置代理
            locationManage.delegate=self
            //设置定位精度
            locationManage.desiredAccuracy=kCLLocationAccuracyBest
            //定位频率，每隔多少米定位一次
            locationManage.distanceFilter=(10.0 as CLLocationDistance)//十米定位一次
            //启动跟踪定位
            locationManage.startUpdatingLocation()
        }
//        getCoordinateByAddress(address: "杭州")
        
        mapView=MKMapView(frame: UIScreen.main.bounds)
        self.view.addSubview(mapView)
        mapView.delegate=self
        //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
        mapView.userTrackingMode=MKUserTrackingMode.follow
        //设置地图类型
        mapView.mapType=MKMapType.standard
        
        //添加大头针
        addAnnotation()
        */
    }
    @IBAction func 旋转(_ sender: UIButton) {
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.5, options: .transitionCrossDissolve, animations: {
            let oldState=UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            let first=FirstViewController()
            let naVC=UINavigationController(rootViewController: first)
            UIApplication.shared.keyWindow?.rootViewController=naVC
            UIView.setAnimationsEnabled(oldState)
        }) { (finished) in
            
        }
    }
    
    // MARK: CoreLocation 代理 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location=locations.first //取出第一个位置
        let coordinate=location?.coordinate //位置坐标
        let coustom=locationLabel.text!+"******经度：\(coordinate!.longitude),纬度：\(coordinate!.latitude),海拔：\(location!.altitude),航向：\(location!.course),行走速度：\(location!.speed)"
        locationLabel.text=coustom
//        NSLog(coustom)
        getAddressByLatitude(latitude: coordinate!.latitude, longitude: coordinate!.longitude)
        //如果不需要实时定位，使用完即使关闭定位服务
        //locationManage.stopUpdatingLocation()
    }
    // MARK: 根据地名确定地理坐标
    func getCoordinateByAddress(address:String){
        geocoder.geocodeAddressString(address, in: nil) { (placemarks, error) in
            //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
            let placemark=placemarks?.first
            let location=placemark!.location//位置
            let region=placemark!.region//区域
            //详细地址信息字典,包含以下部分信息
            let addressDic=placemark?.addressDictionary
            //        NSString *name=placemark.name;//地名
            //        NSString *thoroughfare=placemark.thoroughfare;//街道
            //        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
            //        NSString *locality=placemark.locality; // 城市
            //        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
            //        NSString *administrativeArea=placemark.administrativeArea; // 州
            //        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
            //        NSString *postalCode=placemark.postalCode; //邮编
            //        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
            //        NSString *country=placemark.country; //国家
            //        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
            //        NSString *ocean=placemark.ocean; // 海洋
            //        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
            NSLog("位置：\(location)，区域：\(region)，详细信息：\(addressDic)，邮编：\(placemark?.postalCode)")
        }
    }
    // MARK: 根据坐标取得地名
    func getAddressByLatitude(latitude:CLLocationDegrees,longitude:CLLocationDegrees) {
        let location=CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            NSLog("详细信息：\(placemarks?.first?.addressDictionary)")
        }
    }
    // MARK: 添加大头针 
    func addAnnotation(){
//        CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(39.95, 116.35);
//        KCAnnotation *annotation1=[[KCAnnotation alloc]init];
//        annotation1.title=@"CMJ Studio";
//        annotation1.subtitle=@"Kenshin Cui's Studios";
//        annotation1.coordinate=location1;
//        [_mapView addAnnotation:annotation1];
//        
//        CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(39.87, 116.35);
//        KCAnnotation *annotation2=[[KCAnnotation alloc]init];
//        annotation2.title=@"Kenshin&Kaoru";
//        annotation2.subtitle=@"Kenshin Cui's Home";
//        annotation2.coordinate=location2;
//        [_mapView addAnnotation:annotation2];
    }
    
    
    // MARK: 地图控件代理方法 更新用户位置，只要用户改变则调用此方法（包括第一次定位到用户位置）
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        NSLog("++++\(userLocation)")
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

