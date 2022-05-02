from typing import Optional
import time
from common import *
from configs import *


def get_derived_data_path() -> str:
    default_derived_data_path = "~/Library/Developer/Xcode/DerivedData/"
    derived_data_path = read_config(ConfigKey.derived_data_path) or default_derived_data_path
    return expanduser(derived_data_path)


def get_project_derived_dir() -> Optional[os.DirEntry]:
    derived_data_dir = os.scandir(get_derived_data_path())
    # get directories for needed project name in DerivedData
    project_name = get_project_name()
    derived_directories = list(filter(lambda dir: dir.name.startswith(project_name), derived_data_dir))
    if not derived_directories:
        return None
    # sort directories by last modification time to choose latest
    derived_directories = list(sorted(derived_directories, key=lambda dir: dir.stat().st_mtime))
    # last modified directory
    return derived_directories[-1]


def has_build_folder_not_empty() -> bool:
    project_derived_dir = get_project_derived_dir()
    if not project_derived_dir:
        return False
    derived_contents = os.scandir(project_derived_dir.path)
    # find build folder by name
    build_folder_candidates = list(filter(lambda dir: dir.name == "Build", derived_contents))
    if not build_folder_candidates:
        return False
    build_folder = build_folder_candidates[0]
    # build folder size > 1MB
    return get_dir_size(build_folder.path) > pow(10, 6)


start_milliseconds = int(round(time.time() * 1000))
save_start_info(is_incremental=has_build_folder_not_empty(),
                start_time=start_milliseconds)
