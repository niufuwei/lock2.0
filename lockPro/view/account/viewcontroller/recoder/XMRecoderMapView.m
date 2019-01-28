//
//  XMRecoderMapView.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMRecoderMapView.h"

//#import "CommonUtility.h"
#import "XMMapBottomView.h"
#import "XMOprts.h"
#import "YQLocationTransform.h"
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@interface XMRecoderMapView ()<BMKMapViewDelegate,BMKMapViewDelegate>

@property (nonatomic, strong) NSMutableArray * anniotations;
@property (nonatomic, strong) BMKMapManager* mapManager;
@property (nonatomic,strong) BMKMapView * mapView;

@end

@implementation XMRecoderMapView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.container.cUid;
    XMOprts * oprts = self.dataArray[0];

    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:baiduMapKey  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    self.mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(oprts.oprtLat, oprts.oprtLng) animated:YES];
    self.mapView.delegate = self;
    
    
    
    //    [self.mapView setCenterCoordinate: [self getGaoDeCoordinateByBaiDuCoordinate:CLLocationCoordinate2DMake(30.340747, 120.105069)] animated:YES];
    [self.view addSubview:self.mapView];
    

    
    
    XMMapBottomView *bottom = [[[NSBundle mainBundle] loadNibNamed:@"XMMapBottomView" owner:self options:nil]lastObject];
    bottom.frame = CGRectMake(10, kScreen_Height-118, kScreen_Width-20, 108);
    [self.view addSubview:bottom];
    
  

    // Do any additional setup after loading the view.
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [UIColor redColor];
        polylineView.lineWidth = 2.0;
        
        return polylineView;
    }
    return nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];

//    CLLocationCoordinate2D coords[8] = {0};
   
//    for(int i=0;i<self.dataArray.count;i++){
//        XMOprts * oprts = self.dataArray[i];
//        coords[i].latitude = oprts.oprtLat;
//        coords[i].longitude = oprts.oprtLng;

//    }
//    BMKArcline *arcline = [BMKArcline arclineWithCoordinates:coords];
//    [_mapView addOverlay:arcline];
    
    // 添加折线覆盖物
    CLLocationCoordinate2D coor[8] = {0};
    
    
//    coor[0].latitude = 30.239939;
//    coor[0].longitude = 120.16219;
//
//    coor[1].latitude = 30.214132;
//    coor[1].longitude = 120.215214;
//
//    coor[2].latitude = 120.263016;
//    coor[2].longitude = 120.16219;
//
//    coor[3].latitude = 30.274525;
//    coor[3].longitude = 120.074007;
//
//        coor[4].latitude = 30.252617;
//        coor[4].longitude = 120.216357;
//
//        coor[5].latitude = 29.545192;
//        coor[5].longitude = 119.504783;
//
//        coor[6].latitude = 30.267514;
//        coor[6].longitude = 119.853062;
//
//        coor[7].latitude = 29.972351;
//        coor[7].longitude = 120.259212;
//
//
 
    for(int i=0;i<self.dataArray.count;i++){
        XMOprts * oprts = self.dataArray[i];
        coor[i].latitude = oprts.oprtLat;
        coor[i].longitude = oprts.oprtLng;;
    }
    
    BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:coor count:8];
    [_mapView addOverlay:polyline];
    
    for(int i=0;i<self.dataArray.count;i++){
        XMOprts * oprts = self.dataArray[i];
   
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate = CLLocationCoordinate2DMake(oprts.oprtLat, oprts.oprtLng);
        annotation.title = @"这里是北京";
        [_mapView addAnnotation:annotation];
    }
    
    
    
    //构造折线数据对象
//    CLLocationCoordinate2D commonPolylineCoords[self.dataArray.count];
//
//    for(int i=0;i<self.dataArray.count;i++){
//        XMOprts * oprts = self.dataArray[i];
//        YQLocationTransform *beforeLocation = [[YQLocationTransform alloc] initWithLatitude:[oprts.oprtLat doubleValue] andLongitude:[oprts.oprtLng doubleValue]];
//
//        YQLocationTransform *afterLocation = [beforeLocation transformFromBDToGD];
//
//        commonPolylineCoords[i].latitude = afterLocation.latitude;
//        commonPolylineCoords[i].longitude = afterLocation.longitude;
//    }
//
////    //构造折线对象
//    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:self.dataArray.count];
//
//    //在地图上添加折线对象
//    [self.mapView addOverlay: commonPolyline];
//    self.line = commonPolyline;
//
//    self.anniotations = [[NSMutableArray alloc] init];
//
//    for(int i=0;i<self.dataArray.count;i++){
//        MAPointAnnotation *a = [[MAPointAnnotation alloc] init];
//        XMOprts * oprts = self.dataArray[i];
//        YQLocationTransform *beforeLocation = [[YQLocationTransform alloc] initWithLatitude:[oprts.oprtLat doubleValue] andLongitude:[oprts.oprtLng doubleValue]];
//
//        YQLocationTransform *afterLocation = [beforeLocation transformFromBDToGD];
//
//        a.coordinate =  CLLocationCoordinate2DMake(afterLocation.latitude, afterLocation.longitude);
//        a.title = @"拖动我哦";
//        a.subtitle = @"阜通东大街6号";
//        [self.anniotations addObject:a];
//        [self.mapView addAnnotation:a];
//    }
//
//    [_mapView setZoomLevel:11.5 animated:YES];
    
    //构造折线数据对象
//    CLLocationCoordinate2D commonPolylineCoords[4];
//
//
//    commonPolylineCoords[0].latitude = [self getGaoDeCoordinateByBaiDuCoordinate:CLLocationCoordinate2DMake(30.340747, 120.105069)].latitude;
//    commonPolylineCoords[0].longitude = [self getGaoDeCoordinateByBaiDuCoordinate:CLLocationCoordinate2DMake(30.340747, 120.105069)].longitude;
//
//
//
//
//    commonPolylineCoords[1].latitude = [self getGaoDeCoordinateByBaiDuCoordinate:CLLocationCoordinate2DMake(30.340747, 120.105068)].latitude;
//    commonPolylineCoords[1].longitude = [self getGaoDeCoordinateByBaiDuCoordinate:CLLocationCoordinate2DMake(30.340747, 120.105068)].longitude;
//
//
//    commonPolylineCoords[2].latitude = [self getGaoDeCoordinateByBaiDuCoordinate:CLLocationCoordinate2DMake(30.340747, 120.105069)].latitude;
//    commonPolylineCoords[2].longitude = [self getGaoDeCoordinateByBaiDuCoordinate:CLLocationCoordinate2DMake(30.340747, 120.105069)].longitude;
//
//
//    commonPolylineCoords[3].latitude = [self getGaoDeCoordinateByBaiDuCoordinate:CLLocationCoordinate2DMake(30.340747, 120.105069)].latitude;
//    commonPolylineCoords[3].longitude = [self getGaoDeCoordinateByBaiDuCoordinate:CLLocationCoordinate2DMake(30.340747, 120.105069)].longitude;
//
//    //构造折线对象
//    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
//
//    //在地图上添加折线对象
//    [self.mapView addOverlay: commonPolyline];
//    self.line = commonPolyline;
//    MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
//    a1.title = @"拖动我哦";
//    a1.coordinate =  CLLocationCoordinate2DMake(39.832136, 116.34095);
//    a1.subtitle = @"阜通东大街6号";
//
//    MAPointAnnotation *a2 = [[MAPointAnnotation alloc] init];
//    a2.title = @"拖动我哦";
//    a2.coordinate =  CLLocationCoordinate2DMake(39.832136, 116.42095);
//    a2.subtitle = @"阜通东大街6号";
//
//    MAPointAnnotation *a3 = [[MAPointAnnotation alloc] init];
//    a3.title = @"拖动我哦";
//    a3.coordinate =  CLLocationCoordinate2DMake(39.902136, 116.42095);
//    a3.subtitle = @"阜通东大街6号";
//
//    MAPointAnnotation *a4 = [[MAPointAnnotation alloc] init];
//    a4.title = @"拖动我哦";
//    a4.coordinate =  CLLocationCoordinate2DMake(39.902136, 116.44095);
//    a4.subtitle = @"阜通东大街6号";
//
//    self.anniotations = [[NSMutableArray alloc] init];
//    [self.anniotations addObject:a1];
//    [self.anniotations addObject:a2];
//    [self.anniotations addObject:a3];
//    [self.anniotations addObject:a4];
//
//
//    [self.mapView addAnnotation:a1];
//    [self.mapView addAnnotation:a2];
//    [self.mapView addAnnotation:a3];
//    [self.mapView addAnnotation:a4];
//
//    [_mapView setZoomLevel:11.5 animated:YES];
    
}

// 百度地图经纬度转换为高德地图经纬度
//- (CLLocationCoordinate2D)getGaoDeCoordinateByBaiDuCoordinate:(CLLocationCoordinate2D)coordinate
//{
//    return CLLocationCoordinate2DMake(coordinate.latitude - 0.006, coordinate.longitude - 0.0065);
//}

#pragma mark - MAMapViewDelegate
//- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//
//        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
//        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
//                                                          reuseIdentifier:reuseIndetifier];
//        }
//        annotationView.image = [UIImage imageNamed:@"restaurant"];
//
//        NSArray * array = [NSArray arrayWithArray:self.anniotations];
//
//        for(int i =0 ;i<array.count;i++){
//            if(i==array.count-1&&(annotation.coordinate.latitude == ((MAPointAnnotation *)array[i]).coordinate.latitude && annotation.coordinate.longitude == ((MAPointAnnotation *)array[i]).coordinate.longitude)){
//                annotationView.image = [UIImage imageNamed:@"xsCar"];
//            }
//        }
//        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
//        annotationView.centerOffset = CGPointMake(0, 0);
//        return annotationView;
//    }
//
//    return nil;
//}

//- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
//{
//
//    NSArray * array = [NSArray arrayWithArray:self.anniotations];
//
//    for(int i =0 ;i<array.count;i++){
//        if(view.annotation.coordinate.latitude == ((MAPointAnnotation *)array[i]).coordinate.latitude && view.annotation.coordinate.longitude == ((MAPointAnnotation *)array[i]).coordinate.longitude){
//            NSLog(@">>>>%ld",i);
//        }
//    }
//
//}


//- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
//{
//    if ([overlay isKindOfClass:[MAPolyline class]])
//    {
//        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
//        polylineRenderer.strokeColor = COLOR(73, 199, 80);
//        polylineRenderer.lineWidth   = 10.f;
//        polylineRenderer.lineDashPhase = 0;
//
//        return polylineRenderer;
//    }
//
//    return nil;
//}
//
//- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState {
//    if(newState == MAAnnotationViewDragStateEnding) {
//        CLLocationCoordinate2D loc = view.annotation.coordinate;
//        MAMapPoint p = MAMapPointForCoordinate(loc);
//        double distance = [CommonUtility distanceToPoint:p fromLineSegmentBetween:self.line.points[0] and:self.line.points[1]];
//
//        [self.view makeToast:[NSString stringWithFormat:@"%f", distance] duration:1.0];
//    }
//}


@end
