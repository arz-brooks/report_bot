require("addon")
sampev = require 'samp.events'
password = '������'     -- ������ ��� �����������
referals = 'Sam_Mason'  -- ��� ������������� �� ������
referals_active = true  -- ���� true, �� ��� �����������, ����� ����������� �������

function sampev.onShowDialog(id, style, title, button1, button2, text)
    if title:match('�������������� ����������') then
        return false
    end
    if id == 1 then
        if text:match('����� ����������') then
            sendDialogResponse(id, 1, -1, password)
            return false
        end
        if text:match('�������') then
            sendDialogResponse(id, 1, 0, '')
            return false
        end
        if text:match('�������') then
            sendDialogResponse(id, 1, 0, '')
            return false
        end
        if text:match('�������') then
            if referals_active == true then
                sendDialogResponse(id, 1, 1, '')
            else
                sendDialogResponse(id, 1, 0, '')
            end
            return false
        end
        if text:match('������� ���') then
            sendDialogResponse(id, 1, -1, referals)
            return false
        end
    end
end

function sampev.onShowTextDraw(id, data)
    if data.position.x == 233 then
        sendClickTextdraw(id)
    end
end