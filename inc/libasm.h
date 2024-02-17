#ifndef LIBASM_H
# define LIBASM_H

extern	unsigned int	ft_strlen(const char *s);
extern	int				ft_strcmp(const char *s1, const char *s2);
extern	char			*ft_strcpy(char *dst, const char *src);
extern	int				ft_write(int fd, const void *buff, unsigned int count);
extern	int				ft_read(int fd, char *buff, unsigned int count);
extern	char			*ft_strdup(const char *s);

#endif // LIBASM_H
