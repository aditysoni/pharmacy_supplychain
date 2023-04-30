pragma solidity ^0.8.0;

contract PharmaSupplyChain {
    
    // Define a struct to represent a drug item
    struct Drug 
    {
        uint id;
        string name;
        uint quantity;
        address manufacturer;
        
        bool isSold;
        uint256 maxtemprature ; 
        uint256 expiryDate;
        address owner ; 

        
    }
    mapping (uint256 => address) drug_manufacturer ;
    mapping (uint256 => uint256) public lowest_temp ; 
    mapping (uint256 => address) drug_owner ; 
    mapping (uint256 => bool ) public drug_temp_verify ;
    mapping (uint256 => bytes32) secret_code ; 
    
    // Define an array to store all the drug items
    Drug[]  drugs;
    
    // Define a mapping to keep track of each drug item's owner
    mapping(uint => address) public drugToOwner;
    
    // Define an event to emit when a drug item is added to the supply chain
    event DrugAdded(uint id, string name, uint quantity, address manufacturer);
    
    // Define an event to emit when a drug item is transferred to a new owner
    event DrugTransferred(uint id, address from, address to);
    
    // Define a function to add a new drug item to the supply chain
    function addDrug(uint id, string memory name, uint quantity , uint256 manufacturer ,uint256 maxtemprature,  uint256 expirarydate) public 
    {
        // Check if the drug item with the given id already exists
        require(drugToOwner[id] == address(0), "Drug item already exists.");
        lowest_temp[id] = maxtemprature ;
        // Add the new drug item to the array and map it to the sender's address
        drugs.push(Drug(id, name, quantity, msg.sender, false , maxtemprature , expirarydate ,address(0)));
        drug_manufacturer[id] = msg.sender ;
        // Emit the DrugAdded event
        emit DrugAdded(id, name, quantity, msg.sender);
    }
    
   
    // Define a function to transfer a drug item to a new owner
    function transferDrug(uint id, address to) public {
        // Check if the sender owns the drug item with the given id
        require( msg.sender == drug_owner[id] || msg.sender == drug_manufacturer[id] , " you are not elgiable to transfer" ) ;
         
        // Get the drug item from the array and update its owner and distributor
       drug_owner[id] = to ; 
             
        // Emit the DrugTransferred event
        emit DrugTransferred(id, msg.sender, to);
    }

    function getTemprature (uint256 _id , uint256 _temp) public 
        {
            if ( _temp >  lowest_temp[_id]) 
            {
                drug_temp_verify[_id] = false ;
               
            }
           
            
        }  
    
    function getexcryptedId (uint256 id ) external  
    {
     require( msg.sender == drug_manufacturer[id], " you are not elgiable to transfer" ) ;
   
     
     bytes32 result = sha256(abi.encodePacked(id)); 
     secret_code[id] = result ;
        
         }
   
   //function to know the secret code , only owner and manufacturer can call the function 
  
  function know_secret_code (uint256 id)  public returns(bytes32)
    {
      require( msg.sender == drug_owner[id] || msg.sender == drug_manufacturer[id] , " you are not elgiable to transfer" ) ;
      return secret_code[id] ;

    }
   
}
 
    
    


  
   

        
