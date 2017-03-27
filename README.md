# BuckleScript Phoenix
BuckleScript binding for Phoenix Channel/Presence to Phoenix's official JavaScript client
Add this to you `assets/js/app.js`
To install
```bash
npm install -save bucklescript-phx
```
```javascript
import {Socket, Channel, Push, Presence} from "phoenix"
global.Socket = Socket
global.Channel = Channel
global.Presence = Presence
````