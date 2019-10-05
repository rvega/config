To save a session, open tmux, set up yourprograms, panes, etc as you like them, do tmux-save and follow the prompts. Then, edit the saved file to add environment variables and whatever else you need.

To restore the session, run `tmux-load path/to/saved/file.json` from outside tmux.

Here's an example session file, check out the "shell_command" sections and the exported environment variables.

```
{
	"session_name": "Cantoalegre Devel",
	"windows": [
		{
			"window_name": "movil",
			"options": {
				"automatic-rename": "off"
			},
			"layout": "2ea5,142x37,0,0{71x37,0,0,1,70x37,72,0[70x25,72,0,2,70x11,72,26,3]}",
			"panes": [
				{
					"focus": "true",
					"shell_command": [
						"export VIM_SERVERNAME=\"movil\"",
						"cd /home/Rafa/Projects/Active/CantoAlegre/repos/aplicacion-movil/www",
						"vim"
					]
				},
				{
					"shell_command": [
						"export VIM_SERVERNAME=\"movil\"",
						"cd /home/Rafa/Projects/Active/CantoAlegre/repos/aplicacion-movil/www",
						"vim"
					]
				},
				{
					"shell_command": [
						"export VIM_SERVERNAME=\"movil\"",
						"cd /home/Rafa/Projects/Active/CantoAlegre/repos/aplicacion-movil",
						"zsh"
					]
				}
			]
		},
		{
			"window_name": "admin",
			"options": {
				"automatic-rename": "off"
			},
			"layout": "4369,142x37,0,0{71x37,0,0,4,70x37,72,0[70x26,72,0,5,70x10,72,27,6]}",
			"panes": [
				{
					"shell_command": [
						"export VIM_SERVERNAME=\"admin\"",
						"cd /home/Rafa/Projects/Active/CantoAlegre/repos/admin/src/app",
						"vim"
					]
				},
				{
					"shell_command": [
						"export VIM_SERVERNAME=\"admin\"",
						"cd /home/Rafa/Projects/Active/CantoAlegre/repos/admin/src/app",
						"vim"
					]
				},
				{
					"focus": "true",
					"shell_command": [
						"export VIM_SERVERNAME=\"admin\"",
						"cd /home/Rafa/Projects/Active/CantoAlegre/repos/admin",
						"zsh"
					]
				}
			]
		},
		{
			"window_name": "api",
			"options": {
				"automatic-rename": "off"
			},
			"layout": "d297,142x37,0,0{71x37,0,0,8,70x37,72,0[70x18,72,0,9,70x18,72,19,10]}",
			"panes": [
				{
					"shell_command": [
						"export VIM_SERVERNAME=\"api\"",
						"cd /home/Rafa/Projects/Active/CantoAlegre/repos/musica-api",
						"vim"
					]
				},
				{
					"shell_command": [
						"export VIM_SERVERNAME=\"api\"",
						"cd /home/Rafa/Projects/Active/CantoAlegre/repos/musica-api",
						"vim"
					]
				},
				{
					"focus": "true",
					"shell_command": [
						"export VIM_SERVERNAME=\"api\"",
						"cd /home/Rafa/Projects/Active/CantoAlegre/repos/musica-api/server",
						"zsh"
					]
				}
			]
		},
		{
			"window_name": "servers",
			"options": {
				"automatic-rename": "off"
			},
			"layout": "31ce,142x37,0,0[142x13,0,0,11,142x12,0,14,12,142x10,0,27,13]",
			"panes": [
				{
					"shell_command": [
						"cd /home/Rafa/Projects/Active/CantoAlegre/repos/aplicacion-movil",
						"ionic serve"
					]
				},
				{
					"shell_command": [
						"cd /home/Rafa/Projects/Active/CantoAlegre/repos/admin",
						"gulp serve"
					]
				},
				{
					"focus": "true",
					"shell_command": [
						"cd /home/Rafa/Projects/Active/CantoAlegre/repos/musica-api",
						"sudo systemctl start postgresql.service && slc run"
					]
				}
			]
		},
		{
			"options": {
				"automatic-rename": "off"
			},
			"start_directory": "/home/Rafa/Projects/Active/CantoAlegre",
			"window_name": "prj",
			"layout": "5d03,142x37,0,0{67x37,0,0,14,74x37,68,0[74x27,68,0,15,74x9,68,28,16]}",
			"focus": "true",
			"panes": [
				{
					"shell_command":[
						"export VIM_SERVERNAME=\"prj\"", 
						"vim notes.md"
					]
				},
				{
					"shell_command":[
						"export VIM_SERVERNAME=\"prj\"", 
						"vifm"
					]
				},
				{
					"shell_command":[
						"export VIM_SERVERNAME=\"prj\"", 
						"zsh"
					]
				}
			]
		}
	]
}
```
