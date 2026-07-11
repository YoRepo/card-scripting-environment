--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Zoodiac Thoroughblade  (ID: 77150143)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level: 4
-- ATK 1600 | DEF 0
-- Setcode: 0xf1
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Normal or Special Summoned: You can discard 1 "Zoodiac" card, and if you do, draw 1
-- card.
-- An Xyz Monster whose original Type is Beast-Warrior and has this card as Xyz Material gains this
-- effect.
-- ● If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--十二獣サラブレード
function c77150143.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77150143,0))
	e1:SetCategory(CATEGORY_HANDES_SELF+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c77150143.drtg)
	e1:SetOperation(c77150143.drop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--get effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_XMATERIAL)
	e3:SetCode(EFFECT_PIERCE)
	e3:SetCondition(c77150143.condition)
	c:RegisterEffect(e3)
end
function c77150143.filter(c)
	return c:IsSetCard(0xf1) and c:IsDiscardable(REASON_EFFECT)
end
function c77150143.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsExistingMatchingCard(c77150143.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c77150143.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,c77150143.filter,1,1,REASON_EFFECT+REASON_DISCARD,nil)~=0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c77150143.condition(e)
	return e:GetHandler():GetOriginalRace()==RACE_BEASTWARRIOR
end
