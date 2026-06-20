--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 沼地的魔兽王  (ID: 99426834)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 4
-- ATK 1000 | DEF 1100
--
-- Effect Text:
-- 这张卡可以代替融合怪兽素材的其中1只来融合。这个时候，其他的融合素材必须是指定的融合素材。
--[[ __CARD_HEADER_END__ ]]

--沼地の魔獣王
function c99426834.initial_effect(c)
	--fusion substitute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e1:SetCondition(c99426834.subcon)
	c:RegisterEffect(e1)
end
function c99426834.subcon(e)
	return e:GetHandler():IsLocation(LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE)
end
