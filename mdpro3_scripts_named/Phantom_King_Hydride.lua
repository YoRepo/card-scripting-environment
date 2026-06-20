--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 幻影王 幽骑  (ID: 6901008)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1500 | DEF 300
--
-- Effect Text:
-- ①：把自己场上的这张卡作为同调素材的场合，可以把这张卡当作调整以外的怪兽使用。
--[[ __CARD_HEADER_END__ ]]

--幻影王 ハイド・ライド
function c6901008.initial_effect(c)
	--nontuner
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_NONTUNER)
	e1:SetValue(c6901008.tnval)
	c:RegisterEffect(e1)
end
function c6901008.tnval(e,c)
	return e:GetHandler():IsControler(c:GetControler())
end
