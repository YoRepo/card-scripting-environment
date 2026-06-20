--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 心眼之女神  (ID: 53493204)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1200 | DEF 1000
--
-- Effect Text:
-- 这张卡可以代替融合怪兽素材的其中1只来融合。这个时候，其他的融合素材必须是指定的融合素材。
--[[ __CARD_HEADER_END__ ]]

--心眼の女神
function c53493204.initial_effect(c)
	--fusion substitute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e1:SetCondition(c53493204.subcon)
	c:RegisterEffect(e1)
end
function c53493204.subcon(e)
	return e:GetHandler():IsLocation(LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE)
end
