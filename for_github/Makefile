all:
	@mkdir -p /home/merilhan/data/mariadb
	@mkdir -p /home/merilhan/data/wordpress
	@docker compose -f srcs/docker-compose.yml up --build -d 

clean:
	@docker compose -f srcs/docker-compose.yml down --rmi all -v

fclean: clean
	@sudo rm -rf /home/merilhan/data

re: fclean all

.PHONY: all clean fclean re
