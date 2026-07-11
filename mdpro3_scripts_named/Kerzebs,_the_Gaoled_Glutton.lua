--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Kerzebs, the Gaoled Glutton  (ID: 94503794)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Beast
-- Rank: 7
-- ATK 700 | DEF 2500
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2+ Level 7 monsters
-- Gains 700 ATK for each material attached to it.
-- Once per Chain, when a Normal or Quick-Play Spell Card is activated (Quick Effect): You can attach
-- that card on the field to this face-up card, and if you do, this card is unaffected by that
-- activated card.
-- During the End Phase: You can Set 1 Spell Card that is attached to this card.
-- You can only use this effect of "Kerzebs, the Gaoled Glutton" once per turn.
--[[ __CARD_HEADER_END__ ]]

--漆梏の喰獣 ケルゼブス
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,7,2,nil,nil,99)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(s.atkval)
	c:RegisterEffect(e1)
	--xyz
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_CHAIN)
	e2:SetCondition(s.matcon)
	e2:SetTarget(s.mattg)
	e2:SetOperation(s.matop)
	c:RegisterEffect(e2)
	--sett
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SSET)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,id)
	e3:SetTarget(s.settg)
	e3:SetOperation(s.setop)
	c:RegisterEffect(e3)
end
function s.atkval(e,c)
	return c:GetOverlayCount()*700
end
function s.matcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
		and (re:IsActiveType(TYPE_QUICKPLAY) or re:GetHandler():GetType()==TYPE_SPELL)
end
function s.mattg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return re:GetHandler():IsCanOverlay() and e:GetHandler():IsType(TYPE_XYZ) end
	re:GetHandler():CreateEffectRelation(e)
end
function s.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=re:GetHandler()
	if c:IsFaceup() and c:IsRelateToChain()
		and tc:IsRelateToChain() and tc:IsCanOverlay()
		and not tc:IsImmuneToEffect(e) then
		tc:CancelToGrave()
		Duel.Overlay(c,tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_CHAIN)
		e1:SetValue(s.efilter(re))
		c:RegisterEffect(e1)
	end
end
function s.efilter(re)
	return	function(e,te)
				return te==re and te:IsActivated()
			end
end
function s.setfilter(c,tp)
	return c:IsType(TYPE_SPELL) and c:IsSSetable()
		and (Duel.GetLocationCount(tp,LOCATION_SZONE)>0 or c:IsType(TYPE_FIELD))
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetHandler():GetOverlayGroup()
	if chk==0 then return g:IsExists(s.setfilter,1,nil,tp) end
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() then
		local g=c:GetOverlayGroup()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local sg=g:FilterSelect(tp,s.setfilter,1,1,nil,tp)
		if sg:GetCount()>0 then
			Duel.SSet(tp,sg:GetFirst())
		end
	end
end
