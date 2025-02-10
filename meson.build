project(
  'streflop-ng',
  ['cpp'],
  default_options: ['cpp_std=c++11', 'warning_level=2'],
  version: '0.3.1',
)

cxx = meson.get_compiler('cpp')
#cc = meson.get_compiler('c')

extra_flags = [
  '-frounding-math',
  '-fsignaling-nans',
  '-fno-strict-aliasing',
  '-mieee-fp'
]

#add_project_arguments(, language: 'cpp')
lib_args = cxx.get_supported_arguments(extra_flags)

sources = []
_softwrapper_static_libs = []
type_arg = []
flags = []
if get_option('x87')
  type_arg += ['-DSTREFLOP_X87']
  flags += ['-mfpmath=387']
endif
if get_option('sse')
  type_arg += ['-DSTREFLOP_SSE']
  flags += ['-msse', '-msse2', '-mfpmath=sse']
endif
if get_option('soft')
  type_arg += ['-DSTREFLOP_SOFT']
endif
if get_option('no_denormals')
  type_arg += ['-DSTREFLOP_NO_DENORMALS']
endif

lib_args += cxx.get_supported_arguments([flags, type_arg])

if get_option('soft')
  sources += 'softfloat/softfloat.cpp'
  configurations = [
    {'defs': ['-DN_SPECIALIZED=32'], 'name': 'SoftFloatWrapperSimple'},
    {'defs': ['-DN_SPECIALIZED=64'], 'name': 'SoftFloatWrapperDouble'},
    {'defs': ['-DN_SPECIALIZED=96'], 'name': 'SoftFloatWrapperExtended'},
  ]
  foreach conf : configurations
    _softwrapper_static_libs += static_library(
      conf['name'],
      ['SoftFloatWrapper.cpp'],
      # include_directories: '.',
      cpp_args: [conf['defs'], lib_args],
    )
  endforeach
endif

# add_project_arguments(cc.get_supported_arguments(extra_flags), language: 'c')

# Dependencies
#libm_dep = cxx.find_library('m', required: true)

incdir = include_directories('libm')

sources += ['Math.cpp', 'Random.cpp']

libm = static_library(
  'libm',
  ['libm/e_expf.cpp', 'libm/w_expf.cpp'],
  include_directories: ['libm/headers', incdir],
  cpp_args: ['-DLIBM_COMPILING_FLT32', lib_args],
  pic: true,
)

libm_flt32_sources = [
  'e_acosf.cpp',
  'e_acoshf.cpp',
  'e_asinf.cpp',
  'e_atan2f.cpp',
  'e_atanhf.cpp',
  'e_coshf.cpp',
  'e_exp2f.cpp',
  'e_expf.cpp',
  'e_fmodf.cpp',
  'e_gammaf_r.cpp',
  'e_hypotf.cpp',
  'e_j0f.cpp',
  'e_j1f.cpp',
  'e_jnf.cpp',
  'e_lgammaf_r.cpp',
  'e_log10f.cpp',
  'e_log2f.cpp',
  'e_logf.cpp',
  'e_powf.cpp',
  'e_remainderf.cpp',
  'e_rem_pio2f.cpp',
  'e_sinhf.cpp',
  'e_sqrtf.cpp',
  'k_cosf.cpp',
  'k_rem_pio2f.cpp',
  'k_sinf.cpp',
  'k_tanf.cpp',
  's_asinhf.cpp',
  's_atanf.cpp',
  's_cbrtf.cpp',
  's_ceilf.cpp',
  's_copysignf.cpp',
  's_cosf.cpp',
  's_erff.cpp',
  's_expm1f.cpp',
  's_fabsf.cpp',
  's_finitef.cpp',
  's_floorf.cpp',
  's_fpclassifyf.cpp',
  's_frexpf.cpp',
  's_ilogbf.cpp',
  's_isinff.cpp',
  's_isnanf.cpp',
  's_ldexpf.cpp',
  's_llrintf.cpp',
  's_llroundf.cpp',
  's_log1pf.cpp',
  's_logbf.cpp',
  's_lrintf.cpp',
  's_lroundf.cpp',
  's_modff.cpp',
  's_nearbyintf.cpp',
  's_nextafterf.cpp',
  's_remquof.cpp',
  's_rintf.cpp',
  's_roundf.cpp',
  's_scalblnf.cpp',
  's_scalbnf.cpp',
  's_signbitf.cpp',
  's_sincosf.cpp',
  's_sinf.cpp',
  's_tanf.cpp',
  's_tanhf.cpp',
  's_truncf.cpp',
  'w_expf.cpp',
]

libm_flt32_sources_full = []
foreach file : libm_flt32_sources
  libm_flt32_sources_full += join_paths('libm/flt-32', file)
endforeach

_flt32_lib = static_library(
  'flt32',
  libm_flt32_sources_full,
  cpp_args: ['-DLIBM_COMPILING_FLT32', lib_args],
  include_directories: [incdir, 'libm/headers'],
  pic: true,
)

libm_dbl64_sources = [
  'branred.cpp',
  'doasin.cpp',
  'dosincos.cpp',
  'e_acos.cpp',
  'e_acosh.cpp',
  'e_asin.cpp',
  'e_atan2.cpp',
  'e_atanh.cpp',
  'e_cosh.cpp',
  'e_exp2.cpp',
  'e_exp.cpp',
  'e_fmod.cpp',
  'e_gamma_r.cpp',
  'e_hypot.cpp',
  'e_j0.cpp',
  'e_j1.cpp',
  'e_jn.cpp',
  'e_lgamma_r.cpp',
  'e_log10.cpp',
  'e_log2.cpp',
  'e_log.cpp',
  'e_pow.cpp',
  'e_remainder.cpp',
  'e_rem_pio2.cpp',
  'e_sinh.cpp',
  'e_sqrt.cpp',
  'halfulp.cpp',
  'k_cos.cpp',
  'k_rem_pio2.cpp',
  'k_sin.cpp',
  'k_tan.cpp',
  'mpa.cpp',
  'mpatan2.cpp',
  'mpatan.cpp',
  'mpexp.cpp',
  'mplog.cpp',
  'mpsqrt.cpp',
  'mptan.cpp',
  's_asinh.cpp',
  's_atan.cpp',
  's_cbrt.cpp',
  's_ceil.cpp',
  's_copysign.cpp',
  's_cos.cpp',
  's_erf.cpp',
  's_expm1.cpp',
  's_fabs.cpp',
  's_finite.cpp',
  's_floor.cpp',
  's_fpclassify.cpp',
  's_frexp.cpp',
  's_ilogb.cpp',
  'sincos32.cpp',
  's_isinf.cpp',
  's_isnan.cpp',
  's_ldexp.cpp',
  's_llrint.cpp',
  's_llround.cpp',
  's_log1p.cpp',
  's_logb.cpp',
  'slowexp.cpp',
  'slowpow.cpp',
  's_lrint.cpp',
  's_lround.cpp',
  's_modf.cpp',
  's_nearbyint.cpp',
  's_nextafter.cpp',
  's_nexttoward.cpp',
  's_remquo.cpp',
  's_rint.cpp',
  's_round.cpp',
  's_scalbln.cpp',
  's_scalbn.cpp',
  's_signbit.cpp',
  's_sincos.cpp',
  's_sin.cpp',
  's_tan.cpp',
  's_tanh.cpp',
  's_trunc.cpp',
  'w_exp.cpp',
]

libm_dbl64_sources_full = []
foreach file : libm_dbl64_sources
  libm_dbl64_sources_full += join_paths('libm/dbl-64', file)
endforeach

_dbl64_lib = static_library(
  'dbl64',
  libm_dbl64_sources_full,
  cpp_args: ['-Wno-narrowing', '-DLIBM_COMPILING_DBL64=1', lib_args],
  include_directories: ['libm/headers', incdir],
  pic: true,
)

lib_streflop_ng = library(
  meson.project_name(),
  [sources],
  version: meson.project_version(),
  include_directories: incdir,
  cpp_args: [lib_args],
  link_with: [_flt32_lib, _dbl64_lib, libm, _softwrapper_static_libs],
  install: not meson.is_subproject(),
  pic: true,
)

# How to use in a superproject and other info
# https://mesonbuild.com/Subprojects.html
streflop_dep = declare_dependency(
  link_with: lib_streflop_ng,
  include_directories: '.',
)

subdir('tests')

headers = [
  'FPUSettings.h',
  'IntegerTypes.h',
  'Math.h',
  'Random.h',
  'SoftFloatWrapper.h',
  'streflop.h',
  'System.h',
  'X87DenormalSquasher.h',
]

if not meson.is_subproject()
  install_headers(
    ['FPUSettings.h', 'Math.h', 'Random.h', 'SoftFloatWrapper.h', 'streflop.h'],
    subdir: 'streflop',
  )
endif
