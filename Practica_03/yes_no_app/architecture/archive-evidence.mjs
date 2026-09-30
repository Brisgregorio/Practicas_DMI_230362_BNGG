import fs from 'node:fs';
import path from 'node:path';
const root=path.resolve('architecture'),dest=path.join(root,'earlier-viewer-check');
fs.mkdirSync(dest,{recursive:true});
for(const name of fs.readdirSync(root)){
 if(!/^yes-no-app-architecture\.(visual-check[.]|browser-check[.])/.test(name))continue;
 const from=path.join(root,name),to=path.join(dest,name);
 if(!from.startsWith(root+path.sep)||!to.startsWith(root+path.sep))throw Error('Path outside artifacts');
 if(fs.existsSync(to))throw Error('Existing archived evidence');
 fs.renameSync(from,to);
}
