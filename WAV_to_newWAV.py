
import re
import os
import glob
import time



def search_for_m ():
    '''
    Searches for .m files in your current working directory
    and its subfolders
    in:     nothing
    out:    m_files_directories: list of the paths of the .m files
    '''
    current_path = os.getcwd()
    m_files_directories = []
    for root, dirnames, filenames in os.walk(current_path):
        m_files_directories.extend(glob.glob(root + "/*.m"))

    return m_files_directories,current_path


def generate_logfile (current_path):
    '''
    Generates log-file
    in:     cwd
    out:    log-file as empty string
    '''
    with open(current_path + '\log_wav_to_audio.txt' , 'a') as log_file:
        log_file.write('\nRun on ' + time.strftime('%c') + '\n')
    log_file = ''

    return log_file

def write_to_logfile (content, current_path):
    '''
    writing string to log-file
    in:     content as a string
            cwd
    out:    nothing
    '''
    with open(current_path + '\log_wav_to_audio.txt' , 'a') as log_file:
        log_file.write(content)


def is_wav_thing_anywhere(path_m_file):
    '''
    looks for a wavread or wavwrite in the m-file
    in:     the path of one m-file
    out:    boolean True if there is any wav-thing
                    False if there is none
    '''
    with open(path_m_file, 'r') as m_file:
        content = m_file.read()
        if (wav_r in content) or (wav_w in content):

            return True
        else:

            return False


def is_a_wav_left (new_file, log_file):
    '''
    looks if wavreads or wavwrites left in the new file
    in:     new_file (processed content as string)
            log_file (string)
    out:    log_file (string)
    '''
    new_lines = new_file.split('\n')
    wavr_left_line = []
    wavw_left_line = []
    for idx, new_line in enumerate(new_lines):
        if 'wavread' in new_line:
            wavr_left_line.append(idx)
        if 'wavwrite' in new_line:
            wavw_left_line.append(idx)
    if wavr_left_line != [] :
        log_file += ('     ' + str(len(wavr_left_line)) + \
        ' wavreads left in line/s:'+ str(wavr_left_line)+'\n')
    if wavw_left_line != [] :
        log_file += ('     ' + str(len(wavw_left_line)) + \
         ' wavwrites left in line/s:' + str(wavw_left_line)+'\n')

    return log_file



def processing_files (file_list, log_file):
    '''
    parser for all the work on the m-file, writes lines with change to the
    log-file
    '''
    for path_m_file in file_list:
        if is_wav_thing_anywhere(path_m_file):
            log_file = log_file + '\n'
            log_file = log_file + '   File: ' + path_m_file + '\n'

            with open(path_m_file, 'r') as m_file:
                content = m_file.readlines()
            new_file = ''

            for idx,one_line in enumerate(content):

                if (one_line == '\n') or (one_line == ''):
                    new_file = new_file + one_line
'''
match muss geschrieben werden für wavread und audioread
'''
                one_line_pars = replace_all_cases(one_line)


                if one_line != one_line_pars:
                    log_line = ('      line ' + str(idx + 1) + ': ' + one_line)

                    log_file = log_file + log_line

                    new_file = new_file + one_line_pars
                    continue


                new_file = new_file + one_line
            log_file = is_a_wav_left(new_file, log_file)

            with open(path_m_file,'w') as m_file:
                m_file.write(new_file)


        else:
            continue

    return log_file
