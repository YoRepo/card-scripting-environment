--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 幻想绵羊  (ID: 30451366)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 3
-- ATK 1150 | DEF 900
--
-- Effect Text:
-- 这张卡可以作为1只融合素材怪兽的代替。那个时候，其他的融合素材怪兽必须是正规品。
--[[ __CARD_HEADER_END__ ]]

--イリュージョン・シープ
function c30451366.initial_effect(c)
	--fusion substitute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e1:SetCondition(c30451366.subcon)
	c:RegisterEffect(e1)
end
function c30451366.subcon(e)
	return e:GetHandler():IsLocation(LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE)
end
