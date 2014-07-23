package OutOfTheVoid.Messaging
{
	
	// A utility class to keep track of ( and message ) IMessageables.
	public class MessagingList implements IMessager
	{
		
		private var Filter:Vector.<String>;
		
		private var HashMap:Object;
		
		private var FreeSlots:Boolean;
		private var Filtering:Boolean;
		
		public function MessagingList ( FreeSlots:Boolean = false, Filtering:Boolean = false )
		{
			
			HashMap = new Object ();
			
			this.FreeSlots = FreeSlots;
			this.Filtering = Filtering;
			
			if ( Filtering )
				Filter = new Vector.<String> ();
			
		};
		
		public function Dispose () : void
		{
			
			for each ( var Slot:Vector.<IMessageable> in HashMap )
			{
				
				while ( Slot.length != 0 )
					Slot.pop ();
				
			}
			
		};
		
		public function AddFilter ( ID:String ) : void
		{
			
			if ( ! Filtering )
				return;
			
			Filter.push ( ID );
			
		};
		
		public function RemoveFilter ( ID:String ) : void
		{
			
			if ( ! Filtering )
				return;
			
			var Index:int = Filter.indexOf ( ID );
			
			if ( Index == -1 )
				return;
			
			Filter.splice ( Index, 1 );
			
		};
		
		public function AddReceiver ( Messageable:IMessageable ) : void
		{
			
			var IDS:Vector.<String>  = Messageable.GetAcceptedMessageIDS ();
			var IDLength:uint = IDS.length;
			
			for ( var i:uint = 0; i < IDLength; i ++ )
			{
				
				if ( Filtering && ( Filter.indexOf ( IDS [ i ] ) == -1 ) )
					continue;
				
				var Slot:Vector.<IMessageable> = HashMap [ IDS [ i ] ];
				
				if ( Slot == null )
				{
					
					Slot = new Vector.<IMessageable> ();
					HashMap [ IDS [ i ] ] = Slot;
					
				}
				
				Slot.push ( Messageable );
				
			}
			
		};
		
		public function RemoveReceiver ( Messageable:IMessageable ) : void
		{
			
			var IDS:Vector.<String>  = Messageable.GetAcceptedMessageIDS ();
			var IDLength:uint = IDS.length;
			
			for ( var i:uint = 0; i < IDLength; i ++ )
			{
				
				var Slot:Vector.<IMessageable> = HashMap [ IDS [ i ] ];
				
				if ( Slot == null )
				{
					
					if ( ! FreeSlots )
						return;
					
				}
				else
				{
					
					var Index:int = Slot.indexOf ( Messageable );
					
					if ( Index == -1 )
						if ( ! FreeSlots )
							continue;
					
					Slot.splice ( Index, 1 );
					
					if ( FreeSlots )
					{
						
						if ( Slot.length == 0 )
						{
							
							HashMap [ IDS [ i ] ] = null;
							Slot = null;
						
						}
						
					}
					
					
				}
				
			}
			
		};
		
		public function SendMessage ( Message:IMessage ) : void
		{
			
			var Slot:Vector.<IMessageable> = HashMap [ Message.GetID () ];
			
			if ( Slot == null )
				return;
			
			var SLength:uint = Slot.length;
			
			for ( var i:uint = 0; i < SLength; i ++ )
				Slot [ i ].SendMessage ( Message );
			
		};
		
	};
	
};
