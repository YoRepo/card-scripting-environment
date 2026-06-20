--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 场地防护罩  (ID: 7153114)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 只要这张卡在场上存在，双方不能把场地魔法卡破坏，也不能作场地魔法卡的发动。「场地防护罩」在自己场上只能有1张表侧表示存在。
--[[ __CARD_HEADER_END__ ]]

--フィールドバリア
function c7153114.initial_effect(c)
	c:SetUniqueOnField(1,0,7153114)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_FZONE,LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot activate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,1)
	e3:SetValue(c7153114.filter)
	c:RegisterEffect(e3)
end
function c7153114.filter(e,re,tp)
	return re:GetHandler():IsType(TYPE_FIELD) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
