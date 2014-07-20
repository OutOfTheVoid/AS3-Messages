package OutOfTheVoid.Messaging
{
	
	// Base message class.
	public class Message implements IMessage
	{
		
		// Basic update message. ( Could replace the usage of ENTER_FRAME or otherwise )
		public static const MESSAGE_UPDATE:String = "update";
		
		// Message ID;
		protected var ID:String;
		
		public function Message ( ID:String )
		{
			
			this.ID = ID;
			
		};
		
		// Get the ID of the message.
		public function GetID () : String
		{
			
			return ID;
			
		};
		
		// Re-use message.
		public function Reset ( ID:String ) : void
		{
			
			this.ID = ID;
			
		};
		
	};
	
};