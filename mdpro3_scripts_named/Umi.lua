--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 海  (ID: 22702055)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 全部鱼族·海龙族·雷族·水族的怪兽攻击力·守备力上升200。机械族·炎族的怪兽攻击力·守备力下降200。
--[[ __CARD_HEADER_END__ ]]

--海
function c22702055.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(c22702055.val)
	c:RegisterEffect(e2)
	--Def
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c22702055.val(e,c)
	local r=c:GetRace()
	if bit.band(r,RACE_FISH+RACE_SEASERPENT+RACE_THUNDER+RACE_AQUA)>0 then return 200
	elseif bit.band(r,RACE_MACHINE+RACE_PYRO)>0 then return -200
	else return 0 end
end
