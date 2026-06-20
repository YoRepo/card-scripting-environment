--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 蜜罐机器人  (ID: 34472920)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Cyberse
-- ATK 1900 | LINK
--
-- Effect Text:
-- 电子界族怪兽2只
-- ①：这张卡所连接区的怪兽不会成为效果的对象，不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--ハニーボット
function c34472920.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_CYBERSE),2,2)
	c:EnableReviveLimit()
	--cannot be target/battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c34472920.tgtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	c:RegisterEffect(e2)
end
function c34472920.tgtg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end
