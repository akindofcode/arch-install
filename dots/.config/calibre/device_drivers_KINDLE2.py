# settings for device drivers

### Begin group: DEFAULT
 
# format map
# Ordered list of formats the device will accept
format_map = cPickle.loads('\x80\x02]q\x01(X\x03\x00\x00\x00kfxq\x02X\x03\x00\x00\x00azwq\x03X\x04\x00\x00\x00azw3q\x04X\x04\x00\x00\x00mobiq\x05X\x03\x00\x00\x00prcq\x06X\x04\x00\x00\x00azw1q\x07X\x03\x00\x00\x00tpzq\x08X\x04\x00\x00\x00azw4q\tX\x04\x00\x00\x00pobiq\nX\x03\x00\x00\x00pdfq\x0bX\x03\x00\x00\x00txtq\x0ce.')
 
# use subdirs
# Place files in sub-directories if the device supports them
use_subdirs = True
 
# read metadata
# Read metadata from files on device
read_metadata = True
 
# use author sort
# Use author sort instead of author
use_author_sort = False
 
# save template
# Template to control how books are saved
save_template = u'{author_sort}/{title} - {authors}'
 
# extra customization
# Extra customisation
extra_customization = cPickle.loads('\x80\x02]q\x01(\x88X\x04\x00\x00\x00fastq\x02X\x08\x00\x00\x00numpagesq\x03X\x00\x00\x00\x00\x88e.')
 


