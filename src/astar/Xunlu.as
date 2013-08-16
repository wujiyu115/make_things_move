package astar{
        import flash.display.*;
        import flash.events.*;
        import flash.geom.*;
        import flash.net.*;
        import flash.system.*;
        import flash.text.*;
        import flash.utils.*;
        
        public class Xunlu extends Sprite{
                
                /**
                 * 列数 
                 */                
                private static const w:int=100+2;
                
                /**
                 * 行数 
                 */                
                private static const h:int=100+2;
                
                /**
                 * 区块边长 
                 */
                private static const d:int=8;
                
                /**
                 * 障碍物个数
                 */                
                private static const ranNum:int=1000;
                
                private var statusTxt:TextField;
                
                private var drawBmp:Bitmap;
                private var drawBmd:BitmapData;
                private var map:Vector.<Vector.<int>>;
                private var ranV:Vector.<int>;
                
                /**
                 * 起点 
                 */                
                private var startTile:Tile;
                
                /**
                 * 终点 
                 */                
                private var endTile:Tile;
                
                private var currTile:Tile;
                
                /**
                 * 
                 * 制作一个100＊100的地图，方格宽高均为10像素。可通过方格为绿色，障碍物方格为黑色。首尾方格为红色。路径线使用蓝色。<br/>
                 * 要求：在100*100方格内，随机摆放1000个障碍物，可直接设置起始位置和终点位置，使用A＊寻路算法在最短时间内得到可连接收尾点的最短路径。<br/>
                 *
                 */        
                public function Xunlu(){
                        if (stage)
							init(null);
						else
							addEventListener(Event.ADDED_TO_STAGE, init);
                       
                }
				
				private function init(e:Event):void
				{
					removeEventListener(Event.ADDED_TO_STAGE, init);
					 stage.scaleMode=StageScaleMode.NO_SCALE;
                        stage.align=StageAlign.TOP_LEFT;
                        
                        initMenu();
                        initMap();
                        
                        var container:Sprite=new Sprite();
                        this.addChild(container);
                        container.x=5;
                        container.y=40;
                        
                        container.addChild(drawBmp=new Bitmap(drawBmd=new BitmapData(d*w,d*h,false,0xffffff)));
                        container.addChild(startTile=new Tile(d));
                        container.addChild(endTile=new Tile(d));
                        startTile.x=d;
                        startTile.y=d;
                        endTile.x=(w-2)*d;
                        endTile.y=(h-2)*d;
                        container.addEventListener(MouseEvent.MOUSE_DOWN,pressTile);
                        
                        genMap();
                        drawPath();
				}
                
                private function pressTile(event:MouseEvent):void{
                        currTile=event.target as Tile;
                        if(currTile){
                        }else{
                                var x:int=Math.round(endTile.parent.mouseX/d-0.5);
                                var y:int=Math.round(endTile.parent.mouseY/d-0.5);
                                if(map[y][x]){
                                        return;
                                }
                                currTile=endTile;
                        }
                        map[Math.round(currTile.y/d)][Math.round(currTile.x/d)]=0;
                        stage.addEventListener(MouseEvent.MOUSE_UP,releaseTile);
                        this.addEventListener(Event.ENTER_FRAME,moveTile);
                }
                private function moveTile(...args):void{
                        var x:int=Math.round(currTile.parent.mouseX/d-0.5);
                        var y:int=Math.round(currTile.parent.mouseY/d-0.5);
                        if(map[y][x]){
                        }else{
                                currTile.x=x*d;
                                currTile.y=y*d;
                        }
                }
                private function releaseTile(...args):void{
                        stage.removeEventListener(MouseEvent.MOUSE_UP,releaseTile);
                        this.removeEventListener(Event.ENTER_FRAME,moveTile);
                        map[Math.round(currTile.y/d)][Math.round(currTile.x/d)]=2;
                        currTile=null;
                        drawPath();
                }
                
                /**
                 * 初始化菜单
                 * 
                 */                
                private function initMenu():void{
                        var labelArea:Sprite=new Sprite();
                        this.addChild(labelArea);
                        labelArea.x=5;
                        labelArea.y=5;
                        var x:int=0;
                        for each(var label:String in ["重新生成地图","重新寻路","拖动小红块以设置起点或终点，或点击任意绿色区域设置终点"]){
                                var item:Sprite=new Sprite();
                                labelArea.addChild(item);
                                item.mouseChildren=false;
                                item.buttonMode=true;
                                var txt:TextField=new TextField();
                                item.addChild(txt);
                                item.x=x;
                                txt.autoSize=TextFieldAutoSize.LEFT;
                                txt.text=label;
                                x+=item.width+5;
                        }
                        item.buttonMode=false;
                        labelArea.addEventListener(MouseEvent.CLICK,clickLabel);
                        this.addChild(statusTxt=new TextField());
                        statusTxt.x=5;
                        statusTxt.y=20;
                        statusTxt.autoSize=TextFieldAutoSize.LEFT;
                        statusTxt.textColor=0xff0000;
                        statusTxt.text="status";
                }
                
                /**
                 * 
                 * 点击菜单项
                 * 
                 */                
                private function clickLabel(event:MouseEvent):void{
                        switch(((event.target as Sprite).getChildAt(0) as TextField).text){
                                case "重新生成地图":
                                        genMap();
                                        drawPath();
                                break;
                                case "重新寻路":
                                        drawPath();
                                break;
                        }
                }
                
                /**
                 * 初始化map和ranV
                 * 
                 */                
                private function initMap():void{
                        map=new Vector.<Vector.<int>>(h);
                        map.fixed=true;
                        ranV=new Vector.<int>(w*h);
                        var i:int=ranV.length;
                        while(--i>=0){
                                ranV[i]=i;
                        }
                        var y:int=h;
                        while(--y>=0){
                                map[y]=new Vector.<int>(w);
                                map[y].fixed=true;
                                var x:int=w;
                                while(--x>=0){
                                        if(x==0||x==w-1||y==0||y==h-1){
                                                ranV.splice(y*w+x,1);
                                                map[y][x]=1;
                                        }else{
                                                map[y][x]=0;
                                        }
                                }
                        }
                        ranV.fixed=true;
                }
                
                /**
                 * 随机构造地图 
                 * 
                 */                
                private function genMap():void{
                        
                        //清除所有障碍
                        var y:int=h;
                        while(--y>=0){
                                var x:int=w;
                                while(--x>=0){
                                        if(x==0||x==w-1||y==0||y==h-1){
                                        }else{
                                                map[y][x]=0;
                                        }
                                }
                        }
                        
                        //标记起点和终点
                        map[Math.round(startTile.y/d)][Math.round(startTile.x/d)]=2;
                        map[Math.round(endTile.y/d)][Math.round(endTile.x/d)]=2;
                        
                        //摆放ran个随机障碍
                        disorder(ranV);
                        var i:int=0;
                        for each(var ran:int in ranV){
                                x=ran%w;
                                y=int(ran/w);
                                if(map[y][x]==2){
                                }else{
                                        map[y][x]=1;
                                        if(++i>=ranNum){
                                                break;
                                        }
                                }
                        }
                        
                        //根据map绘制地图
                        var rect:Rectangle=new Rectangle(0,0,d,d);
                        y=-1;
                        for each(var subMap:Vector.<int> in map){
                                y++;
                                x=-1;
                                for each(var value:int in subMap){
                                        x++;
                                        rect.x=x*d;
                                        rect.y=y*d;
                                        switch(value){
                                                case 0:
                                                        drawBmd.fillRect(rect,0x00ff00);
                                                break;
                                                case 1:
                                                        drawBmd.fillRect(rect,0x000000);
                                                break;
                                                default:
                                                        drawBmd.fillRect(rect,0xffffff);
                                                break;
                                        }
                                }
                        }
                        
                }
                
                private static const dxyArr:Array=[[-1,0],[0,-1],[1,0],[0,1]];
                
                /**
                 * 寻路 
                 * 
                 */
                private function xunlu():Array{
                        
                        var chains:Array=new Array();//回溯用
                        
                        var lastXY0:int=-1;
                        var newSeed:Array=[[Math.round(startTile.x/d),Math.round(startTile.y/d)]];//起点
                        map[Math.round(startTile.y/d)][Math.round(startTile.x/d)]=-2;//标记
                        loop:while(newSeed.length){
                                var seed:Array=newSeed;
                                newSeed=new Array();
                                for each(var subSeed:Array in seed){
                                        var x0:int=subSeed[0];
                                        var y0:int=subSeed[1];
                                        for each(var dxy:Array in dxyArr){
                                                var x:int=x0+dxy[0];
                                                var y:int=y0+dxy[1];
                                                if(map[y][x]){
                                                        if(map[y][x]==2){//终点
                                                                lastXY0=y0*w+x0;
                                                                break loop;
                                                        }
                                                }else{
                                                        chains[y*w+x]=y0*w+x0;
                                                        newSeed.push([x,y]);
                                                        map[y][x]=-1;//标记
                                                }
                                        }
                                }
                        }
                        
                        //清除标记
                        y=h;
                        while(--y>=0){
                                x=w;
                                while(--x>=0){
                                        if(map[y][x]==-1){
                                                map[y][x]=0;
                                        }
                                }
                        }
                        map[Math.round(startTile.y/d)][Math.round(startTile.x/d)]=2;//清除标记
                        
                        if(lastXY0==-1){
                                return null;
                        }
                        
                        var lu:Array=[[Math.round(endTile.x/d),Math.round(endTile.y/d)]];
                        do{
                                lu.push([lastXY0%w,int(lastXY0/w)]);
                                lastXY0=chains[lastXY0];
                        }while(lastXY0);
                        return lu;
                }
                
                /**
                 * 绘制寻路结果 
                 * 
                 */                
                private function drawPath():void{
                        
                        //清除之前绘制的路径
                        var rect:Rectangle=new Rectangle(0,0,d,d);
                        var y:int=-1;
                        for each(var subMap:Vector.<int> in map){
                                y++;
                                var x:int=-1;
                                for each(var value:int in subMap){
                                        x++;
                                        if(map[y][x]){
                                        }else{
                                                rect.x=x*d;
                                                rect.y=y*d;
                                                drawBmd.fillRect(rect,0x00ff00);
                                        }
                                }
                        }
                        
                        //寻路
                        var t:int=getTimer();
                        var lu:Array=xunlu();
                        statusTxt.text="耗时 "+(getTimer()-t)+" 毫秒    ";
                        
                        if(lu){
                                statusTxt.appendText("路程为"+lu.length);
                                //绘制路径
                                //trace("lu="+lu);
                                for each(var subLu:Array in lu){
                                        rect.x=subLu[0]*d;
                                        rect.y=subLu[1]*d;
                                        drawBmd.fillRect(rect,0x0000ff);
                                }
                        }else{
                                statusTxt.appendText("无路可走");
                        }
                        statusTxt.appendText("    "+new Date().toString());
                }
                
        }
}
import flash.display.Sprite;

class Tile extends Sprite{
        /**
         * 区块 
         * 
         */        
        public function Tile(d:int){
                this.mouseChildren=false;
                this.buttonMode=true;
                this.graphics.clear();
                this.graphics.beginFill(0xff0000);
                this.graphics.drawRect(0,0,d,d);
                this.graphics.endFill();
        }
}

/**
 * 
 * 打乱数组或Vector
 * 
 */
function disorder(v:*):void{
        var L:int=v.length;
        var i:int=L;
        while(--i>=0){
                var ran:int=int(Math.random()*L);
                var temp:int=v[i];
                v[i]=v[ran];
                v[ran]=temp;
        }
}