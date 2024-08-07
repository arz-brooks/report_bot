require("addon")
sampev = require 'samp.events'
password = 'пароль'     -- Пароль при регистрации
referals = 'Sam_Mason'  -- Ник пригласившего на сервер
referals_active = true  -- Если true, то при регистрации, будет указываться реферал

function sampev.onShowDialog(id, style, title, button1, button2, text)
    if title:match('Дополнительная информация') then
        return false
    end
    if id == 1 then
        if text:match('Добро пожаловать') then
            sendDialogResponse(id, 1, -1, password)
            return false
        end
        if text:match('Мужской') then
            sendDialogResponse(id, 1, 0, '')
            return false
        end
        if text:match('Светлый') then
            sendDialogResponse(id, 1, 0, '')
            return false
        end
        if text:match('Вкладка') then
            if referals_active == true then
                sendDialogResponse(id, 1, 1, '')
            else
                sendDialogResponse(id, 1, 0, '')
            end
            return false
        end
        if text:match('Введите ник') then
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