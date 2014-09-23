Lab2_382
========

Function: Decoder/Encrypter

##Purpose
The purpose of this lab was to write a program that would decrypt an encrypted message by using a simple encryption technique. This was done by XORing the message with a provided key of arbitrary length.

##Software flow chart / algorithms



##Well-formatted code
The formatted code can be found attached in the Lab2.asm in the head of this repository.

Debugging: To debug this particular lab, I kept running the lab and checking the results in memory. I had a problem with having the Key run through the code and reseting every 1-3 times it went through for the B functionality. This was fixed by implementing a loop to ensure the Key and message were in sync. Another topic for debugging was making sure that the displayed memory address data was displayed in character mode.

##Testing methodology / results
To Test the code, I would run through the program and check the memory locations starting at 0x200 to see if the message was decrypted or not. If there was no discernable message, I debugged my program and tried again until I got a legible result
 
##Observations and Conclusions
For the required functionality, the message below was displayed indicating that required functionality was obtained. 

![alt text](http://i59.tinypic.com/15riq1h.png)

For B functionality, the message below gave a hint to how to solve the A functionlity, which indicates that required B functionality was obtained.

![alt text](http://i62.tinypic.com/ioiw6f.png)
 
##Documentation
C2C Thompson helped explain to me how to get the lab to store constants, and C2C Leaf explained that one needs to set up a counter for the B functionality Key to keep resetting.
 
