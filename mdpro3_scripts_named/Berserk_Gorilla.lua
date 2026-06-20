--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 愤怒的类人猿  (ID: 39168895)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 2000 | DEF 1000
--
-- Effect Text:
-- 当这张卡在场上以表侧守备表示存在时，这张卡被破坏。当这张卡处于可以进行攻击的状态时，这张卡的控制者必须让这张卡进行攻击。
--[[ __CARD_HEADER_END__ ]]

--怒れる類人猿
function c39168895.initial_effect(c)
	--must attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MUST_ATTACK)
	c:RegisterEffect(e1)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c39168895.descon)
	c:RegisterEffect(e3)
end
function c39168895.descon(e)
	return e:GetHandler():IsDefensePos()
end
