# Start up

To use the app, download the git repository :
```
git clone https://github.com/gowy971/ece-nodejs.git
```
Since the node-modules are not downloaded, you might need to download them.
```
npm i --save body-parser coffee-script express express-session jade level level-session-store level-ws levelup leveldown morgan nodemon stylus
```

Then to create the initial data, run the script
```
coffee bin/populatedb
```

The next step is to launch the application, with the following instruction
```
coffee src/app.coffee
```

Then you can connect to the port 1337 of your localhost and use the application.
