package OutOfTheVoid.Messaging
{
	
	// An object which can receive messages
	public interface IMessageable
	{
		
		// A list of all message ID's that this object accepts.
		function GetAcceptedMessageIDS () : Vector.<String>;
		
		// Send this object a message. Returns true if it was accepted.
		function SendMessage ( M:IMessage ) : Boolean;
		
	};
	
};