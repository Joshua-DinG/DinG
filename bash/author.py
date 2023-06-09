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
    file_path = './feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm'
    line_num = 708
    new_line = '<tr><td width="33%"><%:Kernel Version%></td><td><%=unameinfo.release or "?"%></span><span style="color:#00FF00;"> Plus</span></td></tr>\n'
    replace_line(file_path, line_num, new_line)

    # 示例2：在第712行后插入一行
    file_path = './feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm'
    line_num = 712
    new_line = '<tr style="background-color: #0d1117;"><td width="33%"><span style="color:#3fb937;">Nice To Meet You !</a>  </td><td><a href="https://github.com/Joshua-DinG/Build-OpenWRT"><span style="color:#3fb937;">Joshua-DinG</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a><span style="color:#3fb937;">GitHub &nbsp; DinG</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://github.com/Joshua-DinG/Build-OpenWRT"><span style="color:#3fb937;">机场</a>\n'
    insert_line(file_path, line_num+1, new_line)
