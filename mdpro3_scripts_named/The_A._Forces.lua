--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 联合军  (ID: 403847)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上的战士族怪兽的攻击力上升自己场上的战士族·魔法师族怪兽数量×200的数值。
--[[ __CARD_HEADER_END__ ]]

--連合軍
function c403847.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_WARRIOR))
	e2:SetValue(c403847.val)
	c:RegisterEffect(e2)
end
function c403847.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_WARRIOR+RACE_SPELLCASTER)
end
function c403847.val(e,c)
	return Duel.GetMatchingGroupCount(c403847.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
