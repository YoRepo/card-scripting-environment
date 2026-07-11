--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: D/D/D Oracle King d'Arc  (ID: 82956492)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level: 7
-- ATK 2800 | DEF 2000
-- Setcode: 0x10af
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 "D/D" monsters
-- Any effect that would inflict damage to you makes you gain that much LP, instead.
--[[ __CARD_HEADER_END__ ]]

--DDD神託王ダルク
function c82956492.initial_effect(c)
	--fusion material
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xaf),2,true)
	c:EnableReviveLimit()
	--damage conversion
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_REVERSE_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetValue(c82956492.rev)
	c:RegisterEffect(e2)
end
function c82956492.rev(e,re,r,rp,rc)
	return bit.band(r,REASON_EFFECT)~=0
end
