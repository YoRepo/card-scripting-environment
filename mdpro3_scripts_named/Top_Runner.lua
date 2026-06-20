--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 领跑者  (ID: 53623827)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Machine
-- Level 4
-- ATK 1100 | DEF 800
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，自己场上表侧表示存在的全部同调怪兽的攻击力上升600。
--[[ __CARD_HEADER_END__ ]]

--トップ・ランナー
function c53623827.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_SYNCHRO))
	e1:SetValue(600)
	c:RegisterEffect(e1)
end
