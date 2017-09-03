/*
 * parse a VDSO
 * written by Stefani Seibold <stefani@seibold.net>
 * (C) 2012
 *
 * General Public License. No warranty. See COPYING for details.
 */

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>

#include <elf.h>

#define RELOC_ADDR(x) (((void *)elffhdr) + (x))

#define unlikely(x)	__builtin_expect(!!(x), 0)

static int init;

int (*vdso_gettimeofday)(struct timeval *tv, struct timezone *tz); // __attribute__ ((regparm (3)));
int (*vdso_clock_gettime)(clockid_t clk_id, struct timespec *tp); // __attribute__ ((regparm (3)));
time_t (*vdso_time)(time_t *t); // __attribute__ ((regparm (3)));

static int _init_vdso(void)
{
	int i;
	Elf32_Dyn *sht_dynamic = NULL;
	void *sht_dynsym = NULL;
	int sht_size = 0;
	int sht_dynsize = 0;
	Elf32_Word dt_strtab_sz = 0;
	Elf32_Word dt_syment_sz = 0;
	const char *dt_strtab = NULL;
	void *dt_symtab = NULL;
	Elf32_Shdr *secthdr;
	Elf32_auxv_t *auxv;
	Elf32_Ehdr *elffhdr = NULL;
	Elf32_Phdr *proghdr;
#if 1
	int h;
	char auxv_file[64];
	char auxv_buf[1024];

	sprintf(auxv_file, "/proc/%d/auxv", getpid());

	h = open(auxv_file, O_RDONLY);
	if (h == -1) {
		fprintf(stderr, "can't open %s\n", auxv_file);
		return 1;
	}
	if (read(h, auxv_buf, sizeof(auxv_buf)) == -1) {
		fprintf(stderr, "can't read %s\n", auxv_file);
		return 1;
	}
	close(h);

	auxv = (Elf32_auxv_t *)auxv_buf;
#else
	char ** evp = __environ;

	while (*evp++ != NULL)
		;

	auxv = (Elf32_auxv_t *)evp;
#endif

	for (; auxv->a_type != AT_NULL; ++auxv) {
		if (auxv->a_type == AT_SYSINFO_EHDR) {
			elffhdr = (Elf32_Ehdr *)auxv->a_un.a_val;
			break;
		}
	}

	if (!elffhdr) {
		fprintf(stderr, "can't locate vdso.\n");
		return 1;
	}

	if (!elffhdr->e_shoff) {
		fprintf(stderr, "invalid section header table offset.\n");
		return 1;
	}

	if (elffhdr->e_shentsize != sizeof(Elf32_Shdr)) {
		fprintf(stderr, "invalid section header table size.\n");
		return 1;
	}

	secthdr = ((void *)elffhdr) + elffhdr->e_shoff;

	for (i = 0; i < elffhdr->e_shnum; ++i) {
		if (secthdr[i].sh_type == SHT_DYNAMIC) {
			sht_dynamic = ((void *)elffhdr) + secthdr[i].sh_offset;
			sht_size = secthdr[i].sh_size / sizeof(Elf32_Dyn);
			break;
		}
	}

	if (!sht_dynamic) {
		fprintf(stderr, "missing dynamic section table location.\n");
		return 1;
	}

	for (i = 0; i < elffhdr->e_shnum; ++i) {
		if (secthdr[i].sh_type == SHT_DYNSYM) {
			sht_dynsym = ((void *)elffhdr) + secthdr[i].sh_offset;
			sht_dynsize = secthdr[i].sh_size;
			break;
		}
	}

	if (!sht_dynsym) {
		fprintf(stderr, "missing dynsym section table location.\n");
		return 1;
	}

fprintf(stderr, "%p\n", elffhdr);
	for(i = 0; i < sht_size; ++i) {
		switch(sht_dynamic[i].d_tag) {
		case DT_NULL:
			break;
		case DT_STRTAB:
			dt_strtab = (const char *)RELOC_ADDR(sht_dynamic[i].d_un.d_ptr);
			break;
		case DT_STRSZ:
			dt_strtab_sz = sht_dynamic[i].d_un.d_val;
			break;
		case DT_SYMTAB:
			dt_symtab = (void *)RELOC_ADDR(sht_dynamic[i].d_un.d_ptr);
			break;
		case DT_SYMENT:
			dt_syment_sz = sht_dynamic[i].d_un.d_val;
			break;
		}
	}

	if (sht_dynsym != dt_symtab) {
		fprintf(stderr, "dynsym section table location missmatch (%p != %p %08x)\n", sht_dynsym, dt_symtab, dt_symtab - sht_dynsym);
		return 1;
	}

	for(i = 0; i < sht_dynsize; i += dt_syment_sz) {
		Elf32_Sym *sym = sht_dynsym + i;
		const char *sym_name;

		if (!sym->st_name)
			continue;

		if (ELF32_ST_TYPE(sym->st_info) != STT_FUNC)
			continue;

		sym_name = dt_strtab + sym->st_name;

		if (!strcmp(sym_name, "__vdso_gettimeofday"))
			vdso_gettimeofday = RELOC_ADDR(sym->st_value);
		else
		if (!strcmp(sym_name, "__vdso_clock_gettime"))
			vdso_clock_gettime = RELOC_ADDR(sym->st_value);
		else
		if (!strcmp(sym_name, "__vdso_time"))
			vdso_time = RELOC_ADDR(sym->st_value);
	}

fprintf(stderr, "vdso_gettimeofday: %p\n", vdso_gettimeofday);
fprintf(stderr, "vdso_clock_gettime: %p\n", vdso_clock_gettime);
fprintf(stderr, "vdso_time: %p\n", vdso_time);
	if (!vdso_gettimeofday) {
		fprintf(stderr, "missing __vdso_gettimeofday symbol.\n");
		return 1;
	}
	if (!vdso_clock_gettime) {
		fprintf(stderr, "missing __vdso_clock_gettime symbol.\n");
		return 1;
	}
	if (!vdso_time) {
		fprintf(stderr, "missing __vdso_time symbol.\n");
		return 1;
	}

	return 0;
}

static void init_vdso(void)
{
	if (_init_vdso())
		abort();
	init = 1;
}

int gettimeofday(struct timeval *tv, struct timezone *tz)
{
	if (unlikely(!init))
		init_vdso();
	return vdso_gettimeofday(tv, tz);
}

int clock_gettime(clockid_t clk_id, struct timespec *tp)
{
	if (unlikely(!init))
		init_vdso();
	return vdso_clock_gettime(clk_id, tp);
}

time_t time(time_t *t)
{
	if (unlikely(!init))
		init_vdso();
	return vdso_time(t);
}

