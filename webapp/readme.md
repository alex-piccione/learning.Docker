# Web app

Simple Express web app in TypeScript.    
https://blog.logrocket.com/typescript-with-node-js-and-express/

It uses _nodemon_ for development. It **requires** _ts-node_.  

- start app in dev: ``yarn start``
- run tests: ``yarn test``

## nodemon
**nodemon** is a tool that helps develop Node.js based applications by automatically restarting the Node application when file changes in the directory are detected. To use it, you may add a start script in the package.json file as specified below:  
``"start": "nodemon app.ts"