/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   structure.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/03/11 19:41:05 by atrouill          #+#    #+#             */
/*   Updated: 2020/03/12 17:52:19 by atrouill         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef STRUCTURE_H
# define STRUCTURE_H

typedef struct	s_parsing
{
	int			min_width;
	int			precision;
	short		flags;
	short		conv;
}				t_parsing;

typedef struct	s_buffer
{
	int			len;
	int			data_len;
	int			last_pos;
	int			written;
	char		*buffer;
}				t_buffer;

#endif
