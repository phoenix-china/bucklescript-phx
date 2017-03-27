# BuckleScript Phoenix
BuckleScript binding for Phoenix Channel/Presence to Phoenix's official JavaScript client

To install

```bash
npm install -save bucklescript-phx
```

Please add this to you `assets/js/app.js`
```javascript
import {Socket, Channel, Presence} from "phoenix"
global.Socket = Socket
global.Channel = Channel
global.Presence = Presence
````