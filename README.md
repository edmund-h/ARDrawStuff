# ARDrawStuff
You should be able to use this app to draw things on flat surfaces, save a drawing, and place it back on the surface.

This app was created initially using Apple's ARKitExample. Those files were then modified according to the tutorial at:
https://www.toptal.com/swift/ios-arkit-tutorial-drawing-in-air-with-fingers

I am making further modifications to the app in order to gain an understanding of working with graphics libraries and ARKit.

HOW TO USE:

1) Acquire tracking on the drawing surface by holding the phone steady at a level angle to the drawing surface. This has occurred when a yellow box (focus square) appears. This button will also clear the drawing from the surface.
2) Place your fingers on the drawing surface and inside the focus square as if holding a pen. This will be your virtual pen tip.
3) Acquire tracking on your virtual pen tip: With your non drawing hand, tap the point on the screen where your fingers meet to set the pen tip. A red dot will appear when this is successful.
5) Now select the "Draw" button (dark grey when selected). Moving your fingers will cause the virtual pen tip to follow your fingers and draw a line of brown squares along the drawing surface. Take care to keep your fingers as near as possible to the focus square. You can move the phone but try to keep it at the same level and height relative to the drawing surface.
6) When you are finished drawing, you can press the "3D!" button. Raising your fingers above the drawing plane will cause the squares drawn along the drawing plane to increase in height. (This is the limit of the original functionality of the app, by Osama AbdelKarim AbdoulHassan.)
7) Once you are done drawing, hit the save button. You should get a message that your drawing was saved.
8) When you want to load your saved drawing, hit the place button. This will once again bring up the focus square, allowing you to chose a location for to place the saved drawing.
9) When the focus square is above the area you want to place your drawing, press it again. The focus square will disappear and your saved drawing will now appear in the center!
10) To clear the saved drawing, reset using the button at the top right and hit save.
