# pharmacy_supplychain
Creating a pharmacy contract which is used to prevent the counterfeit drugs . 

Drug details are stored at the time of manufacturing , and we are also storing the highest and lowest temprature of drug in which it can sustain .
Each drug manufactured is added to the chain , and the inforamtion of middleman who are handling the drug in the process of transfer of drug from manufacturer to the customer are also stored on the chain . 

We can know which drug is created by which manufacturer and how many drug is being manufactured by each manufacturer . 

We compare the storing temparture of drug when it is in storage or when it is getting shifted . The drug temprature is getting sensed by a senor and then that information is transfered to the contract which compares it and if the the temprature of the drug goes outside of the prescribed range then we mark is as false . 
Customer can check whther this value while buying the drug . 

We are also creating a secret code by using sha256 , which is only know to the producer and the owner .
So the customer can comparwe the code and can verify whwther the the medicined is fake or not . 
