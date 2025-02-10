_libm = static_library(
  'libm',
  ['e_expf.cpp', 'w_expf.cpp'],
  include_directories: ['headers', incdir],
  cpp_args: ['-DLIBM_COMPILING_FLT32', lib_args],
  pic: true,
)

subdir('flt-32')
subdir('dbl-64')

_ldbl96_lib = []
if fpu_opt != 'sse'
  subdir('ldbl-96')
endif

