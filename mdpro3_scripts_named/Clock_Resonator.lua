--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 时钟共鸣者  (ID: 77087109)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Fiend
-- Level 3
-- ATK 1200 | DEF 600
-- Setcode: 87
--
-- Effect Text:
-- 只要这张卡在场上表侧守备表示存在，这张卡1回合只有1次不会被战斗或者卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--クロック・リゾネーター
function c77087109.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c77087109.valcon)
	c:RegisterEffect(e1)
end
function c77087109.valcon(e,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and e:GetHandler():IsDefensePos()
end
