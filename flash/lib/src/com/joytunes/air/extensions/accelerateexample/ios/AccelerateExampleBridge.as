package com.joytunes.air.extensions.accelerateexample.ios
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExtensionContext;
	
	/**
	 * A project that demonstrates the use of Accelerate.framework for iOS through a native extension.
     *
	 * @author Yoni Tsafir
	 */
	public class AccelerateExampleBridge extends EventDispatcher
	{
		protected var _extensionContext:ExtensionContext;
		
		/**
		 * Constructor.
		 */
		public function AccelerateExampleBridge()
		{
			super();
			// Initialize extension.
			_extensionContext = ExtensionContext.createExtensionContext("com.joytunes.accelerateexample", "main");
		}
		
		/**
		 * @return The sum of the vector, using the iOS accelerate framework
		 */
		public function calcVectorSum(vector:Vector.<Number>):Number
		{
			return _extensionContext.call("CalculateVectorSum", vector) as Number;
		}
	}
}
