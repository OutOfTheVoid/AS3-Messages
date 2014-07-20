package OutOfTheVoid.Messaging
{
	
	// An object which will massage any IMessageable added to it.
	public interface IMessager
	{
		
		// Add a receiver IMessagable.
		function AddReceiver ( Receiver:IMessageable ) : void;
		
		// Remove a receiver IMessagable.
		function RemoveReceiver ( Receiver:IMessageable ) : void;
		
	};
	
};