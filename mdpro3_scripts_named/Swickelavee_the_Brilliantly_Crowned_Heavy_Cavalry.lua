--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: test-release.cdb
-- Card: Swickelavee the Brilliantly Crowned Heavy Cavalry  (ID: 101306045)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Rank: 3
-- ATK 2000 | DEF 2000
-- Scope: OCG
--
-- Effect Text:
-- 2 Level 3 monsters
-- Once per turn, you can also Xyz Summon "Swickelavee the Brilliantly Crowned Heavy Cavalry" by using
-- 1 Beast monster you control with 2000 or less ATK (transfer its materials). Cannot be used as
-- material for an Xyz Summon. If this card destroys a monster by battle: Place 1 Crown Counter on it,
-- then apply this effect based on the number of Crown Counters on it.
-- ● 1: This card gains 400 ATK.
-- ● 2: This card gains 600 ATK.
-- ● 3: Return this card to the Extra Deck, and if you do, draw 3 cards.
--[[ __CARD_HEADER_END__ ]]

--燦冠乗騎シックラヴィー
local s,id,o=GetID()
local COUNTER_CROWN=0x77
function s.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,2,s.ovfilter,aux.Stringid(id,0),2,s.xyzop)
	c:EnableReviveLimit()
	c:EnableCounterPermit(COUNTER_CROWN)
	--cannot be xyz material
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e0:SetValue(1)
	c:RegisterEffect(e0)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_TOEXTRA+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(s.ctcon)
	e1:SetTarget(s.cttg)
	e1:SetOperation(s.ctop)
	c:RegisterEffect(e1)
end
function s.ovfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEAST) and c:IsAttackBelow(2000)
end
function s.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,id)==0 end
	Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function s.ctcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end
function s.predcat(ct)
	if ct==1 or ct==2 then
		return CATEGORY_ATKCHANGE
	elseif ct==3 then
		return CATEGORY_TOEXTRA+CATEGORY_DRAW
	else
		return 0
	end
end
function s.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return true end
	local ct=c:GetCounter(COUNTER_CROWN)+1
	local cat=s.predcat(ct)
	e:SetCategory(cat)
	if cat&CATEGORY_ATKCHANGE~=0 then
		Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,c,1,0,0)
	elseif cat&CATEGORY_TOEXTRA~=0 then
		Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,c,1,0,0)
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(3)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
	end
end
function s.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not (c:IsRelateToChain() and c:IsFaceup()) then return end
	if not c:AddCounter(COUNTER_CROWN,1) then return end
	local ct=c:GetCounter(COUNTER_CROWN)
	if ct==1 then
		Duel.BreakEffect()
		s.atkup(c,400)
	elseif ct==2 then
		Duel.BreakEffect()
		s.atkup(c,600)
	elseif ct==3 then
		Duel.BreakEffect()
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		if Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)>0 and c:IsLocation(LOCATION_EXTRA) then
			Duel.Draw(p,d,REASON_EFFECT)
		end
	end
end
function s.atkup(c,val)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end
