SESSION_NAME := zuqui

up:
	@echo "Starting services in tmux..."
	@tmux new-session -d -s $(SESSION_NAME) \; \
		split-window -v -p 80 \; \
		split-window -h \; \
		send-keys -t 0 "top" C-m \; \
		send-keys -t 1 "make -C core run" C-m \; \
		send-keys -t 2 "make -C mobile run" C-m \; \
		attach-session -t $(SESSION_NAME)

up-watch:
	@echo "Starting services in tmux..."
	@tmux new-session -d -s $(SESSION_NAME) \; \
		split-window -v -p 80 \; \
		split-window -h \; \
		send-keys -t 0 "top" C-m \; \
		send-keys -t 1 "make -C core watch" C-m \; \
		send-keys -t 2 "make -C mobile watch" C-m \; \
		attach-session -t $(SESSION_NAME)

down:
	@echo "Stopping services..."
	@tmux kill-session -t $(SESSION_NAME)

attach:
	@tmux attach-session -t $(SESSION_NAME)

.PHONY: up up-watch down attach
