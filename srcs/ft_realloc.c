/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_realloc.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/03/10 15:45:55 by atrouill          #+#    #+#             */
/*   Updated: 2020/03/10 15:49:37 by atrouill         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/libft.h"

void	*ft_realloc(void *ptr, size_t old_size, size_t size)
{
	void	*ret;

	if (!(ret = malloc(size)))
		return (NULL);
	ft_memcpy(ret, ptr, old_size);
	free(ptr);
	return (ret);
}
