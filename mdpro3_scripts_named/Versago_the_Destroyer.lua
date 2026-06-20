--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 破坏神 瓦沙克  (ID: 50259460)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1100 | DEF 900
--
-- Effect Text:
-- 这张卡可以代替融合怪兽素材的其中1只来融合。这个时候，其他的融合素材必须是指定的融合素材。
--[[ __CARD_HEADER_END__ ]]

--破壊神 ヴァサーゴ
function c50259460.initial_effect(c)
	--fusion substitute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e1:SetCondition(c50259460.subcon)
	c:RegisterEffect(e1)
end
function c50259460.subcon(e)
	return e:GetHandler():IsLocation(LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE)
end
