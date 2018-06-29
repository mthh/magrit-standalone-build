const {app, BrowserWindow} = require('electron')
const path = require('path')
const url = require('url')


let win

const spawn = require('child_process').spawn;
let child;

function createWindow () {
  // Create the browser window.
  win = new BrowserWindow({width: 800, height: 600, webPreferences: { webSecurity: false, allowRunningInsecureContent: true, nodeIntegration: false }});

  // and load the index.html of the app.
  win.loadURL(url.format({
    pathname: path.join(__dirname, 'index.html'),
    protocol: 'file:',
    slashes: true
  }))

  child = spawn(
	'./Magrit',
    { cwd: './Magrit/dist/Magrit/', detached: true },
	function(error, stdout, stderr) {
		document.getElementById('foo').innerHTML += "stdout: " + stdout;
		document.getElementById('foo').innerHTML += "stderr: " + stderr;
		console.log('stdout: ' + stdout);
		console.log('stderr: ' + stderr);
		if (error !== null) {
			console.log('exec error: ' + error)
		}
	});
  child.stdout.pipe(process.stdout);
  child.stderr.pipe(process.stderr);
  // Emitted when the window is closed.
  win.on('closed', () => {
    process.kill(-child.pid);
    // Dereference the window object, usually you would store windows
    // in an array if your app supports multi windows, this is the time
    // when you should delete the corresponding element.
    win = null;
  })
  setTimeout(() => {
	win.loadURL('http://localhost:9999/modules');
  }, 1800);
}

app.on('ready', createWindow)

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', () => {
  if (win === null) {
    createWindow()
  }
})


