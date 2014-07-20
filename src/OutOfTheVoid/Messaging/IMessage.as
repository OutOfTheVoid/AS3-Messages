package OutOfTheVoid.Messaging
{
	
	// A message that can be passed to an object implementing IMessageable
	public interface IMessage
	{
		
		// Unique Message ID. ( Tested for acceptance / targeting. Keep short for faster comparison )
		function GetID () : String;
		
	};
	
};