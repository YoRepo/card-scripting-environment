--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Galaxy-Eyes Antimatter Dragon  (ID: 92517928)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Dragon
-- Rank: 9
-- ATK 4000 | DEF 0
-- Setcode: 0x107b
-- Scope: OCG
--
-- Effect Text:
-- 2 Level 9 monsters
-- Once per turn, you can also Xyz Summon "Galaxy-Eyes Antimatter Dragon" by using 1 Xyz Monster you
-- control with 3 or more materials (transfer its materials).
-- Any battle damage this card inflicts to your opponent while it has material is halved.
-- You can detach 1 material from this card; it can make up to 2 attacks on monsters during each Battle
-- Phase this turn, then if the detached material was a monster, you can send 1 monster with the same
-- Type as that monster from your Deck to the GY.
--[[ __CARD_HEADER_END__ ]]

--ギャラクシーアイズ・アンチマター・ドラゴン
local s,id,o=GetID()
function s.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,2,s.ovfilter,aux.Stringid(id,0),2,s.xyzop)
	c:EnableReviveLimit()
	--halve damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e1:SetCondition(s.damcon)
	e1:SetValue(aux.ChangeBattleDamage(1,HALF_DAMAGE))
	c:RegisterEffect(e1)
	--atk twice
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(aux.bpcon)
	e2:SetCost(s.atkcost)
	e2:SetTarget(s.atktg)
	e2:SetOperation(s.atkop)
	c:RegisterEffect(e2)
end
function s.ovfilter(c)
	return c:IsFaceup() and c:IsAllTypes(TYPE_XYZ+TYPE_MONSTER) and c:GetOverlayCount()>=3
end
function s.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,id)==0 end
	Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function s.damcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function s.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	local ct=Duel.GetOperatedGroup():GetFirst()
	if ct:IsType(TYPE_MONSTER) then
		e:SetLabel(ct:GetOriginalRace())
	else
		e:SetLabel(0)
	end
end
function s.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEffectCount(EFFECT_EXTRA_ATTACK)==0
		and e:GetHandler():GetEffectCount(EFFECT_EXTRA_ATTACK_MONSTER)==0 end
	if e:GetLabel()~=0 then
		e:SetCategory(CATEGORY_DECKDES)
	else
		e:SetCategory(0)
	end
end
function s.tgfilter(c,race)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave() and c:IsRace(race)
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain()
		and c:GetEffectCount(EFFECT_EXTRA_ATTACK)==0
		and c:GetEffectCount(EFFECT_EXTRA_ATTACK_MONSTER)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local race=e:GetLabel()
		if e:GetLabel()~=0 and Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_DECK,0,1,nil,race)
			and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local g=Duel.SelectMatchingCard(tp,s.tgfilter,tp,LOCATION_DECK,0,1,1,nil,race)
			if g:GetCount()>0 then
				Duel.SendtoGrave(g,REASON_EFFECT)
			end
		end
	end
end
