# Build
Install zeit/ncc by running this command in your terminal. 

```
npm i -g @zeit/ncc
```

Compile main.js. 
```
ncc build main.js
```

You'll see a new dist/index.js file with your code and the compiled modules.

Change the main keyword in `action.yml` to use the new dist/index.js file. main: 'dist/index.js'
