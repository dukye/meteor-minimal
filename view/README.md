# makeView - Bash script

@todo

## Installation

## Changelogs

## QuickStart
### Simple

1. Copy makeView.sh on your base meteor project directory
2. Go to your meteor app

```
$ chmod +x makeView.sh
$ ./makeView.sh myview
$ ls myapp/client/views
```
3. Once your view is created go back to project root (lib/routes.js)
```
this.route('myview', {
	path: '/myview',
	controller: 'MyviewController'
});
```
4. Add your route to router and launch http://localhost:3000/myview

## Contact

