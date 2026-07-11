--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Odd-Eyes Rebellion Dragon Overlord  (ID: 98452268)
-- Type: Monster / Effect / Xyz / Pendulum
-- Attribute: DARK
-- Race: Dragon
-- Rank: 7
-- ATK 3000 | DEF 2500
-- Pendulum Scale: L4 / R4
-- Setcode: 0x99, 0x13b
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 4
-- [ Pendulum Effect ]
-- Once per turn: You can Special Summon this card from your Pendulum Zone, then Special Summon from
-- your Extra Deck, 1 "Rebellion" or "The Phantom Knights" monster, using this card as material (this
-- is treated as an Xyz Summon), then you can attach 1 card from your Pendulum Zone to it as material.
-- ----------------------------------------
-- [ Monster Effect ]
-- 2 Level 7 monsters
-- You can also Xyz Summon this card by using a "Rebellion" Xyz Monster you control as material.
-- (Transfer its materials to this card.)
-- If you can Pendulum Summon Level 7, you can Pendulum Summon this face-up card from your Extra Deck.
-- This card that was Xyz Summoned using a Rank 7 Xyz Monster as material can make up to 3 attacks
-- during each Battle Phase.
-- If this card in the Monster Zone is destroyed: You can place this card in your Pendulum Zone.
-- You can only Special Summon "Odd-Eyes Rebellion Dragon Overlord(s)" once per turn.
--[[ __CARD_HEADER_END__ ]]

--覇王黒竜オッドアイズ・リベリオン・ドラゴン－オーバーロード
function c98452268.initial_effect(c)
	c:SetSPSummonOnce(98452268)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,2,c98452268.ovfilter,aux.Stringid(98452268,0))
	c:EnableReviveLimit()
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98452268,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c98452268.sptg)
	e1:SetOperation(c98452268.spop)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c98452268.regcon)
	e2:SetOperation(c98452268.regop)
	c:RegisterEffect(e2)
	--material check
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_MATERIAL_CHECK)
	e3:SetValue(c98452268.valcheck)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--extra attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EXTRA_ATTACK)
	e4:SetValue(2)
	e4:SetCondition(c98452268.effcon)
	c:RegisterEffect(e4)
	--pendulum
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(98452268,2))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetCondition(c98452268.pencon)
	e5:SetTarget(c98452268.pentg)
	e5:SetOperation(c98452268.penop)
	c:RegisterEffect(e5)
end
c98452268.pendulum_level=7
function c98452268.ovfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x13b)
end
function c98452268.spfilter(c,e,tp,mc)
	return c:IsSetCard(0x13b,0x10db) and mc:IsCanBeXyzMaterial(c) and c:IsType(TYPE_XYZ)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and not c:IsCode(98452268)
		and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c98452268.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,2) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_XMATERIAL)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c98452268.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c98452268.matfilter(c,e)
	return c:IsCanOverlay() and not c:IsImmuneToEffect(e)
end
function c98452268.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local mg=Group.FromCards(c)
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0
		and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c98452268.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,c)
		local tc=g:GetFirst()
		if tc then
			Duel.BreakEffect()
			tc:SetMaterial(mg)
			Duel.Overlay(tc,mg)
			if Duel.SpecialSummon(tc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)~=0 then
				tc:CompleteProcedure()
				if Duel.IsExistingMatchingCard(c98452268.matfilter,tp,LOCATION_PZONE,0,1,nil,e)
					and Duel.SelectYesNo(tp,aux.Stringid(98452268,3)) then
					Duel.BreakEffect()
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
					local sg=Duel.SelectMatchingCard(tp,c98452268.matfilter,tp,LOCATION_PZONE,0,1,1,nil,e)
					Duel.HintSelection(sg)
					Duel.Overlay(tc,sg)
				end
			end
		end
	end
end
function c98452268.mfilter(c)
	return c:IsType(TYPE_XYZ) and c:IsRank(7)
end
function c98452268.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(c98452268.mfilter,1,nil) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
function c98452268.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and e:GetLabel()==1
end
function c98452268.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(98452268,RESET_EVENT+RESETS_STANDARD,0,1)
	c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(98452268,4))
end
function c98452268.effcon(e)
	return e:GetHandler():GetFlagEffect(98452268)>0
end
function c98452268.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c98452268.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c98452268.penop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end
