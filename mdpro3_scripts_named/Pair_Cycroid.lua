--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Pair Cycroid  (ID: 16114248)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Machine
-- Level: 5
-- ATK 1600 | DEF 1200
-- Setcode: 0x16
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Machine monsters with the same name
-- This card can attack directly.
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
