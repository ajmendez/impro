;+
; NAME:
;   INIT_PSFEX_CONFIG()
; PURPOSE:
;   Initialize a PSFEx configuration structure.
; OUTPUTS: 
;   config - configuration structure with all the data needed to
;     run PSFEx using IM_PSFEX
; MODIFICATION HISTORY:
;   J. Moustakas, 2013 May 24, Siena
;-

function init_psfex_config, ncopies
    if (n_elements(ncopies) eq 0) then ncopies = 1
;   etcpath = getenv('IMPRO_DIR')+'/etc/'
    config = {$
; PSF model
      BASIS_TYPE:      'PIXEL_AUTO'       ,$ ; NONE, PIXEL, GAUSS-LAGUERRE or FILE
      BASIS_NUMBER:    20                 ,$ ; Basis number or parameter
      BASIS_NAME:      'basis.fits'       ,$ ; Basis filename (FITS data-cube)
      BASIS_SCALE:     1.0                ,$ ; Gauss-Laguerre beta parameter
      NEWBASIS_TYPE:   'NONE'             ,$ ; Create new basis: NONE, PCA_INDEPENDENT or PCA_COMMON
      NEWBASIS_NUMBER: 8                  ,$ ; Number of new basis vectors
      PSF_SAMPLING:    0.0                ,$ ; Sampling step in pixel units (0.0 = auto)
      PSF_PIXELSIZE:   1.0                ,$ ; Effective pixel size in pixel step units
      PSF_ACCURACY:    0.01               ,$ ; Accuracy to expect from PSF "pixel" values
      PSF_SIZE:        '25,25'            ,$ ; Image size of the PSF model
      PSF_RECENTER:    'N'                ,$ ; Allow recentering of PSF-candidates Y/N ?
      MEF_TYPE:        'INDEPENDENT'      ,$ ; INDEPENDENT or COMMON
; point source measurements
      CENTER_KEYS:     'X_IMAGE,Y_IMAGE'  ,$ ; Catalogue parameters for source pre-centering
      PHOTFLUX_KEY:    'FLUX_APER(1)'     ,$ ; Catalogue parameter for photometric norm.
      PHOTFLUXERR_KEY: 'FLUXERR_APER(1)'  ,$ ; Catalogue parameter for photometric error
; PSF variability
      PSFVAR_KEYS:     'X_IMAGE,Y_IMAGE'  ,$ ; Catalogue or FITS (preceded by :) params
      PSFVAR_GROUPS:   '1,1'              ,$ ; Group tag for each context key
      PSFVAR_DEGREES:  2                  ,$ ; Polynom degree for each group
      PSFVAR_NSNAP:    9                  ,$ ; Number of PSF snapshots per axis
      HIDDENMEF_TYPE:  'COMMON'           ,$ ; INDEPENDENT or COMMON
      STABILITY_TYPE:  'EXPOSURE'         ,$ ; EXPOSURE or SEQUENCE
; sample selection 
      SAMPLE_AUTOSELECT:  'Y'             ,$ ; Automatically select the FWHM (Y/N) ?
      SAMPLEVAR_TYPE:     'SEEING'        ,$ ; File-to-file PSF variability: NONE or SEEING
      SAMPLE_FWHMRANGE:   '2.0,10.0'      ,$ ; Allowed FWHM range
      SAMPLE_VARIABILITY: 0.2             ,$ ; Allowed FWHM variability (1.0 = 100%)
      SAMPLE_MINSN:       20              ,$ ; Minimum S/N for a source to be used
      SAMPLE_MAXELLIP:    0.3             ,$ ; Maximum (A-B)/(A+B) for a source to be used
      SAMPLE_FLAGMASK:    '0x00fe'        ,$ ; Rejection mask on SExtractor FLAGS
      BADPIXEL_FILTER:    'N'             ,$ ; Filter bad-pixels in samples (Y/N) ?
      BADPIXEL_NMAX:      0               ,$ ; Maximum number of bad pixels allowed
; PSF homogeneisation kernel
      HOMOBASIS_TYPE:     'NONE'          ,$ ; NONE or GAUSS-LAGUERRE
      HOMOBASIS_NUMBER:   10              ,$ ; Kernel basis number or parameter
      HOMOBASIS_SCALE:    1.0             ,$ ; GAUSS-LAGUERRE beta parameter
      HOMOPSF_PARAMS:     '2.0,3.0'       ,$ ; Moffat parameters of the idealised PSF
      HOMOKERNEL_DIR:     './'            ,$ ; Where to write kernels (empty=same as input)
      HOMOKERNEL_SUFFIX:  '.homo.fits'    ,$ ; Filename extension for homogenisation kernels
; check plots
      CHECKPLOT_DEV:       'NULL'         ,$ ; NULL, XWIN, TK, PS, PSC, XFIG, PNG, JPEG, AQT, PDF or SVG
      CHECKPLOT_RES:       0              ,$ ; Check-plot resolution (0 = default)
      CHECKPLOT_ANTIALIAS: 'Y'            ,$ ; Anti-aliasing using convert (Y/N) ?
      CHECKPLOT_TYPE:      'NONE'         ,$ ; FWHM,ELLIPTICITY,COUNTS, COUNT_FRACTION, CHI2, RESIDUALS or NONE
      CHECKPLOT_NAME:      ''             ,$ ; fwhm, ellipticity, counts, countfrac, chi2, resi
; check images 
      CHECKIMAGE_TYPE: 'CHI,PROTOTYPES,SAMPLES,RESIDUALS,SNAPSHOTS'       ,$ ; or MOFFAT,-MOFFAT,-SYMMETRICAL
      CHECKIMAGE_NAME: 'chi.fits,proto.fits,samp.fits,resi.fits,snap.fits',$
      CHECKIMAGE_CUBE: 'N'                ,$                 ; Save check-images as datacubes (Y/N) ?
; miscellaneous 
      PSF_DIR:          './'              ,$                 ; Where to write PSFs (empty=same as input)
      PSF_SUFFIX:      '.psf'             ,$                 ; Filename extension for output PSF filename
      VERBOSE_TYPE:    'NORMAL'           ,$                 ; can be QUIET,NORMAL,LOG or FULL
      WRITE_XML:       'N'                ,$                 ; Write XML file (Y/N)?
      XML_NAME:        'psfex.xml'        ,$                 ; Filename for XML output
      XSL_URL:         'file:///usr/local/share/psfex/psfex.xsl',$ ; Filename for XSL style-sheet
      NTHREADS:        0}       ; Number of simultaneous threads for the SMP version of PSFEx (0 = automatic)
    config = replicate(config,ncopies)
    
return, config
end
