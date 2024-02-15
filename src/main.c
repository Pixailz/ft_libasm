/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: brda-sil <brda-sil@students.42angouleme    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/01/13 20:14:10 by brda-sil          #+#    #+#             */
/*   Updated: 2024/02/15 04:56:21 by brda-sil         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>

#include "libasm.h"

int	test_strlen(char *str)
{
	unsigned int mine_size = ft_strlen(str);
	unsigned int real_size = strlen(str);
	int retv = 0;

	if (real_size == mine_size)
		printf("ft_strlen: OK: size\n");
	else
	{
		printf("ft_strlen: KO: size\n");
		retv |= 1;
	}
	return (retv);
}

int	test_strcpy(char *src)
{
	char	buffer[100] = {0};
	char	*ptr;
	int		retv = 0;

	ptr = ft_strcpy(buffer, src);
	if (ptr == buffer)
		printf("ft_strcpy: OK: ptr\n");
	else
	{
		printf("ft_strcpy: KO: ptr\n");
		retv |= 1;
	}
	if (!strcmp(buffer, src))
		printf("ft_strcpy: OK: strcmp\n");
	else
	{
		retv |= 1;
		printf("ft_strcpy: KO: strcmp\n");
	}
	return (retv);
}

int	test_strcmp(char *s1, char *s2, char mode)
{
	int retv = ft_strcmp(s1, s2);
	int r = 0;

	if (mode == 'e' && retv == 0)
		printf("ft_strcmp: OK: retv == 0\n");
	else if (mode == 'l' && retv < 0)
		printf("ft_strcmp: OK: retv < 0\n");
	else if (mode == 'g' && retv > 0)
		printf("ft_strcmp: OK: retv > 0\n");
	else
	{
		printf("ft_strcmp: KO: retv\n");
		r |= 1;
	}
	return (r);
}

int	test_write(int fd, char *str, int size)
{
	int	retv[2] = {0};
	int	err[2] = {0};

	retv[0] = write(fd, str, size);
	err[0] = errno;
	printf("ft_write: real: errno %d\n", errno);
	retv[1] = ft_write(fd, str, size);
	err[1] = errno;
	printf("ft_write: mine: errno %d\n", errno);
	if (retv[0] == retv[1])
		printf("ft_write: OK: retv\n");
	else
	{
		printf("ft_write: KO: retv\n");
		return (1);
	}
	if (err[0] == err[1])
		printf("ft_write: OK: errno\n");
	else
	{
		printf("ft_write: KO: errno\n");
		return (1);
	}
	return (0);
}

int	test_read(int fd, int size)
{
	char	buff1[0x42] = {0};
	char	buff2[0x42] = {0};
	int		err[2] = {0};
	int		retv[2] = {0};
	int		r = 0;

	retv[0] = read(fd, buff1, size);
	err[0] = errno;
	printf("ft_read: real: errno %d\n", errno);
	retv[1] = ft_read(fd, buff2, size);
	err[1] = errno;
	printf("ft_read: mine: errno %d\n", errno);
	if (retv[0] == retv[1])
		printf("ft_read: OK: retv\n");
	else
	{
		printf("ft_read: KO: retv\n");
		r |= 1;
	}
	if (err[0] == err[1])
		printf("ft_read: OK: errno\n");
	else
	{
		printf("ft_read: KO: errno\n");
		r |= 1;
	}
	if (!strcmp(buff1, buff2))
		printf("ft_read: OK: buff\n");
	else
	{
		r |= 1;
		printf("ft_read: KO: buff\n");
	}
	return (r);
}

int	main(void)
{
	test_strlen(NULL);
	// test_strlen("1234");
	// test_strcpy("1234");
	// test_strcmp("1234", "1234", 'e');
	// test_strcmp("1234", "4321", 'l');
	// test_strcmp("4321", "1234", 'g');
	// test_write(1, "Hello World\n", 13);
	// test_write(-1, "Hello World\n", 13);
	// test_read(0, 10);
	return (0);
}
