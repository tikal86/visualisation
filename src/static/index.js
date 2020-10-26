// var Elm = require('../elm/Main.elm');
const container = document.getElementById('container');
// const app = Elm.Main.init({node:container});

import Elm from "../elm/Main";
console.log(`Elm: ${JSON.stringify(Elm)}`);
Elm.Main.init({node: container});