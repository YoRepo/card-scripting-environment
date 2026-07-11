--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Satellarknight Procyon  (ID: 99668578)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 1300 | DEF 1200
-- Setcode: 0x9c
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Summoned: You can send 1 "tellarknight" monster from your hand to the Graveyard, and
-- if you do, draw 1 card.
-- You can only use this effect of "Satellarknight Procyon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--星因士 プロキオン
function c99668578.initial_effect(c)
	--handes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99668578,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,99668578)
	e1:SetTarget(c99668578.target)
	e1:SetOperation(c99668578.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	c99668578.star_knight_summon_effect=e3
end
function c99668578.filter(c)
	return c:IsSetCard(0x9c) and c:IsType(TYPE_MONSTER)
end
function c99668578.target(e,tp,eg,ep,ev,re,r,rp,chk,_,exc)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsExistingMatchingCard(c99668578.filter,tp,LOCATION_HAND,0,1,exc) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c99668578.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,c99668578.filter,1,1,REASON_EFFECT)~=0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
