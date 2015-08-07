var spawn=require('child_process').spawn;                                       
var crypto=require('crypto');                                                   
                                                                                
var gith=require('gith').create(9001);                                          
                                                                                
console.log('listening on 9001');                                               
var shell=process.env.SHELL;                                                    
if (shell == undefined) shell="/bin/bash";                                      
                                                                                
var opts={};                                                                    
                                                                                
  //repo: 'amaline/cu-bot-scripts'                                              
                                                                                
gith({}).on('all',function(payload) {                                           
   console.log('post received');                                                
                                                                                
   var args=['-c','npm install ' + payload.original.git_url];                   
                                                                                
   if (payload.signatureMatch) {                                                
                                                                                
      console.log('launching shell with: ' + shell);                            
      var npm=spawn(shell,args,opts);                                           
                                                                                
       npm.on('close',function(code) {                                          
          console.log('npm completed with exit code: ' + code);                 
        });                                                                     
                                                                                
   } else {                                                                     
                                                                                
      console.log("HMAC payload failure");                                      
                                                                                
   }                                                                            
                                                                                
});  
