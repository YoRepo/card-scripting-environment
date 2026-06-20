--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 守墓的异端者  (ID: 46955770)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 1800 | DEF 1500
-- Setcode: 46
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，并在场上有「王家长眠之谷」存在，这张卡不受这张卡以外的效果影响。
--[[ __CARD_HEADER_END__ ]]

--墓守の異端者
function c46955770.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetCondition(c46955770.con)
	e1:SetValue(c46955770.efilter)
	c:RegisterEffect(e1)
end
function c46955770.con(e)
	return Duel.IsEnvironment(47355498)
end
function c46955770.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
