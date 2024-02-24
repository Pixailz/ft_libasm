/* ########################################################################## */
/* ANSI CODE */
/* ###### */

# define	ESC			"\x1b"
# define	CSI			ESC "["

// Needed when wanting len of string without ansi escaped code
# define	ANSI_BEG	"\001"
# define	ANSI_END	"\002"

/* DEFINE */

# define __ANSI_C_E(C)		CSI C "m"
# define __ANSI_C_D(C)		""

# ifdef ANSI_NO_COLOR
#  define	_ANSI_C(C)				__ANSI_C_D(C)
#  define	_ANSI_M(C)				__ANSI_C_D(C)
# else
#  define	_ANSI_C(C)				__ANSI_C_E(C)
#  ifdef ANSI_NO_MODIFIER
#   define	_ANSI_M(C)				__ANSI_C_D(C)
#  else
#   define	_ANSI_M(C)				__ANSI_C_E(C)
#  endif /* NO_MODIFIER */
# endif /* NO_COLOR */

/* COLOR / MODIFIER */

# define	BLA			_ANSI_C("30")			// BLACK
# define	RED			_ANSI_C("31")			// RED
# define	GRE			_ANSI_C("32")			// GREEN
# define	YEL			_ANSI_C("33")			// YELLOW
# define	BLU			_ANSI_C("34")			// BLUE
# define	PUR			_ANSI_C("35")			// PURPLE
# define	CYA			_ANSI_C("36")			// CYAN
# define	WHI			_ANSI_C("37")			// WHITE
# define	ORA			_ANSI_C("38;5;208")		// ORANGE
# define	PIN			_ANSI_C("38;5;218")		// PINK

/* MODIFIER */

# define RST			_ANSI_M("0")			// RESET
# define BOL			_ANSI_M("1")			// BOLD
# define ITA			_ANSI_M("3")			// ITALIC
# define UND			_ANSI_M("4")			// UNDERLINE
# define BLI			_ANSI_M("5")			// BLINKING

/* CURSOR */
# define CUR_COL(C)		CSI C "G"

/* ########################################################################## */

/* COMPOSITE */
# define SEP			" → "					// UNICODE ARROW
# define SEP_RES		" "						// UNICODE ARROW

# define GOTO_RESULT	CUR_COL("20")

# define P_PART			"[" ORA "*" RST "]" SEP
# define P_OK			"[" GRE "+" RST "]" SEP_RES
# define P_KO			"[" RED "-" RST "]" SEP_RES


/* ########################################################################## */
