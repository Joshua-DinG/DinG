def replace_line(file_path, line_num, new_line):
    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    lines[line_num-1] = new_line

    with open(file_path, 'w', encoding='utf-8') as f:
        for line in lines:
            f.write(line)


def insert_line(file_path, line_num, new_line):
    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    lines.insert(line_num, new_line)

    with open(file_path, 'w', encoding='utf-8') as f:
        for line in lines:
            f.write(line)


if __name__ == '__main__':
    # 示例1：替换第708行
    file_path = './package/lean/autocore/files/x86/index.htm'
    line_num = 746
    new_line = '<tr><td width="33%"><%:Kernel Version%></td><td><%=unameinfo.release or "?"%></span><span style="color:#3fb937;">&nbsp; Plus</span></td></tr>\n'
    replace_line(file_path, line_num, new_line)

    # 示例2：在第713行插入一行
    file_path = './package/lean/autocore/files/x86/index.htm'
    line_num = 750
    new_line = '<tr style="background-color: #0d1117;"><td width="33%"><span style="color:#3fb937;">Nice To Meet You !</a>  </td><td><a href="https://github.com/Joshua-DinG/Build-OpenWRT"><span style="color:#3fb937;">Josh-DinG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;QQ:1009721777</a></td></tr>\n'
    insert_line(file_path, line_num-1, new_line)
