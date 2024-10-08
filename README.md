# PowerPUG!
PowerPUG! is a tiny tool built to help Active Directory (AD) admins, operators, and defenders smoothly transition their most sensitive users (Domain Admins, etc.) into the AD Protected Users group (PUG) with minimal complications. The PUG provides its member multiple non-configurable protections that stop common attacks in their tracks. Unfortunately, those same protections sometimes cause issues with some very common applications and typical administration workflows (as well as some less desirable admin behaviors). These issues have limited the adoption of the PUG in most AD environments.

PowerPUG! is designed to guide AD practitioners through PUG adoption by identifying process and application compatibility issues before they become problems in production. PowerPUG! first ensures all prerequisites are in place then scours Domain Controller (DC) event logs to identify applications and behaviors that could cause trouble once the PUG is fully implemented. After identification, PowerPUG! provides basic guidance on how to resolve these issues, whether that solution is "improving account tiering" or "stop using that misbehaving application". Once all problems are resolved, PowerPUG! will assist with moving users into the Protected Users group.

```
  @@@@@@@@@@@@@@@@@@@@                                     @@@@@@@@@@@@@@@@@@@  
 @@@@@@@@@@@@@@@@@@@&                                       @@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@                                            %@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@                                                 @@@@@@@@@@@@@@@
@@@@@@@@@@@@@                                                      %@@@@@@@@@@@@
@@@@@@@@@@@                                                           @@@@@@@@@@
@@@@@@@@                                                                @@@@@@@@
@@@@@@                                                                     @@@@@
@@@           %@@@                                       @@@@                @@@
             @@@@@                  @@@@@@@@#           @@@@(                   
             @@@@@@.   ,@        @@@@@@@@@@@@@@        #@@@@@@    @@            
             *@@@@@@@@@@,      @@@@@@@@@@@@@@@@@@@      @@@@@@@@@@@             
                @@@@@@      %@@@@@             @@@@@       @@@@@#               
                          @@@@@@@@,           @@@@@@@@@                         
                       (@@@@@@@@@@@@@      (@@@@@@@@@@@@@                       
                     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%                    
                  (@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                  
                @@@@@@@@@@@@@@@@@@@@@@@@.@@@@@@@@@@@@@@@@@@@@@@@&               
              @@@@@@@@@@@@@@@@@@@@@           @@@@@@@@@@@@@@@@@@@@,             
             @@@@@@@@@@@@@@@@@@@                 @@@@@@@@@@@@@@@@@@             
             *@@@@@@@@@@@@@@@@@@@.             @@@@@@@@@@@@@@@@@@@@             
              #@@@@@@@@@@@@@@@@@@@@@,       @@@@@@@@@@@@@@@@@@@@@@              
                 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
```
