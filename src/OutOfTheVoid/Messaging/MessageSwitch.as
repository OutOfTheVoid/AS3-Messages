package OutOfTheVoid.Messaging
{
	
	// A utility class for message routing.
	public class MessageSwitch
	{
		
		// ID-mapped Function record.
		private var HashMap:Object;
		
		public function MessageSwitch ()
		{
			
			HashMap = new Object ();
			
		};
		
		// Set a switch. ( Similar to addeventlistener )
		// * Message: The ID of the message.
		// * Handler: The function that handles the message. ( Must accept one argument being the message )
		// * BaseClass: The class to compare messages to before allowing passage. ( Leave null to skip the check. )
		public function SetSwitch ( Message:String, Handler:Function, BaseClass:Class = null ) : void
		{
			
			var Slot:Switch = HashMap [ Message ] as Switch;
			
			if ( Slot == null )
			{
				
				Slot = new Switch ( Handler, BaseClass );
				HashMap [ Message ] = Slot;
				
			}
			else
				Slot.Reset ( Handler, BaseClass );
			
		};
		
		// Kill a switch. ( similar to removeEventListener )
		// * Message: The ID of the previously set message for this switch.
		// * Deallocate: Whether or not to remove the internal handler structure for GC-ing.
		public function KillSwitch ( Message:String, Deallocate:Boolean = false ) : void
		{
			
			var Slot:Switch = HashMap [ Message ] as Switch;
			
			if ( Slot != null )
			{
				
				Slot.Reset ( null, null );
				
				if ( Deallocate )
				{
					
					HashMap [ Message ] = null;
					Slot = null;
					
				}
				
			}
			
		};
		
		// Send a message to it's appropriate switch.
		// * Message: The message to send.
		public function SendMessage ( Message:IMessage ) : Boolean
		{
			
			var Slot:Switch = HashMap [ Message.GetID () ] as Switch;
			
			if ( Slot != null )
				return Slot.CallIfValid ( Message );
			
			return false;
			
		};
		
	};
	
}

import Relapse.Messaging.IMessage;

class Switch
{
	
	private var ReqBaseType:Class;
	private var Handler:Function;
	
	public function Switch ( Handler:Function, BaseClass:Class = null )
	{
		
		this.Handler = Handler;
		this.ReqBaseType = BaseClass;
		
	};
	
	public function CallIfValid ( M:IMessage ) : Boolean
	{
		
		if ( Handler == null )
			return false;
		
		if ( ReqBaseType == null || M is ReqBaseType )
		{
			
			Handler ( M );
			
			return true;
			
		}
		
		return false;
		
	};
	
	public function Reset ( Handler:Function, BaseClass:Class = null ) : void
	{
		
		this.Handler = Handler;
		this.ReqBaseType = BaseClass;
		
	};
	
};