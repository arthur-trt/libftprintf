/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_isascii.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/05 17:21:34 by atrouill          #+#    #+#             */
/*   Updated: 2021/03/08 11:19:33 by atrouill         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/libftprintf.h"

/*
**	Test if a number code is a valid ASCII code
**
**	@param c number to test
**
**	@return true if ASCII code / false if not
*/
int	ft_isascii(int c)
{
	if (c >= 0 && c <= 127)
		return (true);
	return (false);
}
