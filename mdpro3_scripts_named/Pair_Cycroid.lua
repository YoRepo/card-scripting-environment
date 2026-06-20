--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 双人单车机人  (ID: 16114248)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Machine
-- Level 5
-- ATK 1600 | DEF 1200
-- Setcode: 22
--
-- Effect Text:
-- 同名机械族怪兽×2
-- ①：这张卡可以直接攻击。
--[[ __CARD_HEADER_END__ ]]

--ペアサイクロイド
function c16114248.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c16114248.ffilter,2,true)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
function c16114248.ffilter(c,fc,sub,mg,sg)
	return c:IsRace(RACE_MACHINE) and (not sg or sg:FilterCount(aux.TRUE,c)==0 or sg:IsExists(Card.IsFusionCode,1,c,c:GetFusionCode()))
end
