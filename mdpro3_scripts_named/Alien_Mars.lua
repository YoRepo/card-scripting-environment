--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 火星外星人  (ID: 99532708)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Reptile
-- Level 3
-- ATK 1000 | DEF 1000
-- Setcode: 12
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，「火星外星人」以外的放置有A指示物的怪兽的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--エーリアン・マーズ
function c99532708.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTarget(c99532708.distg)
	c:RegisterEffect(e1)
end
function c99532708.distg(e,c)
	return c:GetCounter(0x100e)>0 and not c:IsCode(99532708)
end
