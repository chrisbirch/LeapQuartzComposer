LeapQuartzComposer
==================
Author: Chris Birch
Date: 05/01/13

Quartz Composer Plugin to enable QC compositions to receive data from Leap Motion device using Leap SDK 7.

Background:

Plugin inspired by the pre SDK 7 "LeapQC" project on GitHub (see credits). 

Credits:

Jon Hammond for getting me involved with this cool device.
https://www.facebook.com/justaddmusic
 
Andrew Pouliot
http://darknoon.com/about/
https://github.com/darknoon/LeapQC



Changes:

v0.11

- Added QC "pretty" names for ports
- Exposed frame dictionary
- Exposed Screens array
- Exposed hands array
- Exposed fingers array
- Exposed pointables array
- Exposed tools array
- user can now choose which properties are exposed by setting bool with corresponding name.