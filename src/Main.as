package
{
	import AngleBounce.AngleBounce;
	import astar.AStarTest;
	import astar.Xunlu;
	import comps.Ball;
	import comps.Ship;
	import easing.CursorFllow3;
	import easing.EasingTest;
	import easing.SpringEasing;
	import easing.StuffEasing;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import hit.BitmapHitTest;
	import hit.BubblesTwo;
	import hit.ColorOverlayHitTest;
	import hit.DistHitTet;
	import hit.gridcollision.GridCollision3;
	import hit.HitTestPoint;
	import hit.ObjectHitTest;
	import hit.quadtree.hitTest.QuadTreeHitTest;
	import hit.quadtree.QuadTree_collition;
	import rotation.Rotatel;
	import rotation.Rotatel2;
	import rotation.Rotatel3;
	import startDrag.CursorAdmin;
	import startDrag.MoveDrag;
	import triangle.Accelerated;
	import triangle.BounceBall;
	import triangle.BoundaryBall;
	import triangle.BoundaryShip;
	import triangle.CursorFllow;
	import triangle.Dist;
	import startDrag.DragInRectangle;
	import triangle.SinMove;
	import triangle.Speed;
	import triangle.TriangleTest;
	import triangle.CursorFllow2;
	
	/**
	 * make thing move 案例
	 * @author far
	 */
	public class Main extends Sprite
	{
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			test();
		}
		
		private function test():void
		{
			//三角函数
			//var tt:TriangleTest = new TriangleTest();
			//centerMc(tt);
			//三角函数运动
			//var sinMove:SinMove = new SinMove();
			//centerMc(sinMove);
			//距离计算
			//var dist:Dist = new Dist(stage);
			//centerMc(dist);
			//速度运动
			//var speed:Speed = new Speed();
			//centerMc(speed);
			//矩形内拖放
			//var dr:DragInRectangle = new DragInRectangle(stage);
			//centerMc(dr);
			//鼠标跟随
			//var cursor:CursorFllow = new CursorFllow();
			//centerMc(cursor);
			//加速度
			//var acce:Accelerated = new Accelerated(stage);
			//centerMc(acce);
			//加速度跟随
			//var cursor2:CursorFllow2 = new CursorFllow2();
			//centerMc(cursor2);
			//限定边界带摩擦运行
			//var boundball:BoundaryBall = new BoundaryBall(stage);
			//addChild(boundball);
			//飞船
			//var ship:BoundaryShip = new BoundaryShip(stage);
			//addChild(ship);
			//反弹运动
			//var bounceBall:BounceBall = new BounceBall(stage);
			//addChild(bounceBall);
			//自定义鼠标
			//var cusoradmin:CursorAdmin = new CursorAdmin().init(stage);
			//cusoradmin.setCursor(new Ball());
			//addChild(cusoradmin);
			//拖动
			//var moveDrag:MoveDrag  = new MoveDrag(stage); 
			//addChild(moveDrag);
			
			//缓动
			//var easing:EasingTest = new EasingTest();
			//addChild(easing);
			//弹性运动
			//var easing:SpringEasing = new SpringEasing();
			//addChild(easing);
			//鼠标跟随弹性运动
			//var easing:CursorFllow3 = new CursorFllow3();
			//addChild(easing);
			//多物体跟随弹性运动
			//var easing:StuffEasing = new StuffEasing();
			//addChild(easing);
			
			//碰撞检测的方法
			//碰撞检测
			//var objecthit:ObjectHitTest = new ObjectHitTest();
			//centerMc(objecthit);
			//点碰撞
			//var hitPoint:HitTestPoint = new HitTestPoint();
			//addChild(hitPoint);
			//距离碰撞
			//var disHit:DistHitTet = new DistHitTet();
			//addChild(disHit);
			//bitmaphittest碰撞
			//var bitHist:BitmapHitTest = new BitmapHitTest();
			//addChild(bitHist);
			//颜色叠加碰撞
			//var bitHist:ColorOverlayHitTest = new ColorOverlayHitTest();
			//addChild(bitHist);
			//多物体碰撞,普通方法
			//var mulitHit:BubblesTwo = new BubblesTwo();
			//addChild(mulitHit);
			
			
		  //http://blog.163.com/dreaming_everyday/blog/static/16996760520126246612369/
			//减少碰撞次数的技巧
			//网格碰撞
			//var grid:GridCollision3 = new GridCollision3();
			//addChild(grid);
		
			//四叉树检测碰撞   n神版本
			//var quad:QuadTree_collition = new QuadTree_collition();
			//addChild(quad);
			
			//四叉树增强,及网格碰撞
			//var quad1:QuadTreeHitTest = new QuadTreeHitTest();
			//quad1.test(5);
			//addChild(quad1);
		
			//旋转
			//var ro:Rotatel = new Rotatel();
			//addChild(ro);
			//旋转优化公式
			//var ro2:Rotatel2 = new Rotatel2();
			//addChild(ro2);
			//多物体旋转
			//var ro3:Rotatel3 = new Rotatel3();
			//addChild(ro3);
		
			//斜面反弹
			//var angbo:AngleBounce = new AngleBounce();
			//addChild(angbo);
		
			//第11章 台球物理
			//Advanced.ActionScript 3.Animation
			
			//a*寻路初探
			var astarTest:AStarTest = new AStarTest();
		    addChild(astarTest);
			//广度搜索
			//var xunTest:Xunlu = new Xunlu();
		    //addChild(xunTest);
		}
		
		public function centerMc(mc:DisplayObject):void
		{
			mc.x = (stage.stageWidth - mc.width) / 2;
			mc.y = (stage.stageHeight - mc.height) / 2;
			addChild(mc);
		}
	
	}

}