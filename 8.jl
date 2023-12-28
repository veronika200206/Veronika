#Робот в произв. точке
#Маркер в произвольной точке
#Найтие Маркер
using HorizonSideRobots
robot = Robot("starts/task8.sit",animate = true)

function find_marker!(robot)
    side = Nord
    n = 0# должно увеличиваться каждый 2 поворота
    flag = true #меняем флаг, увел n когда флаг true
    while !find_marker!(robot,side,n) #остановит робота в маркере по прошествии n шагов. Вернет true если найдет, если нет false
        # if flag == true
        #     n+=1
        # end
        if flag
            n = n + 1
        end
        flag  = !flag
        side = left(side)
    end
end

function  find_marker!(robot,side,max_num_steps)
    for _ in 1:max_num_steps
        # if ismarker(robot)
        #     return true
        # end            
        ismarker(robot) && return true #сокращенные логические операции - без выполнения лишних действий
        move!(robot,side)              # x>0 && 1+2. Если x>0 вычислится (1+2)  =>  результат 3
    end
    return false            
end

function move_n!(robot, side::HorizonSide, n)
    for _ in 1:n
        move!(robot,side)
    end    
end

left(side::HorizonSide) = HorizonSide(mod(Int(side)+1,4))

find_marker!(robot)

