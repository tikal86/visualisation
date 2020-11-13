let Elm = require('../elm/Main');
console.log(`Elm: ${JSON.stringify(Elm)}`);
let container = document.getElementById("container");
console.log(`Elm: ${container}`);
let app = Elm.Elm.Main.init({node: container});
app.ports.sendMessage.subscribe(message => console.log('Message from Elm'));
app.ports.messageReceiver.send('Data for Elm');