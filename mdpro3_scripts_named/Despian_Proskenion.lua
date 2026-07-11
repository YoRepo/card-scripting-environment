--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Despian Proskenion  (ID: 18666161)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Fiend
-- Level: 11
-- ATK 3200 | DEF 3200
-- Setcode: 0x164
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Despia" monster + 1 LIGHT monster + 1 DARK monster
-- During the Main Phase (Quick Effect): You can target 1 Fusion, Synchro, Xyz, or Link Monster in your
-- opponent's GY; banish it, or Special Summon it to your field.
-- When this card destroys an opponent's monster by battle: You can inflict damage to your opponent
-- equal to that monster's original ATK or DEF (whichever is higher).
-- You can only use each effect of "Despian Proskenion" once per turn.
--[[ __CARD_HEADER_END__ ]]

--デスピアン・プロスケニオン
function c18666161.initial_effect(c)
	--fusion procedure
	c:EnableReviveLimit()
	aux.AddFusionProcMix(c,false,true,aux.FilterBoolFunction(Card.IsFusionSetCard,0x164),c18666161.matfilter1,c18666161.matfilter2,nil)
	--special summon or banish
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18666161,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCountLimit(1,18666161)
	e1:SetCondition(c18666161.effcon)
	e1:SetTarget(c18666161.efftg)
	e1:SetOperation(c18666161.effop)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(18666161,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCountLimit(1,18666162)
	e2:SetCondition(aux.bdocon)
	e2:SetTarget(c18666161.damtg)
	e2:SetOperation(c18666161.damop)
	c:RegisterEffect(e2)
end
function c18666161.matfilter1(c)
	return c:IsFusionAttribute(ATTRIBUTE_LIGHT)
end
function c18666161.matfilter2(c)
	return c:IsFusionAttribute(ATTRIBUTE_DARK)
end
function c18666161.effcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or ph==PHASE_MAIN2
end
function c18666161.rmfilter(c,e,tp,check)
	return c:IsType(TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK)
		and (c:IsAbleToRemove() or check and c:IsCanBeSpecialSummoned(e,0,tp,false,false))
end
function c18666161.efftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local check=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_GRAVE) and c18666161.rmfilter(chkc,e,tp,check) end
	if chk==0 then return Duel.IsExistingTarget(c18666161.rmfilter,tp,0,LOCATION_GRAVE,1,nil,e,tp,check) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c18666161.rmfilter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp,check)
end
function c18666161.effop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if aux.NecroValleyNegateCheck(tc) then return end
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and (not tc:IsAbleToRemove() or Duel.SelectOption(tp,1192,1152)==1) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
		end
	end
end
function c18666161.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	local dam=bc:GetBaseAttack()
	if bc:GetBaseAttack()<bc:GetBaseDefense() then dam=bc:GetBaseDefense() end
	if chk==0 then return dam>0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c18666161.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
