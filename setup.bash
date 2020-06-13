cd ..
cd ..

echo $'\e[1;33m'Enter Your App Info Here:$'\e[0m'
npm init

echo $'\e[0;32m'installing dependencies$'\e[0m'
echo $'\e[1;31m'WILL STICK ON [ $'\e[0m'postinstall: $'\e[0;30m'$'\e[47m'sill$'\e[0m' $'\e[0;35m'install$'\e[0m' executeActions$'\e[1;31m' ] FOR 1 MINUTE$'\e[0m'
echo $'\e[0;34m'i am sorry :\($'\e[0m'
npm install --no-audit react react-dom axios express path nodemon

echo $'\e[0;32m'installing devDependencies$'\e[0m'
npm install --save-dev @babel/core @babel/cli @babel/preset-react @babel/preset-env babel-loader webpack webpack-cli jest enzyme

echo $'\e[0;32m'writing webpack.config.js$'\e[0m'
cat > webpack.config.js <<- "EOF"
const path = require('path');

module.exports = {
  entry: `${__dirname}/client/src/Index.jsx`,
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        loader: "babel-loader"
      }
    ]
  },
  output: {
    filename: 'bundle.js',
    path: `${__dirname}/public`
  }
};
EOF

echo $'\e[0;32m'writing .babelrc$'\e[0m'
cat > .babelrc <<- "EOF"
{ "presets": ["@babel/preset-env", "@babel/preset-react"] }
EOF

echo $'\e[0;32m'writing .gitignore$'\e[0m'
cat > .gitignore <<- "EOF"
node_modules
bundle.js
.
EOF

echo $'\e[0;32m'writing server$'\e[0m'
mkdir server
cat > server/index.js <<- "EOF"
const express = require('express');
const path = require('path');
const app = express();
const port = 3127;

app.use(express.static(path.join(__dirname, '../public')));

app.get('/', (req, res) => {
  res.end();
});

app.listen(port, () => console.log(`Listening at http://localhost:${port}`));
EOF

echo $'\e[0;32m'writing client$'\e[0m'
mkdir client
mkdir client/src
cat > client/src/Index.jsx <<- "EOF"
import React from 'react';
import ReactDOM from 'react-dom';
import App from './components/App.jsx';

ReactDOM.render(<App />, document.getElementById('app'));
EOF

mkdir client/src/components
cat > client/src/components/App.jsx <<- "EOF"
import React from 'react';
const axios = require('axios');

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  componentDidMount() {
    axios.get('/')
    .then(res => console.log(res))
    .catch(err => console.error(err));
  };

  render() {
    return (
      <div>Ahoy Cap't! App is Running!</div>
    )
  };
}

export default App;
EOF

echo $'\e[0;32m'writing db$'\e[0m'
mkdir db
touch db/index.js

echo $'\e[0;32m'writing test$'\e[0m'
mkdir test
touch test/test.js

echo $'\e[0;32m'writing public$'\e[0m'
mkdir public
cat > public/index.html <<- "EOF"
<!DOCTYPE html>
<html style="font-family: Lato, sans-serif;">
  <head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
    <title></title>
  </head>
  <body>
    <div id="app"></div>
    <script src="bundle.js"></script>
  </body>
</html>
EOF

echo $'\e[0;32m'adding README.md$'\e[0m'
cat > README.md <<- "EOF"
Make something cool!
EOF

echo $'\e[0;32m'adding scripts$'\e[0m'
cat > newPackage.js <<- "EOF"
const fs = require('fs');
const path = require('path');
const file = path.join(__dirname, 'package.json');
fs.readFile(file, 'utf-8', (error, read) => {
  if (error) console.log(error);
  read = read.split('\n');
  let newPackage = ``;
  let searching = true;
  read.map((line, i) => {
    words = line.split(' ');
    if (searching) {
      for (let i = 0; i < words.length; i++) {
        if (words[i] === '"test":') {
          newPackage += `    "start": "nodemon server/index.js",\n    "react-dev": "webpack -d -w"\n`;
          searching = false;
          break;
        }
      }
      if (searching) newPackage += `${line}\n`
    } else {
      newPackage += `${line}\n`
    }
  });
  fs.writeFile(file, newPackage, 'utf-8', (err, succ) => {
    if (err) console.log(err)
  });
});
EOF
node newPackage.js
rm newPackage.js

npm run react-dev & npm start & open http://localhost:3127/ & echo $'\e[1;32m'DONE!$'\e[0m'
echo ' '
echo $'\e[1;33m' - npm run commands -$'\e[0m'
echo $'\e[0;34m'server: $'\e[0;33m'npm start$'\e[0m'
echo $'\e[0;34m'babel: $'\e[0;33m'npm run react-dev$'\e[0m'
