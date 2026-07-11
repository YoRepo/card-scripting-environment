--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Lycanthrope  (ID: 84385264)
-- Type: Monster / Effect / Ritual
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level: 6
-- ATK 2400 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can only be Ritual Summoned with the Ritual Spell Card, "Synthesis Spell".
-- When this card inflicts Battle Damage to your opponent, inflict 200 damage to your opponent for each
-- Normal Monster in your Graveyard.
--[[ __CARD_HEADER_END__ ]]

--ライカン・スロープ
function c84385264.initial_effect(c)
	aux.AddCodeList(c,72446038)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84385264,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c84385264.damcon)
	e1:SetTarget(c84385264.damtg)
	e1:SetOperation(c84385264.damop)
	c:RegisterEffect(e1)
end
function c84385264.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c84385264.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_NORMAL)*200
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c84385264.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_NORMAL)*200
	Duel.Damage(p,dam,REASON_EFFECT)
end
