# lifx_ctrl

Latest: December 22, 2019
Created by JoeK and distributed to the GetVera Community for use.

Link: https://community.getvera.com/t/instructions-and-steps-to-implement-lifx-api-part-ii/211653

Initial Release Date: March 20, 2016

Link: http://forum.micasaverde.com/index.php?topic=36961.0

The LUA code lifx_ctrl() provides ability to control LIFX lights via Vera U17.
The implementation uses the LIFX API (RESTful) and therefore an internet connection is
required for network access to LIFX servers. The LIFX control provides a basic framework, 
so can easily be modified to enhance its functionality. It's implemented as a LUA 
function and the function can be called by other LUA code or from LUUP within a 
scene on the Vera.

The "token" variable below must be updated with your private API token from LIFX:
	https://cloud.lifx.com/settings

More info on installation and setup here:

  https://community.getvera.com/t/instructions-and-steps-to-implement-lifx-api-part-ii/211653

Enjoy!  :-)
