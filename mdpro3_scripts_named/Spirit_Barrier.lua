--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 灵魂障壁  (ID: 53239672)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 只要自己场上存在怪兽，对这张卡的控制者的战斗伤害变为0。
--[[ __CARD_HEADER_END__ ]]

--スピリットバリア
function c53239672.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--avoid battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetCondition(c53239672.condition)
	c:RegisterEffect(e2)
end
function c53239672.condition(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)>0
end
