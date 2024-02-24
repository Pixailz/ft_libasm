/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: brda-sil <brda-sil@students.42angouleme    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/01/13 20:14:10 by brda-sil          #+#    #+#             */
/*   Updated: 2024/02/24 02:36:27 by brda-sil         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

/* INCLUDE */

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>

#include "libasm.h"
#include "ansi.h"

/* ERR STATUS */
# define ERR_STRLEN				1UL<<1

# define ERR_STRCPY_PTR			1UL<<2
# define ERR_STRCPY_CMP			1UL<<3

# define ERR_STRCMP_RET			1UL<<4

# define ERR_WRITE_RET			1UL<<5
# define ERR_WRITE_ERR			1UL<<6

# define ERR_READ_RET			1UL<<7
# define ERR_READ_ERR			1UL<<8
# define ERR_READ_BUF			1UL<<9

# define ERR_STRDUP_CMP			1UL<<10

int	ERR = 0;

/* PRINT */
void	ppart(char *s)
{ printf("%s%s%s", P_PART, s, GOTO_RESULT); }

void	pok(char *s)
{ if (!s) printf("%s", P_OK);
  else printf("[%s%s%s]", GRE, s, RST); }

void	pko(char *s)
{ if (!s) printf("%s", P_KO);
  else printf("[%s%s%s]", RED, s, RST); }

void	perrno(char *k, int err)
{ printf("[%serrno%s] %s%s%d", BLU, RST, k, SEP, err); }

/* TEST WRAPPER */
void	w_strlen(char *str)
{
	unsigned int mine_size = ft_strlen(str);
	unsigned int real_size = strlen(str);

	if (real_size == mine_size)
		pok("size");
	else
	{
		pko("size");
		printf("ft_strlen: KO: size\n");
		ERR |= ERR_STRLEN;
	}
}

void	w_strcpy(char *src)
{
	char	buffer[100] = {0};
	char	*ptr;

	ptr = ft_strcpy(buffer, src);
	if (ptr == buffer)
		pok("ptr");
	else
	{
		pko("ptr");
		ERR |= ERR_STRCPY_PTR;
	}
	if (!strcmp(buffer, src))
		pok("cmp");
	else
	{
		pko("cmp");
		ERR |= ERR_STRCPY_CMP;
	}
}

void	w_strcmp(char *s1, char *s2, char mode)
{
	int retv = ft_strcmp(s1, s2);

	if (mode == 'e' && retv == 0)
		pok("retv == 0");
	else if (mode == 'l' && retv < 0)
		pok("retv < 0");
	else if (mode == 'g' && retv > 0)
		pok("retv > 0");
	else
	{
		pko("retv > 0");
		ERR |= ERR_STRCMP_RET;
	}
}

void	w_write(int fd, char *str, int size)
{
	int	retv[2] = {0};
	int	err[2] = {0};

	retv[0] = write(fd, str, size);
	err[0] = errno;
	perrno("libc errno", err[0]);
	retv[1] = ft_write(fd, str, size);
	err[1] = errno;
	perrno("test errno", err[1]);
	if (retv[0] == retv[1])
		pok("retv");
	else
	{
		pko("retv");
		ERR |= ERR_WRITE_RET;
	}
	if (err[0] == err[1])
		pok("err");
	else
	{
		pko("err");
		ERR |= ERR_WRITE_ERR;
	}
}

void	w_read(int fd, int size)
{
	char	buff1[0x42] = {0};
	char	buff2[0x42] = {0};
	int		err[2] = {0};
	int		retv[2] = {0};

	retv[0] = read(fd, buff1, size);
	err[0] = errno;
	perrno("libc errno", err[0]);
	retv[1] = ft_read(fd, buff2, size);
	err[1] = errno;
	perrno("test errno", err[1]);
	if (retv[0] == retv[1])
		pok("retv");
	else
	{
		pko("retv");
		ERR |= ERR_READ_RET;
	}
	if (err[0] == err[1])
		pok("err");
	else
	{
		pko("err");
		ERR |= ERR_READ_ERR;
	}
	if (!strcmp(buff1, buff2))
		pok("buff");
	else
	{
		pko("buff");
		ERR |= ERR_READ_BUF;
	}
}

void	w_strdup(const char *str)
{

	char *ret = ft_strdup(str);
	if (strcmp(str, ret))
	{
		pko("cmp");
		ERR |= ERR_STRDUP_CMP;
	}
	else
		pok("cmp");
}

/* MAIN */
void	test_strlen(void)
{
	ppart("ft_strlen");
	// w_strlen(NULL);
	w_strlen("1234");
}

void	test_strcpy(void)
{
	ppart("ft_strcpy");
	w_strcpy("1234");
}

void	test_strcmp(void)
{
	ppart("ft_strcmp");
	w_strcmp("1234", "1234", 'e');
	w_strcmp("1234", "4321", 'l');
	w_strcmp("4321", "1234", 'g');
}

void	test_write(void)
{
	ppart("ft_write");
	w_write(1, "Hello World\n", 13);
	w_write(-1, "Hello World\n", 13);
}

void	test_read(void)
{
	ppart("ft_read");
	// w_read(0, 10);
}

void	test_strdup(void)
{
	ppart("ft_strdup");
	w_strdup("Hello");
	w_strdup("");
	// w_strdup(NULL); // SEGFAULT on both libc and libasm ...
}

int	main(void)
{
	test_strlen();		puts("");
	test_strcpy();		puts("");
	test_strcmp();		puts("");
	test_write();		puts("");
	test_read();		puts("");
	test_strdup();		puts("");
	return (0);
}
