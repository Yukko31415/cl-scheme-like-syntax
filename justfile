
[arg("port", long="port")]
[arg("client", long="client")]
exec port="4005" client="sly":
	sbcl --eval '(asdf:load-system :cl-discord-bot)' \
	     --eval '(asdf:load-system :{{ if client == "slime" { "swank" } else { "slynk" } }})' \
	     --eval '({{ if client == "slime" { "swank" } else { "slynk" } }}:create-server :port {{port}} :dont-close t)'
