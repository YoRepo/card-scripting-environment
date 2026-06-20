--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 小丑王  (ID: 72992744)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 场上没有这张卡以外的怪兽存在的场合，双方的魔法与陷阱卡区域存在的卡每有1张，这张卡的攻击力上升1000。
--[[ __CARD_HEADER_END__ ]]

--ジェスター・ロード
function c72992744.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c72992744.atkcon)
	e1:SetValue(c72992744.atkval)
	c:RegisterEffect(e1)
end
function c72992744.atkcon(e)
	return not Duel.IsExistingMatchingCard(nil,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c72992744.filter(c)
	return c:GetSequence()<5
end
function c72992744.atkval(e,c)
	return Duel.GetMatchingGroupCount(c72992744.filter,0,LOCATION_SZONE,LOCATION_SZONE,nil)*1000
end
