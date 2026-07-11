--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Tempura of Fortune - EBI  (ID: 86304179)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Aqua
-- Level: 3
-- ATK 1600 | DEF 0
-- Pendulum Scale: L8 / R8
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 8
-- [ Pendulum Effect ]
-- You can target 1 card in your Pendulum Zone; toss a coin.
-- ● Heads: Special Summon it.
-- ● Tails: Destroy it, but lose LP equal to its Pendulum Scale x 300.
-- You can only use this effect of "Tempura of Fortune - EBI" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- We went to EDO-FRONT, which has been the talk of the town. The scale of the Tempura here is not only
-- large but also so beautifully shaped that it has earned the nickname of "Golden Tempura". The
-- state-of-the-art facilities and the atmosphere of other cultures are all in the harbor, but there is
-- also a mellow, nostalgic aroma in the air, and the occasional crackle of the crackling sounds will
-- lift your spirits. We have been looking forward to this cruise for a year, but I think 3 stars is
-- just about right.
--[[ __CARD_HEADER_END__ ]]

--運否の天賦羅－EBI
local s,id,o=GetID()
function s.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.cotg)
	e1:SetOperation(s.coop)
	c:RegisterEffect(e1)
end
s.toss_coin=true
function s.cofilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function s.cotg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_PZONE) and s.cofilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(s.cofilter,tp,LOCATION_PZONE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,s.cofilter,tp,LOCATION_PZONE,0,1,1,nil,e,tp)
end
function s.coop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local c1=Duel.TossCoin(tp,1)
	if c1==1 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	elseif c1==0 then
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			local lp=Duel.GetLP(tp)
			Duel.SetLP(tp,lp-tc:GetCurrentScale()*300)
		end
	end
end
