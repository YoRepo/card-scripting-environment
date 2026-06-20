--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 电气鹬鸵  (ID: 24996659)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Thunder
-- Level 3
-- ATK 600 | DEF 100
-- Setcode: 14
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，自己场上存在的名字带有「电气」的怪兽攻击的场合，攻击怪兽不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--エレキーウィ
function c24996659.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c24996659.indtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c24996659.indtg(e,c)
	return c:IsSetCard(0xe) and c==Duel.GetAttacker()
end
