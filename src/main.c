/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: brda-sil <brda-sil@students.42angouleme    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/01/13 20:14:10 by brda-sil          #+#    #+#             */
/*   Updated: 2024/01/13 20:38:53 by brda-sil         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include "libasm.h"

void	test_strcpy(void)
{
	char	buffer[100] = {0};
	char	*ptr;

	ptr = ft_strcpy(buffer, "1234");
	printf("src:    %s\n", "1234");
	printf("buffer: %s\n", buffer);
	printf("ptr:    %s\n", ptr);
}

int	main(void)
{
	test_strcpy();
	return (0);
}
