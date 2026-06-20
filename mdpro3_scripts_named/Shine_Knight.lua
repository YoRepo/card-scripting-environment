--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 光辉骑士  (ID: 86952477)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 3
-- ATK 400 | DEF 1900
--
-- Effect Text:
-- 只要这张卡在场上表侧守备表示存在，这张卡的等级变成4星。
--[[ __CARD_HEADER_END__ ]]

--シャインナイト
function c86952477.initial_effect(c)
	--lvchange
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c86952477.lvcon)
	e1:SetValue(4)
	c:RegisterEffect(e1)
end
function c86952477.lvcon(e)
	return e:GetHandler():IsDefensePos()
end
