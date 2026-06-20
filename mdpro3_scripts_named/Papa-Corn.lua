--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 亲子玉米  (ID: 73776643)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 4
-- ATK 1200 | DEF 800
--
-- Effect Text:
-- 场地魔法卡表侧表示存在的场合，这张卡的攻击力上升1000。
--[[ __CARD_HEADER_END__ ]]

--オヤコーン
function c73776643.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c73776643.condtion)
	e1:SetValue(1000)
	c:RegisterEffect(e1)
end
function c73776643.condtion(e)
	return Duel.IsExistingMatchingCard(Card.IsFaceup,0,LOCATION_FZONE,LOCATION_FZONE,1,nil)
end
