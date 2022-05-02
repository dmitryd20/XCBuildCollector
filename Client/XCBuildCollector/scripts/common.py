import os
import enum


class Constants(enum.Enum):
    default_package_name = "package"


# Environment
def get_project_name() -> str:
    file_name = os.environ.get("XcodeWorkspace") or os.environ.get("XcodeProject", "No project")
    project_name = file_name.split(".")[0]
    if project_name == Constants.default_package_name.value:
        return fixed_spm_name()
    else:
        return project_name


def fixed_spm_name() -> str:
    workspace_path = os.environ.get("XcodeWorkspacePath")
    if not workspace_path:
        return Constants.default_package_name.value
    # get project name from path components
    #   -4      -3     -2         -1
    # *NAME*/.swiftpm/xcode/package.xcworkspace
    return workspace_path.split('/')[-4]


# Utils
def get_dir_size(path: str):
    total = 0
    for entry in os.scandir(path):
        if entry.is_file():
            total += entry.stat().st_size
        elif entry.is_dir():
            total += get_dir_size(entry.path)
    return total
