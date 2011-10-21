package com.zehfernando.geom {
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author Zeh Fernando - z at zeh.com.br
	 */
	public class Line {

		// Properties
		public var p1:Point;
		public var p2:Point;

		// ================================================================================================================
		// CONSTRUCTOR ----------------------------------------------------------------------------------------------------

		public function Line(__p1:Point, __p2:Point) {
			p1 = __p1;
			p2 = __p2;
		}

		// ================================================================================================================
		// INSTANCE functions ---------------------------------------------------------------------------------------------

		public function intersectsRect(__rect:Rectangle): Boolean {
			// Check if a rectangle intersects OR contains this line

			if (__rect.containsPoint(p1) || __rect.containsPoint(p2)) return true;

			if (intersectsLine(new Line(new Point(__rect.left, __rect.top),		new Point(__rect.right, __rect.top)))) return true;
			if (intersectsLine(new Line(new Point(__rect.left, __rect.top),		new Point(__rect.left, __rect.bottom)))) return true;
			if (intersectsLine(new Line(new Point(__rect.left, __rect.bottom),	new Point(__rect.right, __rect.bottom)))) return true;
			if (intersectsLine(new Line(new Point(__rect.right, __rect.top),	new Point(__rect.right, __rect.bottom)))) return true;

			return false;
		}

		public function intersectsLine(__line:Line): Boolean {
			// Check whether two lines intersects each other
			return Boolean(intersection(__line));
		}

		public function intersection(__line:Line): Point {
			// Returns a point containing the intersection between two lines
			// http://keith-hair.net/blog/2008/08/04/find-intersection-point-of-two-lines-in-as3/
			// http://www.gamedev.pastebin.com/f49a054c1

			var a1:Number = p2.y - p1.y;
			var b1:Number = p1.x - p2.x;
			var a2:Number = __line.p2.y - __line.p1.y;
			var b2:Number = __line.p1.x - __line.p2.x;
		
			var denom:Number = a1 * b2 - a2 * b1;
			if (denom == 0) return null;

			var c1:Number = p2.x * p1.y - p1.x * p2.y;
			var c2:Number = __line.p2.x * __line.p1.y - __line.p1.x * __line.p2.y;

			var p:Point = new Point((b1 * c2 - b2 * c1)/denom, (a2 * c1 - a1 * c2)/denom);
		
			//if(as_seg){
			if (Point.distance(p, p2) > Point.distance(p1, p2)) return null;
			if (Point.distance(p, p1) > Point.distance(p1, p2)) return null;
			if (Point.distance(p, __line.p2) > Point.distance(__line.p1, __line.p2)) return null;
			if (Point.distance(p, __line.p1) > Point.distance(__line.p1, __line.p2)) return null;
			//}

			return p;

		}

		// ================================================================================================================
		// ACCESSOR functions ---------------------------------------------------------------------------------------------

		public function get length(): Number {
			return Point.distance(p1, p2);
		}
	}
}
